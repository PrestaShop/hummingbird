/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */

import initEmitter from '@js/prestashop';
import EVENTS from '@js/constants/events-map';
import resetHTMLBodyContent from '@helpers/resetBody';
import {quantitySelector as selectors} from '@constants/selectors-map';
import initQuantitySelectors from './index';
import {
  CHANGE_DELAY, clamp, normalize, parseQuantity,
} from './quantity-selector';

interface FixtureOptions {
  id: string;
  // An empty context stands for a template include without quantity_context
  context: Theme.QuantitySelector.Context | '';
  value?: number;
  min?: number;
  max?: number;
  data?: Partial<Theme.QuantitySelector.CartData>;
  idProduct?: number;
  idProductAttribute?: number;
}

const selectorMarkup = ({
  id, context, value = 1, min = 1, max, data,
}: FixtureOptions): string => `
  <div data-ps-component="quantity-selector" data-ps-context="${context}" data-ps-state="idle"
    ${data ? `data-ps-data='${JSON.stringify(data)}'` : ''} id="root-${id}">
    <button type="button" data-ps-action="quantity-decrement" aria-controls="${id}"></button>
    <input type="number" step="1" name="qty" id="${id}" data-ps-ref="quantity-input"
      value="${value}" min="${min}" ${max ? `max="${max}"` : ''}>
    <button type="button" data-ps-action="quantity-increment" aria-controls="${id}"></button>
    <span data-ps-ref="quantity-status" ${data ? 'data-ps-data="Quantity updated to %quantity%"' : ''}></span>
  </div>
`;

const formMarkup = (options: FixtureOptions): string => `
  <form>
    <input type="hidden" name="id_product" value="${options.idProduct ?? 1}" data-ps-ref="product-id">
    ${options.idProductAttribute
    ? `<input type="hidden" name="id_product_attribute" value="${options.idProductAttribute}" data-ps-ref="product-attribute-id">`
    : ''}
    ${selectorMarkup(options)}
  </form>
`;

const cartData = (idProduct: number): Theme.QuantitySelector.CartData => ({
  updateUrl: `/cart?update=${idProduct}`,
  idProduct,
  idProductAttribute: 0,
  idCustomization: 0,
});

const getRootById = (id: string): HTMLElement => document.getElementById(`root-${id}`) as HTMLElement;
const getInputById = (id: string): HTMLInputElement => document.getElementById(id) as HTMLInputElement;
const getButton = (id: string, action: 'increment' | 'decrement'): HTMLButtonElement => (
  getRootById(id).querySelector<HTMLButtonElement>(selectors[action]) as HTMLButtonElement
);

const flushPromises = async (): Promise<void> => {
  for (let i = 0; i < 5; i += 1) {
    // eslint-disable-next-line no-await-in-loop
    await Promise.resolve();
  }
};

const mockFetch = (body: Theme.QuantitySelector.CartUpdateResponse, ok = true): jest.Mock => {
  const mocked = jest.fn().mockResolvedValue({
    ok,
    status: ok ? 200 : 500,
    statusText: ok ? 'OK' : 'Server error',
    url: '/cart',
    json: async () => body,
  });
  window.fetch = mocked;

  return mocked;
};

const addToCart = (reason: Theme.QuantitySelector.AddToCartReason): void => {
  window.prestashop.emit(EVENTS.updateCart, {reason: {linkAction: 'add-to-cart', ...reason}});
  jest.advanceTimersByTime(0);
};

const typeValue = (input: HTMLInputElement, value: string): void => {
  input.value = value;
  input.dispatchEvent(new Event('input', {bubbles: true}));
};

describe('quantity selector helpers', () => {
  it('parses positive integers only', () => {
    expect(parseQuantity('12')).toBe(12);
    expect(parseQuantity(' 3 ')).toBe(3);
    expect(parseQuantity('00')).toBe(0);
    expect(parseQuantity('')).toBeNull();
    expect(parseQuantity('1.5')).toBeNull();
    expect(parseQuantity('-2')).toBeNull();
    expect(parseQuantity('abc')).toBeNull();
  });

  it('clamps to min and max', () => {
    expect(clamp(0, {min: 1, max: null})).toBe(1);
    expect(clamp(50, {min: 1, max: 10})).toBe(10);
    expect(clamp(5, {min: 3, max: 10})).toBe(5);
  });

  it('normalizes an invalid field to the last confirmed value', () => {
    resetHTMLBodyContent(selectorMarkup({
      id: 'n', context: 'listing', value: 4, min: 2,
    }));
    const input = getInputById('n');

    input.value = '';
    expect(normalize(getRootById('n'))).toBe(4);
    expect(input.value).toBe('4');

    input.value = '0';
    expect(normalize(getRootById('n'))).toBe(2);
  });
});

