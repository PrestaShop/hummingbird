/**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 */

import * as Quantity from '@constants/useQuantityInput-data';
import selectorsMap from '@constants/selectors-map';
import debounce from '@helpers/debounce';
import useAlert from './useAlert';

const useQuantityInput = (selector = selectorsMap.qtyInput.default, delay = Quantity.delay) => {
  const qtyInputNodeList = document.querySelectorAll(selector) as NodeListOf<HTMLElement>;

  if (qtyInputNodeList.length > 0) {
    qtyInputNodeList.forEach((qtyInputWrapper: HTMLDivElement) => {
      const qtyInput = qtyInputWrapper.querySelector<HTMLInputElement>('input');

      if (qtyInput) {
        const incrementButton = qtyInputWrapper.querySelector<HTMLButtonElement>(selectorsMap.qtyInput.increment);
        const decrementButton = qtyInputWrapper.querySelector<HTMLButtonElement>(selectorsMap.qtyInput.decrement);

        if (incrementButton && decrementButton) {
          const qtyInputGroup: Quantity.InputGroup = {qtyInput, incrementButton, decrementButton};
          // The changeQuantity() will be called immediatly and change the input value
          incrementButton.addEventListener('click', () => changeQuantity(qtyInput, 1));
          decrementButton.addEventListener('click', () => changeQuantity(qtyInput, -1));
          // The updateQuantity() will be called after timeout and send the update request with current input value
          incrementButton.addEventListener('click', debounce(async () => {
            updateQuantity(qtyInputGroup, 1);
          }, delay));
          decrementButton.addEventListener('click', debounce(async () => {
            updateQuantity(qtyInputGroup, -1);
          }, delay));

          // If the input element has update URL (e.g. Cart)
          // then convert the buttons when user changed the value manually
          if (qtyInput.hasAttribute('data-update-url')) {
            qtyInput.addEventListener('keyup', () => {
              showConfirmationButtons(qtyInputGroup);
            });
          }
        }
      }
    });
  }
};

const changeQuantity = (qtyInput: HTMLInputElement, change: number) => {
  const state = qtyInput.getAttribute('data-mode');

  // If the confirmation buttons displayed then skip changing the input value
  if (state !== 'confirmation') {
    const currentValue = Number(qtyInput.value);
    const min = (qtyInput.dataset.updateUrl === undefined) ? Number(qtyInput.getAttribute('min')) : 0;
    const newValue = Math.max(currentValue + change, min);

    qtyInput.value = String(newValue);
  }
};

const updateQuantity = async (qtyInputGroup: Quantity.InputGroup, change: number) => {
  const {prestashop} = window;
  const {qtyInput} = qtyInputGroup;
  const state = qtyInput.getAttribute('data-mode');

  // If confirmation buttons displayed and the Cancel button selected then change the buttons to the spin mode
  // else send the update request (user clicked spin buttons or the OK button in the confirmation mode)
  if (state === 'confirmation' && change < 0) {
    showSpinButtons(qtyInputGroup);
  } else {
    const targetValue = Number(qtyInput.value);
    const baseValue = Number(qtyInput.getAttribute('value'));
    const quantity = targetValue - baseValue;

    if (Number.isNaN(targetValue) === false && quantity !== 0) {
      const requestUrl = qtyInput.dataset.updateUrl;

      if (requestUrl !== undefined) {
        const targetButton = getTargetButton(qtyInputGroup, change);
        const targetButtonIcon = targetButton.querySelector<HTMLElement>('i:not(.d-none)');
        const targetButtonSpinner = targetButton.querySelector<HTMLElement>(selectorsMap.qtyInput.spinner);

        toggleButtonSpinner(targetButton, targetButtonIcon, targetButtonSpinner);

        const {productId} = qtyInput.dataset;
        const productAlertSelector = resetAlertContainer(Number(productId));

        try {
          const response = await sendUpdateCartRequest(requestUrl, quantity);

          if (response.ok) {
            const data = await response.json();

            if (data.hasError) {
              const errors = data.errors as Array<string>;

              if (productAlertSelector) {
                errors.forEach((error: string) => {
                  useAlert(error, {type: 'danger', selector: productAlertSelector}).show();
                });
              }
            } else {
              prestashop.emit('updateCart', {
                reason: qtyInput.dataset,
                resp: data,
              });
            }
            // Change the input value based on returned quantity
            qtyInput.value = data.quantity;
            // If user used the confirmation mode, need to update input value in the DOM
            qtyInput.setAttribute('value', data.quantity);
          } else {
            // Something went wrong so call the catch block
            throw response;
          }
        } catch (error) {
          // An error has occurred on update so revert to the value in the DOM
          qtyInput.value = String(baseValue);
          const errorData = error as Response;

          if (errorData.status !== undefined) {
            const errorMsg = `${errorData.statusText}: ${errorData.url}`;
            useAlert(errorMsg, {type: 'danger', selector: productAlertSelector}).show();

            prestashop.emit('handleError', {
              eventType: 'updateProductInCart',
              resp: errorData,
            });
          }
        } finally {
          toggleButtonSpinner(targetButton, targetButtonIcon, targetButtonSpinner);
          showSpinButtons(qtyInputGroup);
        }
      }
    } else {
      // The input value is not a correct number so revert to the value in the DOM
      qtyInput.value = String(baseValue);
      showSpinButtons(qtyInputGroup);
    }
  }
};

