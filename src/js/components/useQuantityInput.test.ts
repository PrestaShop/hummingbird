/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import initEmitter from '@js/prestashop';
import selectorsMap from '@constants/selectors-map';
import resetHTMLBodyContent from '@helpers/resetBody';
import * as Quantify from '@constants/mocks/useQuantityInput-data';
import EVENTS from '@js/constants/events-map';
import useQuantityInput from './useQuantityInput';

describe('useQuantityInput', () => {
  describe('with update URL', () => {
    beforeAll(() => {
      resetHTMLBodyContent(Quantify.ProductLineTemplate);
      window.prestashop = {};
      window.Theme = {
        ...window.Theme,
        events: EVENTS,
      };
      initEmitter();
      useQuantityInput(selectorsMap.qtyInput.default, Quantify.delay);
    });

    it('should display error with NOK response', async () => {
      const mockedIncrementFetch = mockedResponse(false);
      const incrementButton = getHTMLElement<HTMLButtonElement>(selectorsMap.qtyInput.increment);
      incrementButton.click();
      await debounceTimeout();
      const productLineAlert = getHTMLElement<HTMLDivElement>(selectorsMap.qtyInput.alert(Quantify.AlertId));
      mockedIncrementFetch.mockReset();

      expect(productLineAlert.innerHTML).not.toBe('');
    });

    it('should update value with OK response without error on increment/decrement', async () => {
      const qtyInput = getHTMLElement<HTMLInputElement>('input');
      const qtyMin = '1';
      const qtyValue = '1';
      const spamClicks = 5;
      const incrementExpectedValue = String(spamClicks);
      const decrementExpectedValue = String(spamClicks - 1);
      resetQtyInputValueInDOM(qtyInput, qtyMin, qtyValue);

      const mockedIncrementFetch = mockedResponse(true, false, incrementExpectedValue);
      const incrementButton = getHTMLElement<HTMLButtonElement>(selectorsMap.qtyInput.increment);

      for (let i = 0; i < spamClicks; i += 1) {
        incrementButton.click();
      }

      await debounceTimeout();
      const increasedValue = qtyInput.value;
      mockedIncrementFetch.mockReset();

      const mockedDecrementFetch = mockedResponse(true, false, decrementExpectedValue);
      const decrementButton = getHTMLElement<HTMLButtonElement>(selectorsMap.qtyInput.decrement);
      decrementButton.click();
      await debounceTimeout();
      const decreasedValue = qtyInput.value;
      mockedDecrementFetch.mockReset();

      expect(increasedValue).toEqual(incrementExpectedValue);
      expect(decreasedValue).toEqual(decrementExpectedValue);
    });

    it('should revert value with OK response with error on decrement', async () => {
      const qtyInput = getHTMLElement<HTMLInputElement>('input');
      const qtyMin = '5';
      const qtyValue = '5';
      resetQtyInputValueInDOM(qtyInput, qtyMin, qtyValue);

      const mockedDecrementFetch = mockedResponse(true, true, qtyMin);
      const decrementButton = getHTMLElement<HTMLButtonElement>(selectorsMap.qtyInput.decrement);
      decrementButton.click();
      await debounceTimeout();
      const decreasedValue = qtyInput.value;
      mockedDecrementFetch.mockReset();

      expect(decreasedValue).toEqual(qtyMin);
    });

    it('should revert the value if is not an integer number', async () => {
      const qtyInput = getHTMLElement<HTMLInputElement>('input');
      const baseValue = qtyInput.value;
      qtyInput.value = '1.1';
      qtyInput.dispatchEvent(new Event('keyup'));

      const incrementButton = getHTMLElement<HTMLButtonElement>(selectorsMap.qtyInput.increment);
      incrementButton.click();
      await debounceTimeout();

      expect(qtyInput.value).toEqual(baseValue);
    });

    it('should display confirmation buttons on keyup', () => {
      const qtyInput = getHTMLElement<HTMLInputElement>('input');
      qtyInput.value = '1';
      qtyInput.dispatchEvent(new Event('keyup'));

      const decrementButton = getHTMLElement<HTMLButtonElement>(selectorsMap.qtyInput.decrement);
      const cancelIcon = getHTMLElement<HTMLElement>(selectorsMap.qtyInput.confirm, decrementButton);

      const incrementButton = getHTMLElement<HTMLButtonElement>(selectorsMap.qtyInput.increment);
      const submitIcon = getHTMLElement<HTMLElement>(selectorsMap.qtyInput.confirm, incrementButton);

      expect(cancelIcon.classList.toString()).toEqual(expect.not.stringContaining('d-none'));
      expect(submitIcon.classList.toString()).toEqual(expect.not.stringContaining('d-none'));
    });

    it('should hide confirmation buttons on decrement', async () => {
      const qtyInput = getHTMLElement<HTMLInputElement>('input');
      qtyInput.dispatchEvent(new Event('keydown'));

      const decrementButton = getHTMLElement<HTMLButtonElement>(selectorsMap.qtyInput.decrement);
      decrementButton.click();
      await debounceTimeout();
      const cancelIcon = getHTMLElement<HTMLElement>(selectorsMap.qtyInput.confirm, decrementButton);

      expect(cancelIcon.classList.toString()).toEqual(expect.stringContaining('d-none'));
    });

    it('should update value in confirmation mode with OK response without error on increment', async () => {
      const qtyInput = getHTMLElement<HTMLInputElement>('input');
      const qtyMin = '1';
      const qtyValue = '1';
      const confirmedExpectedValue = '5';
      resetQtyInputValueInDOM(qtyInput, qtyMin, qtyValue);
      qtyInput.dispatchEvent(new Event('keydown'));

      const mockedIncrementFetch = mockedResponse(true, false, confirmedExpectedValue);
      const incrementButton = getHTMLElement<HTMLButtonElement>(selectorsMap.qtyInput.increment);
      incrementButton.click();
      await debounceTimeout();
      const increasedValue = qtyInput.value;
      mockedIncrementFetch.mockReset();

      expect(increasedValue).toEqual(confirmedExpectedValue);
    });

    it('should revert the value on NaN input', async () => {
      const qtyInput = getHTMLElement<HTMLInputElement>('input');
      qtyInput.value = 'dummy';

      const decrementButton = getHTMLElement<HTMLButtonElement>(selectorsMap.qtyInput.decrement);
      decrementButton.click();
      await debounceTimeout();

      expect(window.fetch).toHaveBeenCalledTimes(0);
      expect(qtyInput.value).toEqual(qtyInput.getAttribute('value'));
    });
  });

  describe('without update URL', () => {
    beforeAll(() => {
      resetHTMLBodyContent(Quantify.ProductTemplate);
      window.prestashop = {};
      initEmitter();
      useQuantityInput(selectorsMap.qtyInput.modal, Quantify.delay);
    });

    it('should update value on increment/decrement without POST request', () => {
      const qtyInput = getHTMLElement<HTMLInputElement>('input');
      const qtyMin = '1';
      const qtyValue = '1';
      const incrementExpectedValue = '2';
      const decrementExpectedValue = '1';
      resetQtyInputValueInDOM(qtyInput, qtyMin, qtyValue);

      const incrementButton = getHTMLElement<HTMLButtonElement>(selectorsMap.qtyInput.increment);
      incrementButton.click();
      const increasedValue = qtyInput.value;

      const decrementButton = getHTMLElement<HTMLButtonElement>(selectorsMap.qtyInput.decrement);
      decrementButton.click();
      const decreasedValue = qtyInput.value;

      expect(window.fetch).toHaveBeenCalledTimes(0);
      expect(increasedValue).toEqual(incrementExpectedValue);
      expect(decreasedValue).toEqual(decrementExpectedValue);
    });
  });
});

