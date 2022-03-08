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

const useToast = (message: string, options?: Toaster.Options): Toaster.Instance => {
  let toastObject: Toaster.Instance = {
    show: () => {
      // Reveals the toast element’s instance
    },
    hide: () => {
      // Hides the toast element’s instance
    },
    remove: () => {
      // Removes the toast element from the toast container
    },
    element: () => {
      // Returns the toast instance's element
    },
    content: () => {
      // Gets or sets the HTML markup contained within the element
    },
  };

  const toastElement = getToastElement(options?.template);

  if (toastElement) {
    insertToastMessage(toastElement, message);

    const clonedOptions = {...Toaster.Default, ...options};
    addToastClassList(toastElement, clonedOptions);

    if (clonedOptions.autohide === false) {
      setCloseButtonVisible(toastElement);
    }

    const toastElementBody = toastElement.querySelector<HTMLElement>(selectorsMap.toast.body);

    if (toastElementBody) {
      // It's a Bootstrap's Toast instance, will be used to show, hide and remove the toast
      const instance = new Toast(toastElement, {autohide: clonedOptions.autohide, delay: clonedOptions.delay});
      toastObject = {
        show: () => instance.show(),
        hide: () => instance.hide(),
        remove: () => toastElement.remove(),
        element: () => toastElement,
        content: (markup) => {
          if (markup) {
            toastElementBody.innerHTML = markup;
          }
          return toastElementBody.innerHTML;
        },
      };
    }
  }

  return toastObject;
};

const getToastElement = (template?: string): HTMLElement | undefined => {
  const toastContainer = document.querySelector<HTMLElement>(selectorsMap.toast.container);
  // If the toast container exists on the page, use it
  // Otherwise, use the fallback container

  if (toastContainer) {
    // If override template is set, append to the container
    // Otherwise, try to clone toast template

    return (template === undefined)
      ? cloneToastTemplate(toastContainer)
      : appendToastTemplate(toastContainer, template);
  }

  return useFallbackToastContainer(template);
};

// We need to use a template, in order to generate the toast markup on the fly
const cloneToastTemplate = (toastContainer: HTMLElement, fallback = true): HTMLElement | undefined => {
  const toastTemplate = toastContainer.querySelector<HTMLTemplateElement>(selectorsMap.toast.template);
  const toastClone = toastTemplate?.content.cloneNode(true) as DocumentFragment;
  const toastElement = toastClone?.querySelector<HTMLElement>(selectorsMap.toast.toast);
  const toastBody = toastElement?.querySelector<HTMLElement>(selectorsMap.toast.body);

  if (toastElement && toastBody) {
    toastContainer.appendChild(toastElement);

    return toastElement;
  }

  if (fallback) {
    // In case the template doesn't exist on the page, rely on the fallback
    const fallbackContainer = getFallbackContainer();

    if (fallbackContainer) {
      toastContainer.innerHTML = fallbackContainer.innerHTML;

      return cloneToastTemplate(toastContainer, false);
    }
  }

  // This happens only if someone removed the markup AND removed the fallback
  printConsoleError(
    'Failed to clone toast template.',
    'Check the toast template in theme markup or JS fallback.',
  );

  return undefined;
};

// We can append override toast template to the container without cloning
const appendToastTemplate = (toastContainer: HTMLElement, template: string): HTMLElement | undefined => {
  const dummyElement = document.createElement('div');
  dummyElement.innerHTML = template;
  const toastElement = dummyElement?.querySelector<HTMLElement>(selectorsMap.toast.toast);
  const toastBody = toastElement?.querySelector<HTMLElement>(selectorsMap.toast.body);

  if (toastElement && toastBody) {
    toastContainer.appendChild(toastElement);

    return toastElement;
  }

  printConsoleError(
    'The override toast template is not valid.',
    'Reference: https://getbootstrap.com/docs/5.0/components/toasts/',
  );

  return undefined;
};

const useFallbackToastContainer = (template?: string): HTMLElement | undefined => {
  const body = document.querySelector<HTMLBodyElement>('body');
  const fallbackContainer = getFallbackContainer();

  if (body && fallbackContainer) {
    // If override template is set, append to the fallback container
    // Otherwise, try to clone fallback toast template
    const toastElement = (template === undefined)
      ? cloneToastTemplate(fallbackContainer, false)
      : appendToastTemplate(fallbackContainer, template);

    if (toastElement) {
      fallbackContainer.appendChild(toastElement);
      body.appendChild(fallbackContainer);

      return toastElement;
    }
  }

  return undefined;
};

const getFallbackContainer = (): HTMLElement | null => {
  const dummyElement = document.createElement('div');
  dummyElement.innerHTML = Toaster.Fallback;
  const fallbackContainer = dummyElement.querySelector<HTMLElement>(selectorsMap.toast.container);

  return fallbackContainer;
};

const insertToastMessage = (toastElement: HTMLElement, message: string): void => {
  const toastBody = toastElement.querySelector<HTMLElement>(selectorsMap.toast.body);

  if (toastBody) {
    toastBody.innerHTML = message;
  }
};

// Depending on the toast type, we need different classes (success, warning, error...)
const addToastClassList = (toastElement: HTMLElement, options: Toaster.Options): void => {
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

const setCloseButtonVisible = (toastElement: HTMLElement): void => {
  const closeButton = toastElement.querySelector<HTMLButtonElement>(selectorsMap.toast.close);

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

const printConsoleError = (message: string, information?: string): void => {
  if (information) {
    console.group('useToast');
    console.error(message);
    console.info(information);
    console.groupEnd();
  } else {
    console.error(message);
  }
};

export default useToast;
