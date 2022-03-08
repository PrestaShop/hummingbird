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

import {Toast} from 'bootstrap';
import selectorsMap from '@constants/selectors-map';
import * as Toaster from '@constants/useToast-data';

const test = new Toast('.yolo');
test.show();

const useToast = (message: string, options?: Toaster.Options): Toaster.Result => {
  const toastElement = getToastElement(options?.template);

  insertToastMessage(toastElement, message);

  const clonedOptions = {...Toaster.Default, ...options};

  addToastClassList(toastElement, clonedOptions);

  if (clonedOptions.autohide === false) {
    setCloseButtonVisible(toastElement);
  }

  const toastElementBody = toastElement.querySelector<HTMLElement>(selectorsMap.toast.body);

  if (toastElementBody) {
    const toastObject: Toaster.Result = {
      // It's a Bootstrap.Toast instance, used to show, hide and remove the toast
      instance: new Toast(toastElement, {autohide: clonedOptions.autohide, delay: clonedOptions.delay}),
      // In case someone want's to modify the toast markup afterwhile
      element: toastElement,
      // In case someone want to modify the text content afterwhile
      content: toastElementBody,
    };

    return toastObject;
  }

  throw new DOMException('The object can not be found here.');
};

const getToastElement = (template?: string): HTMLElement => {
  const toastContainer = document.querySelector<HTMLElement>(selectorsMap.toast.container);

  // If the toast container exist on the page, use it
  // Overwise, use the fallback
  if (toastContainer) {
    const overrideContainer = document.createElement('div');
    let toastElement;

    if (template) {
      overrideContainer.innerHTML = template;
      toastElement = cloneToastTemplate(toastContainer, overrideContainer);
    } else {
      toastElement = cloneToastTemplate(toastContainer);
    }

    // If the template exist on the page, use it
    // Overwise, use the fallback
    if (toastElement) {
      return toastElement;
    }

    return useFallbackToastTemplate(toastContainer);
  }

  return useFallbackToastContainer(template);
};

// We need to use a template, in order to generate the toast markup on the fly
const cloneToastTemplate = (containerToAppend: HTMLElement, toastContainer?: HTMLElement): HTMLElement | false => {
  let toastTemplate;

  if (toastContainer) {
    toastTemplate = toastContainer.querySelector<HTMLTemplateElement>(selectorsMap.toast.template);
  } else {
    toastTemplate = containerToAppend.querySelector<HTMLTemplateElement>(selectorsMap.toast.template);
  }

  const toastClone = toastTemplate?.content.cloneNode(true) as DocumentFragment;
  const toastElement = toastClone?.querySelector<HTMLElement>(selectorsMap.toast.toast);
  const toastBody = toastElement?.querySelector<HTMLElement>(selectorsMap.toast.body);

  if (toastElement && toastBody) {
    containerToAppend.appendChild(toastElement);

    return toastElement;
  }

  return false;
};

// In case the template doesn't exist on the page, rely on the JS fallback
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

  // This happen only if someone removed the markup AND removed the JS fallback
  throw new DOMException('The object can not be cloned.');
};

const useFallbackToastContainer = (template?: string): HTMLElement => {
  const body = document.querySelector<HTMLBodyElement>('body');
  const fallbackContainer = getFallbackContainer(template);

  if (body && fallbackContainer) {
    const toastElement = cloneToastTemplate(fallbackContainer);

    if (toastElement) {
      fallbackContainer.appendChild(toastElement);
      body.appendChild(fallbackContainer);

      return toastElement;
    }
  }

  throw new DOMException('The object can not be cloned.');
};

const getFallbackContainer = (template?: string) => {
  const dummyElement = document.createElement('div');

  if (template) {
    dummyElement.innerHTML = template;
  } else {
    dummyElement.innerHTML = Toaster.Fallback;
  }

  const fallbackContainer = dummyElement.querySelector<HTMLElement>(selectorsMap.toast.container);

  return fallbackContainer;
};

const insertToastMessage = (toastElement: HTMLElement, message: string) => {
  const toastBody = toastElement.querySelector<HTMLElement>(selectorsMap.toast.body);

  if (toastBody) {
    toastBody.innerHTML = message;
  }
};

// Depending on the toast type, we need different classes (success, warning, error...)
const addToastClassList = (toastElement: HTMLElement, options: Toaster.Options) => {
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
};

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
};

export default useToast;
