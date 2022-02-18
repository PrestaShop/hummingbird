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

  addToastMessage(toastElement, message);

  options = {...Toaster.Default, ...options};

  addToastClassList(toastElement, options);

  if (options.autohide === false) {
    showToastBtnClose(toastElement);
  }
 
  return new Toast(toastElement, { autohide: options.autohide, delay: options.delay });
}

const getToastElement = (): HTMLElement => {
  const toastContainer = document.querySelector<HTMLElement>(selectorsMap.toast.container);

  if (toastContainer) {
    const toastTemplate = toastContainer.querySelector<HTMLTemplateElement>(selectorsMap.toast.template);
    const toastClone = toastTemplate?.content.cloneNode(true) as DocumentFragment;
    const toastElement = toastClone?.querySelector<HTMLElement>(selectorsMap.toast.toast);
    const toastBody = toastElement?.querySelector<HTMLElement>(selectorsMap.toast.body);

    if (toastElement && toastBody) {
      toastContainer.appendChild(toastElement);
  
      return toastElement;
    } else {
      toastContainer.remove();
    }
  }

  return getFallbackToastElement();
}

const getFallbackToastElement = (): HTMLElement => {
  const body = document.querySelector<HTMLBodyElement>('body');
  const dummyElement = document.createElement('div');
  dummyElement.innerHTML = Toaster.Fallback;
  const toastContainer = dummyElement.querySelector<HTMLElement>(selectorsMap.toast.container);
  const toastTemplate = toastContainer?.querySelector<HTMLTemplateElement>(selectorsMap.toast.template);

  if (body && toastContainer && toastTemplate) {
    const toastClone = toastTemplate.content.cloneNode(true) as DocumentFragment;
    const toastElement = toastClone.querySelector<HTMLElement>(selectorsMap.toast.toast);

    if (toastElement) {
      toastContainer.appendChild(toastElement);
      body.appendChild(toastContainer);
  
      return toastElement;
    }
  }

  throw new DOMException('The object can not be cloned.');
}


const addToastMessage = (toastElement: HTMLElement, message: string) => {
  const toastBody = toastElement.querySelector<HTMLElement>(selectorsMap.toast.body);

  if (toastBody) {
    toastBody.innerHTML = message;
  }
}

const addToastClassList = (toastElement: HTMLElement, options: Toaster.Option) => {
  let bsClassList: string = Toaster.Theme[options.type];
  const customClassList = options.classlist;
  
  if (customClassList) {
    bsClassList = bsClassList.concat(' ', customClassList.trim());
  }

  bsClassList.split(' ').forEach((value) => {
    if (value) {
      toastElement.classList.add(value);
    }
  });
}

const showToastBtnClose = (toastElement: HTMLElement) => {
  const btnClose = toastElement.querySelector<HTMLElement>(selectorsMap.toast.close);

  if (btnClose) {
    let toastColor = toastElement.classList.toString().match(/text-\w+/)?.toString();

    if (toastColor) {
      toastColor = toastColor.substring(toastColor.indexOf('-') + 1);

      if (toastColor === 'white' || toastColor === 'light') {
        btnClose.classList.add('btn-close-white');
      }
    }

    btnClose.classList.remove('d-none');
  }
}

export default useToast;