describe('quantity selector behaviour', () => {
  let emitSpy: jest.SpyInstance;

  beforeAll(() => {
    window.prestashop = {};
    window.Theme = {...window.Theme, events: EVENTS};
    initEmitter();
    initQuantitySelectors();
    // A second init must not bind the listeners twice
    initQuantitySelectors();
  });

  beforeEach(() => {
    jest.useFakeTimers();
    emitSpy = jest.spyOn(window.prestashop, 'emit');
  });

  afterEach(() => {
    jest.useRealTimers();
    emitSpy.mockRestore();
  });

  describe('bounds', () => {
    beforeEach(() => {
      resetHTMLBodyContent(selectorMarkup({
        id: 'b', context: 'listing', value: 2, min: 2, max: 3,
      }));
      initQuantitySelectors();
      document.querySelectorAll<HTMLElement>(selectors.root).forEach((root) => {
        root.querySelector<HTMLInputElement>(selectors.input)?.dispatchEvent(new Event('input', {bubbles: true}));
      });
    });

    it('disables decrement at min and increment at max', () => {
      expect(getButton('b', 'decrement').getAttribute('aria-disabled')).toBe('true');
      expect(getButton('b', 'increment').getAttribute('aria-disabled')).toBe('false');

      getButton('b', 'increment').click();

      expect(getInputById('b').value).toBe('3');
      expect(getButton('b', 'increment').getAttribute('aria-disabled')).toBe('true');
      expect(getButton('b', 'decrement').getAttribute('aria-disabled')).toBe('false');

      getButton('b', 'increment').click();
      expect(getInputById('b').value).toBe('3');
    });

    it('ignores a click on a disabled button', () => {
      getButton('b', 'decrement').click();

      expect(getInputById('b').value).toBe('2');
    });
  });

  describe('product context', () => {
    beforeEach(() => {
      resetHTMLBodyContent(formMarkup({id: 'quantity_wanted', context: 'product'}));
    });

    it('emits a single updateProduct after spam clicks', () => {
      for (let i = 0; i < 5; i += 1) {
        getButton('quantity_wanted', 'increment').click();
      }

      expect(emitSpy).not.toHaveBeenCalledWith(EVENTS.updateProduct, expect.anything());
      jest.advanceTimersByTime(CHANGE_DELAY);

      expect(getInputById('quantity_wanted').value).toBe('6');
      expect(emitSpy).toHaveBeenCalledTimes(1);
      expect(emitSpy).toHaveBeenCalledWith(EVENTS.updateProduct, {eventType: 'updatedProductQuantity'});
    });

    it('confirms right away on Enter', () => {
      const input = getInputById('quantity_wanted');
      typeValue(input, '4');
      input.dispatchEvent(new KeyboardEvent('keydown', {key: 'Enter', bubbles: true}));

      expect(emitSpy).toHaveBeenCalledWith(EVENTS.updateProduct, {eventType: 'updatedProductQuantity'});

      // The pending delayed change does nothing more
      jest.advanceTimersByTime(CHANGE_DELAY);
      expect(emitSpy).toHaveBeenCalledTimes(1);
    });

    it('keeps an emptied field while typing, then restores it on change', () => {
      const input = getInputById('quantity_wanted');
      typeValue(input, '');
      jest.advanceTimersByTime(CHANGE_DELAY);

      expect(input.value).toBe('');
      expect(emitSpy).not.toHaveBeenCalled();

      input.dispatchEvent(new Event('change', {bubbles: true}));
      expect(input.value).toBe('1');
      expect(emitSpy).not.toHaveBeenCalled();
    });

    it('blocks non integer characters', () => {
      const event = new KeyboardEvent('keydown', {key: 'e', bubbles: true, cancelable: true});
      getInputById('quantity_wanted').dispatchEvent(event);

      expect(event.defaultPrevented).toBe(true);
    });

    it('keeps the browser zoom shortcuts', () => {
      const event = new KeyboardEvent('keydown', {
        key: '-', ctrlKey: true, bubbles: true, cancelable: true,
      });
      getInputById('quantity_wanted').dispatchEvent(event);

      expect(event.defaultPrevented).toBe(false);
    });

    it('blocks the wheel only while the field has focus', () => {
      const input = getInputById('quantity_wanted');
      const wheel = (): WheelEvent => {
        const event = new WheelEvent('wheel', {bubbles: true, cancelable: true});
        input.dispatchEvent(event);

        return event;
      };

      input.focus();
      expect(wheel().defaultPrevented).toBe(true);

      input.blur();
      expect(wheel().defaultPrevented).toBe(false);
    });

    it('keeps a change made while the product refreshes', () => {
      getButton('quantity_wanted', 'increment').click();
      jest.advanceTimersByTime(CHANGE_DELAY);
      getButton('quantity_wanted', 'increment').click();

      // The core answers the first refresh while the second change is pending
      window.prestashop.emit(EVENTS.updatedProduct, {});
      jest.advanceTimersByTime(CHANGE_DELAY);

      expect(getInputById('quantity_wanted').value).toBe('3');
      expect(emitSpy.mock.calls.filter(([name]) => name === EVENTS.updateProduct)).toHaveLength(2);
    });

    it('restores its value when the core resets it after adding another product', () => {
      resetHTMLBodyContent(formMarkup({
        id: 'quantity_wanted', context: 'product', idProduct: 4, value: 3, min: 3,
      }));
      const input = getInputById('quantity_wanted');

      // The core resets #quantity_wanted to 1 after any add to cart
      input.value = '1';
      addToCart({idProduct: 9});

      expect(input.value).toBe('3');
      expect(getButton('quantity_wanted', 'decrement').getAttribute('aria-disabled')).toBe('true');
    });
  });

  describe('quickview context', () => {
    it('follows the minimum set by the core after a combination change', () => {
      resetHTMLBodyContent(formMarkup({id: 'quantity_wanted', context: 'quickview', value: 3}));
      const input = getInputById('quantity_wanted');

      input.setAttribute('min', '2');
      input.value = '2';
      window.prestashop.emit(EVENTS.updatedProduct, {});

      expect(getButton('quantity_wanted', 'decrement').getAttribute('aria-disabled')).toBe('true');
    });
  });

  describe('missing context', () => {
    it('reports it and still normalizes the field', () => {
      const errorSpy = jest.spyOn(console, 'error').mockImplementation(() => undefined);
      resetHTMLBodyContent(selectorMarkup({id: 'no-context', context: ''}));
      const input = getInputById('no-context');

      typeValue(input, '0');
      input.dispatchEvent(new Event('change', {bubbles: true}));

      expect(input.value).toBe('1');
      typeValue(input, '4');
      input.dispatchEvent(new Event('change', {bubbles: true}));

      expect(errorSpy).toHaveBeenCalledTimes(1);
      errorSpy.mockRestore();
    });
  });

  describe('cart context', () => {
    beforeEach(() => {
      resetHTMLBodyContent(selectorMarkup({
        id: 'c', context: 'cart', value: 2, data: cartData(7),
      }));
    });

    it('sends one update with the delta and reconciles the value', async () => {
      const fetchMock = mockFetch({quantity: 5});

      getButton('c', 'increment').click();
      getButton('c', 'increment').click();
      getButton('c', 'increment').click();
      jest.advanceTimersByTime(CHANGE_DELAY);
      await flushPromises();

      expect(fetchMock).toHaveBeenCalledTimes(1);
      const body = fetchMock.mock.calls[0][1].body as FormData;
      expect(body.get('qty')).toBe('3');
      expect(body.get('op')).toBe('up');

      expect(getInputById('c').value).toBe('5');
      expect(getInputById('c').getAttribute('value')).toBe('5');
      expect(getRootById('c').dataset.psState).toBe('idle');
      expect(getRootById('c').querySelector(selectors.status)?.textContent).toBe('Quantity updated to 5');
      expect(emitSpy).toHaveBeenCalledWith(EVENTS.updateCart, expect.objectContaining({
        reason: expect.objectContaining({idProduct: 7}),
      }));
    });

    it('sends a down update when typing a lower value', async () => {
      const fetchMock = mockFetch({quantity: 1});
      typeValue(getInputById('c'), '1');
      getInputById('c').dispatchEvent(new Event('change', {bubbles: true}));
      await flushPromises();

      const body = fetchMock.mock.calls[0][1].body as FormData;
      expect(body.get('qty')).toBe('1');
      expect(body.get('op')).toBe('down');
    });

    it('reverts the value on a failed request', async () => {
      mockFetch({}, false);
      getButton('c', 'increment').click();
      jest.advanceTimersByTime(CHANGE_DELAY);
      await flushPromises();

      expect(getInputById('c').value).toBe('2');
      expect(emitSpy).toHaveBeenCalledWith(EVENTS.handleError, expect.objectContaining({
        eventType: 'updateProductInCart',
      }));
    });

    it('keeps the server quantity when the update is refused', async () => {
      mockFetch({hasError: true, errors: ['Not enough stock'], quantity: 3});
      getButton('c', 'increment').click();
      getButton('c', 'increment').click();
      jest.advanceTimersByTime(CHANGE_DELAY);
      await flushPromises();

      // Neither the requested 4 nor the previous 2
      expect(getInputById('c').value).toBe('3');
      // A refused update has no cart to refresh the page with
      expect(emitSpy).not.toHaveBeenCalledWith(EVENTS.updateCart, expect.anything());
    });

    it('never reverts an update the server answered', async () => {
      const fetchMock = mockFetch({});
      fetchMock.mockResolvedValueOnce({
        ok: true,
        status: 200,
        json: async () => {
          throw new SyntaxError('Unexpected token');
        },
      });

      getButton('c', 'increment').click();
      jest.advanceTimersByTime(CHANGE_DELAY);
      await flushPromises();

      expect(getInputById('c').value).toBe('3');

      // The next delta starts from the quantity the server applied
      getButton('c', 'increment').click();
      jest.advanceTimersByTime(CHANGE_DELAY);
      await flushPromises();

      const body = fetchMock.mock.calls[1][1].body as FormData;
      expect(body.get('qty')).toBe('1');
      expect(body.get('op')).toBe('up');
    });

    it('never removes the line at min', () => {
      resetHTMLBodyContent(selectorMarkup({
        id: 'c', context: 'cart', value: 1, data: cartData(7),
      }));
      const fetchMock = mockFetch({quantity: 1});

      getButton('c', 'decrement').click();
      getButton('c', 'decrement').click();
      jest.advanceTimersByTime(CHANGE_DELAY);

      expect(getInputById('c').value).toBe('1');
      expect(fetchMock).not.toHaveBeenCalled();
    });

    it('steps from the shown value when the line is above the stock', async () => {
      resetHTMLBodyContent(selectorMarkup({
        id: 'c', context: 'cart', value: 7, max: 5, data: cartData(7),
      }));
      const fetchMock = mockFetch({quantity: 5});

      getButton('c', 'decrement').click();
      expect(getInputById('c').value).toBe('5');

      jest.advanceTimersByTime(CHANGE_DELAY);
      await flushPromises();

      const body = fetchMock.mock.calls[0][1].body as FormData;
      expect(body.get('qty')).toBe('2');
      expect(body.get('op')).toBe('down');
    });

    it('keeps a pending change when another line refresh replaces the line', async () => {
      const fetchMock = mockFetch({quantity: 3});

      getButton('c', 'increment').click();
      // The core re-renders the cart lines with the server quantity
      resetHTMLBodyContent(selectorMarkup({
        id: 'c', context: 'cart', value: 2, data: cartData(7),
      }));
      jest.advanceTimersByTime(CHANGE_DELAY);
      await flushPromises();

      expect(fetchMock).toHaveBeenCalledTimes(1);
      const body = fetchMock.mock.calls[0][1].body as FormData;
      expect(body.get('qty')).toBe('1');
      expect(body.get('op')).toBe('up');
      expect(getInputById('c').value).toBe('3');
    });
  });

  describe('many instances on one page', () => {
    beforeEach(() => {
      resetHTMLBodyContent(`
        ${selectorMarkup({
    id: 'cart-line', context: 'cart', value: 1, data: cartData(9),
  })}
        ${formMarkup({id: 'listing-a', context: 'listing', idProduct: 3})}
        ${formMarkup({id: 'listing-b', context: 'listing', idProduct: 3})}
        ${formMarkup({id: 'quantity_wanted', context: 'quickview', idProduct: 4})}
      `);
    });

    it('keeps values, timers and requests independent', async () => {
      const fetchMock = mockFetch({quantity: 2});

      getButton('listing-a', 'increment').click();
      getButton('quantity_wanted', 'increment').click();
      getButton('quantity_wanted', 'increment').click();
      jest.advanceTimersByTime(CHANGE_DELAY - 100);
      getButton('cart-line', 'increment').click();
      jest.advanceTimersByTime(100);

      // The listing and quickview changes were not delayed by the later cart click
      expect(getInputById('listing-a').value).toBe('2');
      expect(getInputById('listing-b').value).toBe('1');
      expect(getInputById('quantity_wanted').value).toBe('3');
      expect(fetchMock).not.toHaveBeenCalled();

      jest.advanceTimersByTime(CHANGE_DELAY);
      await flushPromises();

      expect(fetchMock).toHaveBeenCalledTimes(1);
      expect(getInputById('cart-line').value).toBe('2');
      // A quickview never refreshes the product page
      expect(emitSpy).not.toHaveBeenCalledWith(EVENTS.updateProduct, expect.anything());
    });

    it('resets only the selectors of the added product', () => {
      getButton('listing-a', 'increment').click();
      getButton('listing-b', 'increment').click();
      getButton('quantity_wanted', 'increment').click();
      getButton('cart-line', 'increment').click();
      mockFetch({quantity: 2});

      window.prestashop.emit(EVENTS.updateCart, {reason: {idProduct: 3, linkAction: 'add-to-cart'}});
      jest.advanceTimersByTime(0);

      expect(getInputById('listing-a').value).toBe('1');
      expect(getInputById('listing-b').value).toBe('1');
      expect(getInputById('quantity_wanted').value).toBe('2');
      expect(getInputById('cart-line').value).toBe('2');
    });
  });

  describe('minimal quantity after an add to cart', () => {
    const cartLine = (cartQuantity: number, idProductAttribute = 0, idCustomization = 0) => ({
      id_product: '6',
      id_product_attribute: String(idProductAttribute),
      id_customization: String(idCustomization),
      minimal_quantity: '5',
      cart_quantity: String(cartQuantity),
    });
    const addMinimalToCart = (cartQuantity: number): void => addToCart({
      idProduct: 6, idProductAttribute: 0, cart: {products: [cartLine(cartQuantity)]},
    });

    beforeEach(() => {
      resetHTMLBodyContent(formMarkup({
        id: 'listing-min', context: 'listing', idProduct: 6, value: 5, min: 5,
      }));
    });

    it('lowers the minimum to 1 once the cart holds the minimal quantity', () => {
      addMinimalToCart(5);

      expect(getInputById('listing-min').value).toBe('1');
      expect(getInputById('listing-min').getAttribute('min')).toBe('1');
      expect(getButton('listing-min', 'decrement').getAttribute('aria-disabled')).toBe('true');
    });

    it('requires only what is missing to reach the minimal quantity', () => {
      addMinimalToCart(2);

      expect(getInputById('listing-min').value).toBe('3');
      expect(getInputById('listing-min').getAttribute('min')).toBe('3');
    });

    it('leaves the listing of another combination untouched', () => {
      resetHTMLBodyContent(formMarkup({
        id: 'listing-min', context: 'listing', idProduct: 6, idProductAttribute: 12, value: 6, min: 5,
      }));

      addToCart({idProduct: 6, idProductAttribute: 11, cart: {products: [cartLine(5, 11)]}});

      expect(getInputById('listing-min').value).toBe('6');
      expect(getInputById('listing-min').getAttribute('min')).toBe('5');
    });

    it('counts the line without customization only, like the core', () => {
      addToCart({idProduct: 6, cart: {products: [cartLine(4, 0, 8), cartLine(2)]}});

      expect(getInputById('listing-min').getAttribute('min')).toBe('3');
    });
  });
});
