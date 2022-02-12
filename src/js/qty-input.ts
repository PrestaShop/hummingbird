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
import SelectorsMap from './selectors-map';

export default function initQuantityInput(selector = SelectorsMap.qtyInput.default) {
  const qtyInputList = document.querySelectorAll(selector);
  const decrementIcon = '&#xE15B;';
  const incrementIcon = '&#xE145;';
  if (qtyInputList) {
    qtyInputList.forEach(function(qtyInput) {
      const qtyInputWrapper = qtyInput.parentNode;
      if (qtyInputWrapper && qtyInputWrapper.childElementCount === 1) {
        let decrementButton = createSpinButton(decrementIcon);
        decrementButton.addEventListener('click', () => changeQuantity(<HTMLInputElement>qtyInput, -1));
        let incrementButton = createSpinButton(incrementIcon);
        incrementButton.addEventListener('click', () => changeQuantity(<HTMLInputElement>qtyInput, 1));
        qtyInputWrapper.insertBefore(decrementButton, qtyInput);
        qtyInputWrapper.appendChild(incrementButton);
      }
    });
  }
}

function createSpinButton(iconText: string) {
  let spinButton = document.createElement('button');
  spinButton.type = 'button';
  spinButton.classList.add('btn');
  let spinIcon = document.createElement('i');
  spinIcon.classList.add('material-icons');
  spinIcon.innerHTML = iconText;
  spinButton.appendChild(spinIcon);
  return spinButton;
}

function changeQuantity(qtyInput: HTMLInputElement, change: number) {
  const quantity = Number(qtyInput.value);
  const min = Number(qtyInput.getAttribute('min')) ?? 1;
  const newValue = Math.max(quantity + change, min);
  qtyInput.value = String(newValue);
  const requestUrl = (change > 0) ? qtyInput.dataset.upUrl : qtyInput.dataset.downUrl;
  if (requestUrl !== undefined) {
    sendUpdateQuantityInCartRequest(qtyInput, requestUrl);
  }
}

function sendUpdateQuantityInCartRequest(qtyInput: HTMLInputElement, requestUrl: string) {
  const xhttp = new XMLHttpRequest();
  const requestData = 'ajax=1&action=update';
  xhttp.open('POST', requestUrl);
  xhttp.setRequestHeader('Accept', 'application/json');
  xhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
  xhttp.onload = function () {
    const resp = JSON.parse(xhttp.responseText);
    prestashop.emit('updateCart', {
      reason: qtyInput.dataset,
      resp,
    });
  }
  xhttp.onerror = function () {
    const resp = JSON.parse(xhttp.responseText);
    prestashop.emit('handleError', {
      eventType: 'updateProductQuantityInCart',
      resp,
    });
  }
  xhttp.send(requestData);
}

document.addEventListener('DOMContentLoaded', function(event) {
  prestashop.on('updatedCart', () => {
    initQuantityInput();
  });
});
