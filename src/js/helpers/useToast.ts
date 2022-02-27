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
import selectorsMap from '@constants/selectors-map';
import Toaster from '@constants/useToast-data';

const useToast = (message: string, options?: Toaster.Option): Toaster.Result => {
  const toastElement = getToastElement();

  insertToastMessage(toastElement, message);

  options = {...Toaster.Default, ...options};

  addToastClassList(toastElement, options);

  if (options.autohide === false) {
    setCloseButtonVisible(toastElement);
  }
 
  const toastElementBody = toastElement.querySelector<HTMLElement>(selectorsMap.toast.body);

  if (toastElementBody) {
    const toastObject: Toaster.Result = {
      instance: new Toast(toastElement, { autohide: options.autohide, delay: options.delay }),
      element: toastElement,
      content: toastElementBody,
    }

    return toastObject;
  }

  throw new DOMException('The object can not be found here.');
}

const getToastElement = (): HTMLElement => {
  const toastContainer = document.querySelector<HTMLElement>(selectorsMap.toast.container);

  if (toastContainer) {
    const toastElement = cloneToastTemplate(toastContainer);

    if (toastElement) {

      return toastElement;
    } else {
      return useFallbackToastTemplate(toastContainer);
    }
  } else {
    return useFallbackToastContainer();
  }
}

const cloneToastTemplate = (toastContainer: HTMLElement): HTMLElement | undefined => {
  const toastTemplate = toastContainer.querySelector<HTMLTemplateElement>(selectorsMap.toast.template);
  const toastClone = toastTemplate?.content.cloneNode(true) as DocumentFragment;
  const toastElement = toastClone?.querySelector<HTMLElement>(selectorsMap.toast.toast);
  const toastBody = toastElement?.querySelector<HTMLElement>(selectorsMap.toast.body);

  if (toastElement && toastBody) {
    toastContainer.appendChild(toastElement);

    return toastElement;
  }
}

const useFallbackToastTemplate = (toastContainer: HTMLElement): HTMLElement => {
  toastContainer.innerHTML = '';
  const fallbackContainer = getFallbackContainer();

  if (fallbackContainer) {
    toastContainer.innerHTML = fallbackContainer.innerHTML;
    const toastElement = cloneToastTemplate(toastContainer);

    if (toastElement) {

      return toastElement;
    } 
  }

  throw new DOMException('The object can not be cloned.');
}

const useFallbackToastContainer = (): HTMLElement => {
  const body = document.querySelector<HTMLBodyElement>('body');
  const fallbackContainer = getFallbackContainer();

  if (body && fallbackContainer) {
    const toastElement = cloneToastTemplate(fallbackContainer);

    if (toastElement) {
      fallbackContainer.appendChild(toastElement);
      body.appendChild(fallbackContainer);
  
      return toastElement;
    }
  }

  throw new DOMException('The object can not be cloned.');
}

const getFallbackContainer = () => {
  const dummyElement = document.createElement('div');
  dummyElement.innerHTML = Toaster.Fallback;
  const fallbackContainer =  dummyElement.querySelector<HTMLElement>(selectorsMap.toast.container);

  return fallbackContainer;
}

const insertToastMessage = (toastElement: HTMLElement, message: string) => {
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

const setCloseButtonVisible = (toastElement: HTMLElement) => {
  const closeButton = toastElement.querySelector<HTMLElement>(selectorsMap.toast.close);

  if (closeButton) {
    let toastColor = toastElement.classList.toString().match(/text-\w+/)?.toString();

    if (toastColor) {
      toastColor = toastColor.substring(toastColor.indexOf('-') + 1);

      if (toastColor === 'white' || toastColor === 'light') {
        closeButton.classList.add('btn-close-white');
      }
    }

    closeButton.classList.remove('d-none');
  }
}

export default useToast;
