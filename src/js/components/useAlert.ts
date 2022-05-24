/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import {Alert} from 'bootstrap';
import selectorsMap from '@constants/selectors-map';
import * as Alerter from '@constants/useAlert-data';

const useAlert: Theme.Alert.Function = (message: string, options?: Theme.Alert.Options): Theme.Alert.Instance => {
  let alertObject: Theme.Alert.Instance = {
    // An instance of Bootstrap's Alert, will be used to show, hide and dispose the alert
    instance: null,
    // In case someone wants to access the alert's element afterwhile
    element: null,
    // Reveals the element’s alert
    show: () => false,
    // Hides the element’s alert
    hide: () => false,
    // Hides the element’s alert, element will remain on the DOM but alert won’t show anymore
    dispose: () => false,
    // Gets or sets the HTML markup contained within the alert's header
    title: () => false,
    // Gets or sets the HTML markup contained within the alert's body
    message: () => false,
    // Removes the alert's element from the DOM and alert won’t show anymore
    remove: () => false,
  };

  const alertElement = cloneAlertElement(options);

  if (alertElement) {
    const alertElementHeader = insertAlertTitle(alertElement, options?.title);
    const alertElementBody = insertAlertMessage(alertElement, message);

    const alertInstance = new Alert(alertElement);
    alertObject = {
      instance: alertInstance,
      element: alertElement,
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
      title: (markup: string) => {
        if (alertElementHeader?.isConnected) {
          if (markup) {
            alertElementHeader.innerHTML = markup;
          }
          return alertElementHeader.innerHTML;
        }
        return false;
      },
      message: (markup: string) => {
        if (alertElementBody?.isConnected) {
          if (markup) {
            alertElementBody.innerHTML = markup;
          }
          return alertElementBody.innerHTML;
        }
        return false;
      },
      remove: () => {
        if (alertElement.isConnected) {
          alertElement.remove();
          return true;
        }
        return false;
      },
    };
  }

  return alertObject;
};

const cloneAlertElement = (options?: Theme.Alert.Options): HTMLElement | null => {
  const alertOptions = {...Alerter.Default, ...options};
  // If selector sent then append alert inside it
  // Otherwise use the notifications container
  const selector = alertOptions.selector ?? selectorsMap.alert.selector;
  const alertSelectorElement = document.querySelector<HTMLElement>(selector);

  if (alertSelectorElement) {
    const dummyElement = document.createElement('div');
    dummyElement.innerHTML = Alerter.Template;
    const alertElement = dummyElement.querySelector<HTMLElement>(selectorsMap.alert.alert);

    if (alertElement) {
      // Style the alert based on corresponding type
      alertElement.classList.add(Alerter.Theme[alertOptions.type]);

      // The icon will be displayed only when alert hasn't title
      const alertElementIcon = alertElement.querySelector<HTMLElement>(selectorsMap.alert.icon);

      if (alertElementIcon) {
        if (alertOptions.title === undefined) {
          // If custom icon sent then use it
          // otherwise use the corresponding icon based on the type
          const codepoint = (alertOptions.icon)
            ? alertOptions.icon
            : Alerter.Codepoint[alertOptions.type];

          alertElementIcon.innerHTML = `&#x${codepoint};`;
        } else {
          alertElement.classList.add('flex-wrap');
          alertElementIcon.classList.add('d-none');
        }
      }

      // By default alert has close button
      if (alertOptions.dismissible === false) {
        const alertElementCloseBtn = alertElement.querySelector<HTMLElement>(selectorsMap.alert.close);
        alertElementCloseBtn?.classList.add('d-none');
      }

      // The custom class list will be added to the alert element
      if (alertOptions.classlist) {
        alertOptions.classlist.split(' ').forEach((value) => {
          if (value) {
            alertElement.classList.add(value);
          }
        });
      }

      alertSelectorElement.appendChild(alertElement);
    }

    return alertElement;
  }

  // The notifications container is not exists in the DOM and the selector not sent as parameter
  console.error('The selector for alert is not valid: %c%o', 'color: white', selector);

  return null;
};

const insertAlertTitle = (alertElement: HTMLElement, title?: string): HTMLElement | null => {
  if (title) {
    const alertHeader = alertElement.querySelector<HTMLElement>(selectorsMap.alert.heading);

    if (alertHeader) {
      alertHeader.innerHTML = title;
      alertHeader.classList.remove('d-none');

      return alertHeader;
    }
  }

  return null;
};

const insertAlertMessage = (alertElement: HTMLElement, message: string): HTMLElement | null => {
  const alertBody = alertElement.querySelector<HTMLElement>(selectorsMap.alert.body);

  if (alertBody) {
    alertBody.innerHTML = message;
  }

  return alertBody;
};

export default useAlert;