const mockedResponse = (ok: boolean, hasError?: boolean, qty?: string): jest.Mock => {
  const mockedFetch = jest.fn();

  if (ok) {
    if (hasError) {
      mockedFetch.mockResolvedValue({
        ok: true,
        json: async () => ({
          hasError: true,
          errors: ['The minimum purchase order...'],
          quantity: qty,
        }),
      } as Response);
    } else {
      mockedFetch.mockResolvedValue({
        ok: true,
        json: async () => ({
          quantity: qty,
        }),
      } as Response);
    }
  } else {
    mockedFetch.mockResolvedValue({
      status: 404,
      statusText: 'Not found',
      url: '#',
    } as Response);
  }

  window.fetch = mockedFetch;

  return mockedFetch;
};

const debounceTimeout = async () => new Promise((fn) => { setTimeout(fn, Quantify.delay); });

const getHTMLElement = <Type extends HTMLElement>(selector: string, parent?: Type): Type => {
  const parentElement = parent ?? document;
  const element = parentElement.querySelector<Type>(selector);

  if (element) {
    return element;
  }

  throw Error(`The ${selector} can not be found here.`);
};

const resetQtyInputValueInDOM = (qtyInput: HTMLInputElement, qtyMin: string, qtyValue: string): void => {
  qtyInput.setAttribute('min', qtyMin);
  qtyInput.setAttribute('value', qtyValue);
};
