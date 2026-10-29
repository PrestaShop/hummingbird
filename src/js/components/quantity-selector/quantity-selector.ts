/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */

import {quantitySelector as selectors} from '@constants/selectors-map';

type Context = Theme.QuantitySelector.Context;
type Bounds = Theme.QuantitySelector.Bounds;

export const CHANGED_EVENT = 'quantity:changed';
export const CHANGE_DELAY = 500;

interface InstanceState {
  confirmed: number;
  timer?: number;
}

// One entry per selector root, so instances on the same page never share timers or values.
// Roots removed by an Ajax refresh are garbage collected with their entry.
const instances = new WeakMap<HTMLElement, InstanceState>();

const isContext = (value: string | undefined): value is Context => (
  value === 'product' || value === 'quickview' || value === 'listing' || value === 'cart'
);

export const parseQuantity = (raw: string | null): number | null => {
  if (raw === null || !/^\d+$/.test(raw.trim())) {
    return null;
  }

  return parseInt(raw, 10);
};

export const clamp = (value: number, {min, max}: Bounds): number => {
  const lowered = max === null ? value : Math.min(value, max);

  return Math.max(lowered, min);
};

export const getRoot = (target: EventTarget | null): HTMLElement | null => (
  target instanceof Element ? target.closest<HTMLElement>(selectors.root) : null
);

export const getInput = (root: HTMLElement): HTMLInputElement | null => (
  root.querySelector<HTMLInputElement>(selectors.input)
);

export const getContext = (root: HTMLElement): Context | null => {
  const {psContext} = root.dataset;

  return isContext(psContext) ? psContext : null;
};

export const isLoading = (root: HTMLElement): boolean => root.dataset.psState === 'loading';

export const readBounds = (input: HTMLInputElement): Bounds => {
  const min = parseQuantity(input.getAttribute('min'));
  const max = parseQuantity(input.getAttribute('max'));

  return {
    min: min !== null && min > 0 ? min : 1,
    max: max !== null && max > 0 ? max : null,
  };
};

const getState = (root: HTMLElement, input: HTMLInputElement): InstanceState => {
  let instance = instances.get(root);

  if (!instance) {
    // The server rendered value attribute is the last confirmed quantity (e.g. the cart quantity).
    // It is not clamped: it is the server truth the next cart delta is computed from.
    const rendered = parseQuantity(input.getAttribute('value'));
    instance = {confirmed: rendered ?? readBounds(input).min};
    instances.set(root, instance);
  }

  return instance;
};

export const syncButtons = (root: HTMLElement): void => {
  const input = getInput(root);

  if (!input) {
    return;
  }

  const {min, max} = readBounds(input);
  const value = parseQuantity(input.value) ?? getState(root, input).confirmed;
  const loading = isLoading(root);

  root.querySelector<HTMLButtonElement>(selectors.decrement)
    ?.setAttribute('aria-disabled', String(loading || value <= min));
  root.querySelector<HTMLButtonElement>(selectors.increment)
    ?.setAttribute('aria-disabled', String(loading || (max !== null && value >= max)));
};

// Brings the field back to a valid integer within bounds, falling back to the last confirmed value
export const normalize = (root: HTMLElement): number | null => {
  const input = getInput(root);

  if (!input) {
    return null;
  }

  const parsed = parseQuantity(input.value);
  const value = clamp(parsed ?? getState(root, input).confirmed, readBounds(input));

  if (input.value !== String(value)) {
    input.value = String(value);
  }

  return value;
};

// Sets a confirmed value coming from outside (server response, revert, reset) and returns the shown value.
// Like the rendered value, the confirmed one is not clamped: the next cart delta is computed from it.
export const setValue = (root: HTMLElement, value: number): number | null => {
  const input = getInput(root);

  if (!input) {
    return null;
  }

  const instance = getState(root, input);
  const clamped = clamp(value, readBounds(input));
  instance.confirmed = value;
  input.value = String(clamped);
  input.setAttribute('value', String(clamped));
  syncButtons(root);

  return clamped;
};

// Puts back the last confirmed value, e.g. after the core changed the field on its own
export const restoreValue = (root: HTMLElement): void => {
  const input = getInput(root);

  if (input) {
    setValue(root, getState(root, input).confirmed);
  }
};

export const hasPendingChange = (root: HTMLElement): boolean => instances.get(root)?.timer !== undefined;

export const setLoading = (root: HTMLElement, loading: boolean): void => {
  const input = getInput(root);
  root.dataset.psState = loading ? 'loading' : 'idle';

  if (input) {
    input.readOnly = loading;
    input.setAttribute('aria-busy', String(loading));
  }

  syncButtons(root);
};

export const confirmChange = (root: HTMLElement, force = true): void => {
  const input = getInput(root);

  if (!input || isLoading(root)) {
    return;
  }

  const instance = getState(root, input);
  window.clearTimeout(instance.timer);
  instance.timer = undefined;

  // A delayed change while typing never overwrites a field the user is still editing (e.g. emptied)
  if (!force && parseQuantity(input.value) === null) {
    return;
  }

  const value = normalize(root);
  syncButtons(root);

  if (value === null || value === instance.confirmed) {
    return;
  }

  const previous = instance.confirmed;
  instance.confirmed = value;
  const context = getContext(root);

  if (!context) {
    // e.g. a child theme including components/qty-input.tpl without quantity_context
    console.error('Quantity selector without a valid data-ps-context, the change is not applied: %o', root);
    return;
  }

  root.dispatchEvent(new CustomEvent<Theme.QuantitySelector.QuantityChangedDetail>(CHANGED_EVENT, {
    bubbles: true,
    detail: {
      root, context, value, previous,
    },
  }));
};

export const scheduleChange = (root: HTMLElement): void => {
  const input = getInput(root);

  if (!input) {
    return;
  }

  const instance = getState(root, input);
  window.clearTimeout(instance.timer);
  instance.timer = window.setTimeout(() => {
    instance.timer = undefined;

    if (root.isConnected) {
      confirmChange(root, false);
      return;
    }

    // Meanwhile a refresh replaced the selector (e.g. another cart line updated):
    // carry the pending value over to the new selector, rendered with the server quantity
    const replacement = getRoot(document.getElementById(input.id));
    const replacementInput = replacement && getInput(replacement);

    if (replacement && replacementInput) {
      replacementInput.value = input.value;
      confirmChange(replacement, false);
    }
  }, CHANGE_DELAY);
};

export const step = (root: HTMLElement, delta: number): void => {
  const input = getInput(root);

  if (!input || isLoading(root)) {
    return;
  }

  // From the shown value, even out of bounds: a cart line rendered at 7 with a stock of 5 goes to 5, not 4
  const current = parseQuantity(input.value) ?? getState(root, input).confirmed;
  const next = clamp(current + delta, readBounds(input));

  if (String(next) !== input.value) {
    input.value = String(next);
    syncButtons(root);
    scheduleChange(root);
  }
};
