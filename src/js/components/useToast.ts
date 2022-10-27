/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import {Toast} from 'bootstrap';
import selectorsMap from '@constants/selectors-map';
import * as Toaster from '@constants/useToast-data';

const useToast = (message: string, options?: Theme.Toast.Options): Theme.Toast.Instance => {
  let toastObject: Theme.Toast.Instance = {
    // An instance of Bootstrap's Toast, will be used to show, hide and dispose the toast
    instance: null,
    // In case someone wants to access the toast's element afterwhile
    element: null,
    // In case someone wants to modify the toast's content afterwhile
    content: null,
    // Reveals the element’s toast
    show: () => false,
    // Hides the element’s toast
    hide: () => false,
    // Hides the element’s toast, element will remain on the DOM but toast won’t show anymore
    dispose: () => false,
    // Gets or sets the HTML markup contained within the toast's element
    message: () => false,
    // Removes the toast's element from the DOM and toast won’t show anymore
    remove: () => false,
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
      const toastInstance = new Toast(toastElement, {autohide: clonedOptions.autohide, delay: clonedOptions.delay});
      toastObject = {
        instance: toastInstance,
        element: toastElement,
        content: toastElementBody,
        show: () => {
          if (toastElement.isConnected) {
            toastInstance.show();
            return true;
          }
          return false;
        },
        hide: () => {
          if (toastElement.isConnected) {
            toastInstance.hide();
            return true;
          }
          return false;
        },
        dispose: () => {
          if (toastElement.isConnected) {
            toastInstance.dispose();
            return true;
          }
          return false;
        },
        message: (markup: string) => {
          if (toastElement.isConnected) {
            if (markup) {
              toastElementBody.innerHTML = markup;
            }
            return toastElementBody.innerHTML;
          }
          return false;
        },
        remove: () => {
          if (toastElement.isConnected) {
            toastElement.remove();
            return true;
          }
          return false;
        },
      };
    }
  }

  return toastObject;
};

const getToastElement = (template?: string): HTMLElement | null => {
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
const cloneToastTemplate = (toastContainer: HTMLElement, fallback = true): HTMLElement | null => {
  const toastTemplate = toastContainer.querySelector<HTMLTemplateElement>(selectorsMap.toast.template);
  const toastClone = toastTemplate?.content.cloneNode(true) as DocumentFragment;
  const toastElement = toastClone?.querySelector<HTMLElement>(selectorsMap.toast.toast);
  const toastBody = toastElement?.querySelector<HTMLElement>(selectorsMap.toast.body);

  if (toastElement && toastBody) {
    toastContainer.appendChild(toastElement);

    return toastElement;
  }

  if (fallback) {
    // In case the template doesn't exist on the page, rely on the JS fallback
    const fallbackContainer = getFallbackContainer();

    if (fallbackContainer) {
      toastContainer.innerHTML = fallbackContainer.innerHTML;

      return cloneToastTemplate(toastContainer, false);
    }
  }

  // This happens only if someone removed the markup and also removed the JS fallback
  printConsoleError(
    'Failed to clone toast template.',
    'Check the toast markup in theme or JS fallback.',
  );

  return null;
};

// We can append override toast template to the container without cloning
const appendToastTemplate = (toastContainer: HTMLElement, template: string): HTMLElement | null => {
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

  return null;
};

const useFallbackToastContainer = (template?: string): HTMLElement | null => {
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

  return null;
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
const addToastClassList = (toastElement: HTMLElement, options: Theme.Toast.Options): void => {
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

const printConsoleError = (error: string, info?: string): void => {
  if (info) {
    console.group('useToast');
    console.error(error);
    console.info(info);
    console.groupEnd();
  } else {
    console.error(error);
  }
};

export default useToast;
