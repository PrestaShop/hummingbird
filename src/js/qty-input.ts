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
import { Toast } from 'bootstrap';
import SelectorsMap, { listing } from './selectors-map';

export default function initQuantityInput(selector = SelectorsMap.qtyInput.default) {
  const qtyInputNodeList = document.querySelectorAll(selector);
  const decrementIcon: string = 'E15B';
  const incrementIcon: string = 'E145';

  if (qtyInputNodeList) {
    qtyInputNodeList.forEach(function(qtyInput: HTMLInputElement) {
      const qtyInputWrapper = qtyInput.parentElement;

      if (qtyInputWrapper && qtyInputWrapper.childElementCount === 1) {
        const decrementButton = createSpinButton(decrementIcon);
        decrementButton.addEventListener('click', () => changeQuantity(qtyInput, -1));

        const incrementButton = createSpinButton(incrementIcon);
        incrementButton.addEventListener('click', () => changeQuantity(qtyInput, 1));

        qtyInput.classList.add('ready');
        qtyInputWrapper.insertBefore(decrementButton, qtyInput);
        qtyInputWrapper.appendChild(incrementButton);
      }
    });
  }
}

function createSpinButton(codePoint: string) {
  const spinButton = document.createElement('button');
  spinButton.type = 'button';
  spinButton.classList.add('btn');

  const spinIcon = document.createElement('i');
  spinIcon.innerHTML = '&#x' + codePoint + ';';
  spinIcon.classList.add('material-icons');

  spinButton.appendChild(spinIcon);

  return spinButton;
}

function changeQuantity(qtyInput: HTMLInputElement, change: number) {
  const quantity = Number(qtyInput.value);
  const min = Number(qtyInput.getAttribute('min')) ?? 0;
  const newValue = Math.max(quantity + change, min);
  qtyInput.value = String(newValue);

  const requestUrl = (change > 0) ? qtyInput.dataset.upUrl : qtyInput.dataset.downUrl;
  
  if (requestUrl !== undefined) {
    sendUpdateQuantityInCartRequest(qtyInput, requestUrl, change);
  }
}

function sendUpdateQuantityInCartRequest(qtyInput: HTMLInputElement, requestUrl: string, change: number) {
  const xhttp = new XMLHttpRequest();
  xhttp.open('POST', requestUrl);
  xhttp.setRequestHeader('Accept', 'application/json');
  xhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

  xhttp.onloadstart = function () {
    const decrementButton = qtyInput.previousElementSibling;
    const incrementButton = qtyInput.nextElementSibling;

    if (decrementButton && incrementButton) {
      const targetButton = (change > 0) ? incrementButton : decrementButton;
      targetButton.setAttribute('disabled', 'disabled')
      const targetIcon = targetButton.firstElementChild;

      if (targetIcon) {
        const spinner = document.createElement('i');
        spinner.classList.add('spinner-border', 'spinner-border-sm', 'text-info');
        targetIcon.classList.add('d-none');
        targetButton.appendChild(spinner);
      }
    }
  }

  xhttp.onload = function () {
    const resp = JSON.parse(xhttp.responseText);

    if (resp['hasError']) {
      showUpdateOperationErrors(resp);
    }

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

  xhttp.send(getRequestParameters());
}

function getRequestParameters() {
  const requestData: {[key: string]: string} = {
    ajax: '1',
    action: 'update',
  };
  const parameters = [];

  for (const property in requestData) {
      if (requestData.hasOwnProperty(property)) {
          parameters.push(encodeURI(property + '=' + requestData[property]));
      }
  }

  return parameters.join('&');
}

function showUpdateOperationErrors(resp: any) {
    const bsClassList: {[key: string]: string} = {
      id: 'cart-error-stack',
      parent: 'body',
      container: 'toast-container',
      class: 'toast',
      content: 'toast-body',
      stack_order: 'z-index:100',
      position: 'position-fixed',
      horizontal: 'start-0',
      vertical: 'top-0',
      edge_padding: 'p-3',
      alert: 'bg-danger',
      color: 'text-white',
      shadow: 'shadow',
      border: 'border-0',
      effect: 'fade',
      delay: '3000',
    };
    let errorStack = document.querySelector('#' + bsClassList['id']);

    if (errorStack) {
      errorStack.innerHTML = '';
    } else {
      errorStack = document.createElement('div');
      errorStack.setAttribute('id', bsClassList['id']);
      errorStack.setAttribute('style', bsClassList['stack_order']);
      errorStack.classList.add(
        bsClassList['container'],
        bsClassList['position'],
        bsClassList['horizontal'],
        bsClassList['vertical'],
        bsClassList['edge_padding']
      );
      
      document.querySelector(bsClassList['parent'])?.appendChild(errorStack);
    }

    const errors = resp['errors'];
    errors.forEach((error: string) => {
      const toast = document.createElement('div');
      toast.classList.add(
        bsClassList['class'],
        bsClassList['effect'],
        bsClassList['alert'],
        bsClassList['color'],
        bsClassList['shadow'],
        bsClassList['border']
      );
    
      const toastBody = document.createElement('div');
      toastBody.classList.add(bsClassList['content']);
      toastBody.innerText = error;
      
      toast.appendChild(toastBody);
      errorStack?.appendChild(toast);
    });

    const toastElements = [].slice.call(errorStack.querySelectorAll('.' + bsClassList['class']))
    toastElements.map(function (toastElement) {
      new Toast(toastElement, { delay: Number(bsClassList['delay']) }).show();
    });
}

document.addEventListener('DOMContentLoaded', function(event) {
  prestashop.on('updatedCart', () => {
    initQuantityInput();
  });
});
