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

import {Alert} from 'bootstrap';
import selectorsMap from '@constants/selectors-map';
import * as Alerter from '@constants/useAlert-data';

const useAlert = (message: string, options?: Alerter.Options): Alerter.Instance => {
  let alertObject: Alerter.Instance = {
    // An instance of Bootstrap's Alert, will be used to show, hide and dispose the alert
    instance: null,
    // In case someone wants to access the alert's element afterwhile
    element: null,
    // In case someone wants to modify the alert's content afterwhile
    content: null,
    // Reveals the element’s alert
    show: () => false,
    // Hides the element’s alert
    hide: () => false,
    // Hides the element’s alert, element will remain on the DOM but alert won’t show anymore
    dispose: () => false,
    // Gets or sets the HTML markup contained within the alert's element
    message: () => false,
    // Removes the alert's element from the DOM and alert won’t show anymore
    remove: () => false,
  };

  const alertElement = appendAlertElement(options);

  if (alertElement) {
    const alertElementBody = insertAlertMessage(alertElement, message);

    if (alertElementBody) {
      const alertInstance = new Alert(alertElement);
      alertObject = {
        instance: alertInstance,
        element: alertElement,
        content: alertElementBody,
        show: () => {
          if (alertElement.isConnected) {
            alertElement.classList.add('show');
            return true;
          }
          return false;
        },
        hide: () => {
          if (alertElement.isConnected) {
            alertElement.classList.remove('show');
            return true;
          }
          return false;
        },
        dispose: () => {
          if (alertElement.isConnected) {
            alertInstance.dispose();
            return true;
          }
          return false;
        },
        message: (markup: string) => {
          if (alertElement.isConnected) {
            if (markup) {
              alertElementBody.innerHTML = markup;
            }
            return alertElementBody.innerHTML;
          }
          return false;
        },
        remove: () => {
          if (alertElement.isConnected) {
            alertInstance.close();
            return true;
          }
          return false;
        },
      };
    }
  }

  return alertObject;
};

const appendAlertElement = (options?: Alerter.Options): HTMLElement | null => {
  const alertOptions = {...Alerter.Default, ...options};

  const alertContainer = (alertOptions.container)
    ? document.querySelector<HTMLElement>(alertOptions.container)
    : document.querySelector<HTMLElement>(selectorsMap.alert.container);

  if (alertContainer) {
    const dummyElement = document.createElement('div');
    dummyElement.innerHTML = Alerter.Template;
    const alertElement = dummyElement.querySelector<HTMLElement>(selectorsMap.alert.alert);

    if (alertElement) {
      alertElement.classList.add(Alerter.Theme[alertOptions.type]);

      const alertIconElement = dummyElement.querySelector<HTMLElement>(selectorsMap.alert.icon);

      if (alertIconElement) {
        alertIconElement.innerHTML = `&#x${Alerter.Codepoint[alertOptions.type]};`;
      }

      if (alertOptions.dismissible === false) {
        const closeButtonElement = alertElement.querySelector<HTMLElement>(selectorsMap.alert.close);
        closeButtonElement?.classList.add('d-none');
      }

      alertContainer.appendChild(alertElement);
    }

    return alertElement;
  }

  printConsoleError(
    'The container for alert not found here.',
  );

  return null;
};

const insertAlertMessage = (alertElement: HTMLElement, message: string): HTMLElement | null => {
  const alertBody = alertElement.querySelector<HTMLElement>(selectorsMap.alert.body);

  if (alertBody) {
    alertBody.innerHTML = message;
  }

  return alertBody;
};

const printConsoleError = (error: string, info?: string): void => {
  if (info) {
    console.group('useAlert');
    console.error(error);
    console.info(info);
    console.groupEnd();
  } else {
    console.error(error);
  }
};

export default useAlert;
