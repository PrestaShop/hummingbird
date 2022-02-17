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

const useToast = (message: string, options?: Toaster.Options): Toast => {
  let toastContainer = document.querySelector<HTMLElement>(selectorsMap.toast.container);

  if (!toastContainer) {
    const body = document.querySelector<HTMLBodyElement>('body');

    if (!body) {
      throw new DOMException('The object cannot be found here: <body>');
    }

    const fallback = document.createElement('div');
    fallback.innerHTML = Toaster.Templates.container;
    toastContainer = fallback.querySelector<HTMLElement>(selectorsMap.toast.container);

    if (toastContainer) {
      const className = selectorsMap.toast.container.substring(1);
      addClassListToElement(toastContainer, className.concat(' ', className, '--fallback'));
      body.appendChild<HTMLElement>(toastContainer);
    }
  }

  if (toastContainer) {
    let toastTemplate = toastContainer.querySelector<HTMLTemplateElement>(selectorsMap.toast.template);

    if (!toastTemplate) {
      const fallback = document.createElement('template');
      fallback.innerHTML = Toaster.Templates.toast;
      const className = selectorsMap.toast.template.substring(1);
      addClassListToElement(fallback, className.concat(' ', className, '--fallback'));
      toastContainer.appendChild(fallback);
      toastTemplate = toastContainer.querySelector<HTMLTemplateElement>(selectorsMap.toast.template);
    }

    if (toastTemplate) {
      let toastElement = null;

      if ('content' in document.createElement('template')) {
        const toastClone = toastTemplate.content.cloneNode(true) as DocumentFragment;

        if (!toastClone) {
          throw new DOMException('The object can not be cloned: .js-toast-template');
        }

        toastElement = toastClone.querySelector<HTMLElement>(selectorsMap.toast.toast);
      } else {
        const fallback = document.createElement('div');
        fallback.innerHTML = Toaster.Templates.toast;
        toastElement = fallback.querySelector<HTMLElement>(selectorsMap.toast.toast);

        if (toastElement) {
          const className = selectorsMap.toast.toast.substring(1);
          addClassListToElement(toastElement, className.concat(' ', className, '--fallback'));
        }
      }

      if (!toastElement) {
        throw new DOMException('The object cannot be found here: .toast');
      }
      
      const toastBody = toastElement.querySelector<HTMLElement>(selectorsMap.toast.body);

      if (!toastBody) {
        throw new DOMException('The object cannot be found here: .toast-body');
      }

      toastBody.innerHTML = message;

      options = {...Toaster.defaults, ...options};
      let classList: string = Toaster.Themes[options.type];
      
      if (options.classlist) {
        classList = classList.concat(' ', options.classlist.trim());
      }
    
      addClassListToElement(toastElement, classList);
      toastContainer.appendChild(toastElement);
    
      return new Toast(toastElement, { autohide: options.autohide, delay: options.delay });
    } else {
      throw new DOMException('The object cannot be found here: .toast-template');
    }
  } else {
    throw new DOMException('The object cannot be found here: .toast-container');
  }
}

function addClassListToElement(element: HTMLElement, classList: string) {
  classList.trim().split(' ').forEach((value) => {
    element.classList.add(value);
  });
}

export default useToast;
