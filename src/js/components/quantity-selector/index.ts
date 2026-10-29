/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */

import {quantitySelector as selectors} from '@constants/selectors-map';
import updateCartLine from './cart-quantity';
import {refreshProduct, resetAddedSelectors, syncProductSelectors} from './product-quantity';
import {
  CHANGED_EVENT, confirmChange, getContext, getRoot, scheduleChange, step, syncButtons,
} from './quantity-selector';

const ENTER_KEY = 'Enter';
// type="number" accepts these characters, quantities are positive integers only
const BLOCKED_KEYS = ['e', 'E', '+', '-', '.', ','];

let initialized = false;

const isQuantityInput = (target: EventTarget | null): target is HTMLInputElement => (
  target instanceof HTMLInputElement && target.matches(selectors.input)
);

const onClick = (event: MouseEvent): void => {
  const button = event.target instanceof Element
    ? event.target.closest<HTMLButtonElement>(`${selectors.increment}, ${selectors.decrement}`)
    : null;
  const root = getRoot(button);

  if (!button || !root || button.getAttribute('aria-disabled') === 'true') {
    return;
  }

  step(root, button.matches(selectors.increment) ? 1 : -1);
};

const onInput = (event: Event): void => {
  const root = getRoot(event.target);

  if (root && isQuantityInput(event.target)) {
    syncButtons(root);
    scheduleChange(root);
  }
};

const onChange = (event: Event): void => {
  const root = getRoot(event.target);

  if (root && isQuantityInput(event.target)) {
    confirmChange(root);
  }
};

const onKeydown = (event: KeyboardEvent): void => {
  const root = getRoot(event.target);

  if (!root || !isQuantityInput(event.target)) {
    return;
  }

  // Shortcuts such as Ctrl/Cmd + - (zoom out) keep working
  if (BLOCKED_KEYS.indexOf(event.key) !== -1 && !event.ctrlKey && !event.metaKey && !event.altKey) {
    event.preventDefault();
    return;
  }

  if (event.key === ENTER_KEY) {
    // In the cart, Enter only confirms the line. Elsewhere, it keeps submitting the add to cart form.
    if (getContext(root) === 'cart') {
      event.preventDefault();
    }

    confirmChange(root);
  }
};

// A focused number input changes its value on scroll, which is never intended for a quantity.
// The non passive wheel listener only lives on the focused field, so page scrolling is never slowed down.
const onWheel = (event: WheelEvent): void => event.preventDefault();

const onFocusin = (event: FocusEvent): void => {
  if (isQuantityInput(event.target)) {
    event.target.addEventListener('wheel', onWheel, {passive: false});
  }
};

const onFocusout = (event: FocusEvent): void => {
  if (isQuantityInput(event.target)) {
    event.target.removeEventListener('wheel', onWheel);
  }
};

const onChanged = (event: Event): void => {
  const {detail} = event as CustomEvent<Theme.QuantitySelector.QuantityChangedDetail>;

  if (detail.context === 'cart') {
    updateCartLine(detail);
  }

  if (detail.context === 'product') {
    refreshProduct();
  }
};

// Listeners are delegated to the document: selectors injected by Ajax (cart refresh,
// quickview, product list) work without any re-initialization.
const initQuantitySelectors = (): void => {
  if (initialized) {
    return;
  }

  initialized = true;

  const {prestashop, Theme: {events}} = window;

  document.addEventListener('click', onClick);
  document.addEventListener('input', onInput);
  document.addEventListener('change', onChange);
  document.addEventListener('keydown', onKeydown);
  document.addEventListener('focusin', onFocusin);
  document.addEventListener('focusout', onFocusout);
  document.addEventListener(CHANGED_EVENT, onChanged);

  prestashop.on(events.updatedProduct, syncProductSelectors);
  prestashop.on(events.updateCart, (event: {reason?: Theme.QuantitySelector.AddToCartReason}) => {
    // Let the core reset #quantity_wanted to 1 first, then put the right values back
    window.setTimeout(() => resetAddedSelectors(event?.reason), 0);
  });

  document.querySelectorAll<HTMLElement>(selectors.root).forEach(syncButtons);
};

export default initQuantitySelectors;
