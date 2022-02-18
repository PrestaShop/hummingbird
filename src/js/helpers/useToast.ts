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
import Toaster from '@constants/useToast-data';
import selectorsMap from '@constants/selectors-map';

const useToast = (message: string, options?: Toaster.Option): Toast => {
  const toastElement = getToastElement();

  setToastMessage(toastElement, message);

  options = {...Toaster.Default, ...options};
  let bsClassList: string = Toaster.Theme[options.type];
  const customClassList = options.classlist;
  
  if (customClassList) {
    bsClassList = bsClassList.concat(' ', customClassList.trim());
  }

  setToastClassList(toastElement, bsClassList);

  if (options.autohide === false) {
    setToastBtnClose(toastElement);
  }
 
  return new Toast(toastElement, { autohide: options.autohide, delay: options.delay });
}

function getToastElement() {
  let toastContainer = getToastContainer();

  return cloneToastElement(toastContainer);
}

function getToastContainer() {
  let toastContainer = document.querySelector<HTMLElement>(selectorsMap.toast.container);

  if (toastContainer) {
    return toastContainer;
  }

  const body = document.querySelector('body');
  const fallback = document.createElement('div');
  fallback.innerHTML = Toaster.Fallback;
  toastContainer = fallback.querySelector<HTMLElement>(selectorsMap.toast.container);

  if (body && toastContainer) {
    body.appendChild(toastContainer);

    return toastContainer;
  }

  throw new DOMException('The object cannot be found here.');
}

function cloneToastElement(toastContainer: HTMLElement) {
  const toastTemplate = toastContainer.querySelector<HTMLTemplateElement>(selectorsMap.toast.template);
  const toastClone = toastTemplate?.content.cloneNode(true) as DocumentFragment;
  const toastElement = toastClone.querySelector<HTMLElement>(selectorsMap.toast.toast);

  if (toastElement) {
    toastContainer.appendChild(toastElement);

    return toastElement;
  }

  throw new DOMException('The object cannot be found here.');
}

function setToastMessage(toastElement: HTMLElement, message: string) {
  const toastBody = toastElement.querySelector<HTMLElement>(selectorsMap.toast.body);

  if (toastBody === null) {
    throw new DOMException('The object cannot be found here.');
  }

  toastBody.innerHTML = message;
}

function setToastClassList(toastElement: HTMLElement, classList: string) {
  classList.trim().split(' ').forEach((value) => {
    toastElement.classList.add(value);
  });
}

function setToastBtnClose(toastElement: HTMLElement) {
  const closeBtn = toastElement.querySelector(selectorsMap.toast.close);
  if (closeBtn) {
    let btnColor = 'btn-close-white';
    let toastColor = toastElement.classList.toString().match(/text-\w+/)?.toString();
    if (toastColor) {
      toastColor = toastColor.substring(toastColor.indexOf('-') + 1);
      btnColor = 'btn-close-' + toastColor;
    }
    closeBtn.classList.add(btnColor);
    closeBtn.classList.remove('d-none');
  }
}

export default useToast;
