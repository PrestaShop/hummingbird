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

import selectorsMap from '@constants/selectors-map';
import useAlert from '@js/components/useAlert';
import * as Alertify from '@constants/mocks/useAlert-data';

describe('useAlert', () => {
  describe('wrapper functions', () => {
    beforeAll(() => {
      console.error = jest.fn();
    });

    it('must returns false when useAlert failed to initialize', () => {
      const {
        show: showAlert,
        hide: hideAlert,
        dispose: disposeAlert,
        title: AlertTitle,
        message: AlertMessage,
        remove: removeAlert,
      } = useAlert('');

      expect(console.error).toHaveBeenCalledTimes(1);
      expect(showAlert()).toBeFalsy();
      expect(hideAlert()).toBeFalsy();
      expect(disposeAlert()).toBeFalsy();
      expect(AlertTitle()).toBeFalsy();
      expect(AlertMessage()).toBeFalsy();
      expect(removeAlert()).toBeFalsy();
    });

    it('must returns true when useAlert successfully initialized', () => {
      resetHTMLBodyContent(Alertify.NotificationsContainer);

      const {
        show: showAlert,
        hide: hideAlert,
        dispose: disposeAlert,
        title: AlertTitle,
        message: AlertMessage,
        remove: removeAlert,
      } = useAlert('', {type: 'info', title: 'dummy'});

      AlertTitle(Alertify.TestMarkupTitle);
      AlertMessage(Alertify.TestMarkupMessage);

      expect(showAlert()).toBeTruthy();
      expect(hideAlert()).toBeTruthy();
      expect(disposeAlert()).toBeTruthy();
      expect(AlertTitle()).toEqual(Alertify.TestMarkupTitle);
      expect(AlertMessage()).toEqual(Alertify.TestMarkupMessage);
      expect(removeAlert()).toBeTruthy();
    });

    it('must returns false when useAlert initialized but afterwhile Alert element is removed', () => {
      resetHTMLBodyContent(Alertify.NotificationsContainer);

      const {
        show: showAlert,
        hide: hideAlert,
        dispose: disposeAlert,
        title: AlertTitle,
        message: AlertMessage,
        remove: removeAlert,
      } = useAlert('');

      removeAlert();

      expect(showAlert()).toBeFalsy();
      expect(hideAlert()).toBeFalsy();
      expect(disposeAlert()).toBeFalsy();
      expect(AlertTitle()).toBeFalsy();
      expect(AlertMessage()).toBeFalsy();
      expect(removeAlert()).toBeFalsy();
    });
  });

  describe('with notifications container in the DOM', () => {
    beforeAll(() => {
      resetHTMLBodyContent(Alertify.NotificationsContainer);
    });

    it('should display the HTML markup message when used', () => {
      const {show: showAlert, message: AlertMessage} = useAlert(Alertify.TestMarkupMessage);
      showAlert();

      expect(AlertMessage()).toEqual(Alertify.TestMarkupMessage);
    });

    it('should style the Alert as same as the type when is set', () => {
      const {show: showAlert, element: AlertElement} = useAlert('', Alertify.TestTypeOption);
      showAlert();
      const AlertClassList = AlertElement?.classList.toString();

      expect(AlertClassList).toMatch(new RegExp(Alertify.ExpectedTypeClassList));
    });

    it('should add the custom class list to the Alert when is set', () => {
      const {show: showAlert, element: AlertElement} = useAlert('', Alertify.TestClassListOption);
      showAlert();
      const AlertClassList = AlertElement?.classList.toString();
      const customClassList = Alertify.TestClassListOption.classlist?.toString() ?? '';

      expect(AlertClassList).toMatch(new RegExp(customClassList));
    });

    it('should add the custom icon to the Alert when is set', () => {
      const {show: showAlert, element: AlertElement} = useAlert('', Alertify.TestIconOption);
      showAlert();
      const alertIconElement = AlertElement?.querySelector<HTMLButtonElement>(selectorsMap.alert.icon);

      expect(alertIconElement?.innerHTML).toMatch(new RegExp(Alertify.TestIconCodepoint));
    });

    it('should hide the close button when dismissable is false', () => {
      const {show: showAlert, element: AlertElement} = useAlert('', Alertify.TestDismissOption);
      showAlert();
      const closeButtonElement = AlertElement?.querySelector<HTMLButtonElement>(selectorsMap.alert.close);
      const closeBtnClassList = closeButtonElement?.classList.toString();

      expect(closeBtnClassList).toEqual(expect.stringContaining('d-none'));
    });

    it('should append alert in the selector if exists in the DOM', () => {
      resetHTMLBodyContent(Alertify.LandingContainer);

      const {show: showAlert, element: AlertElement} = useAlert('', Alertify.TestSelectorOption);
      showAlert();
      const alertContainer = AlertElement?.parentElement;
      const alertContainerClassList = alertContainer?.classList.toString();

      expect(alertContainerClassList).toEqual(expect.stringContaining(Alertify.LandingContainerClass));
    });
  });
});

const resetHTMLBodyContent = (bodyContent: string) => {
  const body = document.querySelector<HTMLBodyElement>('body');

  if (body) {
    body.innerHTML = bodyContent;
  }
};
