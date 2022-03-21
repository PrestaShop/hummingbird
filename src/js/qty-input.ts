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

import selectorsMap from '@constants/selectors-map';
import useAlert from './components/useAlert';

const initQuantityInput = (selector = selectorsMap.qtyInput.default) => {
  const qtyInputNodeList = document.querySelectorAll(selector) as NodeListOf<Element>;

  if (qtyInputNodeList.length > 0) {
    qtyInputNodeList.forEach((qtyInputWrapper: HTMLInputElement) => {
      const qtyInput = qtyInputWrapper.querySelector('input');

      if (qtyInput) {
        const incrementButton = qtyInputWrapper?.querySelector(selectorsMap.qtyInput.increment);
        incrementButton?.addEventListener('click', (event) => changeQuantity(event, qtyInput, 1));
        const decrementButton = qtyInputWrapper?.querySelector(selectorsMap.qtyInput.decrement);
        decrementButton?.addEventListener('click', (event) => changeQuantity(event, qtyInput, -1));
      }
    });
  }
};

function changeQuantity(event: Event, qtyInput: HTMLInputElement, change: number): void {
  const quantity = Number(qtyInput.value);

  if (quantity) {
    const min = Number(qtyInput.getAttribute('min')) ?? 0;
    const newValue = Math.max(quantity + change, min);
    qtyInput.value = String(newValue);

    const requestUrl = (change > 0) ? qtyInput.dataset.upUrl : qtyInput.dataset.downUrl;

    if (requestUrl !== undefined) {
      const {prestashop} = window;

      const targetButton = event.target as HTMLElement;
      const targetButtonIcon = targetButton.querySelector<HTMLElement>(selectorsMap.qtyInput.icon);
      const targetButtonSpinner = targetButton.querySelector<HTMLElement>(selectorsMap.qtyInput.spinner);

      toggleSpinner(targetButton, targetButtonIcon, targetButtonSpinner);

      sendUpdateCartRequest(requestUrl)
        .then((response) => {
          toggleSpinner(targetButton, targetButtonIcon, targetButtonSpinner);

          return response.json();
        })
        .then((data) => {
          const {productId: pid} = qtyInput.dataset;
          let alertSelector: string;

          if (pid) {
            alertSelector = selectorsMap.cart.alert.replace('{pid}', pid);
            const productLineAlert = document.querySelector<HTMLElement>(alertSelector);

            if (productLineAlert) {
              productLineAlert.innerHTML = '';
            }
          }

          if (data.hasError) {
            const errors = data.errors as Array<string>;
            errors.forEach((error: string) => {
              useAlert(error, {type: 'danger', selector: alertSelector}).show();
            });
          } else {
            prestashop.emit('updateCart', {
              reason: qtyInput.dataset,
              resp: data,
            });
          }
        })
        .catch((error) => {
          prestashop.emit('handleError', {
            eventType: 'updateProductInCart',
            resp: error,
          });
        });
    }
  }
}

function toggleSpinner(button: HTMLElement, icon: HTMLElement | null, spinner: HTMLElement | null) {
  button.toggleAttribute('disabled');
  icon?.classList.toggle('d-none');
  spinner?.classList.toggle('d-none');
}

async function sendUpdateCartRequest(url: string) {
  const formData = new FormData();
  formData.append('ajax', '1');
  formData.append('action', 'update');

  const response = await fetch(url, {
    method: 'POST',
    headers: {
      Accept: 'application/json, text/javascript, */*; q=0.01',
    },
    body: formData,
  });

  return response;
}

export default initQuantityInput;