const getTargetButton = (qtyInputGroup: Quantity.InputGroup, change: number) => {
  const {incrementButton, decrementButton} = qtyInputGroup;

  return (change > 0) ? incrementButton : decrementButton;
};

const resetAlertContainer = (productId: number) => {
  if (productId) {
    const productAlertSelector = selectorsMap.qtyInput.alert(productId);
    const productAlertContainer = document.querySelector<HTMLDivElement>(productAlertSelector);

    if (productAlertContainer) {
      productAlertContainer.innerHTML = '';
    }
    return productAlertSelector;
  }
  return undefined;
};

const toggleButtonSpinner = (button: HTMLButtonElement, icon: HTMLElement | null, spinner: HTMLElement | null) => {
  button.toggleAttribute('disabled');
  icon?.classList.toggle('d-none');
  spinner?.classList.toggle('d-none');
};

const showSpinButtons = (qtyInputGroup: Quantity.InputGroup) => {
  const {qtyInput, incrementButton, decrementButton} = qtyInputGroup;
  const state = qtyInput.getAttribute('data-mode');

  if (state === 'confirmation') {
    toggleButtonIcon(incrementButton, decrementButton);
    qtyInput.removeAttribute('data-mode');
    const baseValue = qtyInput.getAttribute('value');

    // Maybe user changed the input value manually bu not confirmed
    // so revert the input value based on the value in the DOM
    if (baseValue) {
      qtyInput.value = baseValue;
    }
  }
};

const showConfirmationButtons = (qtyInputGroup: Quantity.InputGroup) => {
  const {qtyInput, incrementButton, decrementButton} = qtyInputGroup;
  const state = qtyInput.getAttribute('data-mode');

  if (state !== 'confirmation') {
    toggleButtonIcon(incrementButton, decrementButton);
    qtyInput.setAttribute('data-mode', 'confirmation');
  }
};

const toggleButtonIcon = (incrementButton: HTMLButtonElement, decrementButton: HTMLButtonElement) => {
  const incrementButtonIcons = incrementButton.querySelectorAll('i') as NodeListOf<HTMLElement>;
  incrementButtonIcons.forEach((icon: HTMLElement) => {
    icon.classList.toggle('d-none');
  });
  const decrementButtonIcons = decrementButton.querySelectorAll('i') as NodeListOf<HTMLElement>;
  decrementButtonIcons.forEach((icon: HTMLElement) => {
    icon.classList.toggle('d-none');
  });
};

const sendUpdateCartRequest = async (updateUrl: string, quantity: number) => {
  const formData = new FormData();
  formData.append('ajax', '1');
  formData.append('action', 'update');
  formData.append('qty', String(Math.abs(quantity)));
  formData.append('op', (quantity > 0) ? 'up' : 'down');

  const response = await fetch(updateUrl, {
    method: 'POST',
    headers: {
      Accept: 'application/json, text/javascript, */*; q=0.01',
    },
    body: formData,
  });

  return response;
};

export default useQuantityInput;
