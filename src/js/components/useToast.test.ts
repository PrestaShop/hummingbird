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
import useToast from '@js/components/useToast';
import * as Toastify from '@constants/mocks/useToast-data';

describe('useToast', () => {
  describe('with container and template existing in the DOM', () => {
    beforeAll(() => {
      resetHTMLBodyContent(Toastify.WithContainerWithTemplate);

      window.prestashop = {};
    });

    it('should display the HTML markup message when used', () => {
      const toast = useToast(Toastify.TestMarkupMessage);
      toast.instance.show();

      const toastMessage = toast.content.innerHTML;
      const expectedToastMessage = Toastify.TestMarkupMessage;
      toast.element.remove();

      expect(toastMessage === expectedToastMessage).toBeTruthy();
    });

    it('should style the toast as same as the type when is set', () => {
      const toast = useToast('', Toastify.TestTypeOption);
      toast.instance.show();

      const toastClassList = toast.element.classList.toString();
      const expectedTypeClassList = Toastify.ExpectedTypeClassList;
      toast.element.remove();

      expect(toastClassList.match(new RegExp(expectedTypeClassList))?.length).toBeDefined();
    });

    it('should add the custom class list to the toast when is set', () => {
      const toast = useToast('', Toastify.TestClassListOption);
      toast.instance.show();

      const toastClassList = toast.element.classList.toString();
      const customClassList = Toastify.TestClassListOption.classlist?.toString() ?? '';
      toast.element.remove();

      expect(toastClassList.match(new RegExp(customClassList))?.length).toBeDefined();
    });

    it('should display the close button when autohide is false', () => {
      const toast = useToast('', Toastify.TestAutoHideOption);
      toast.instance.show();

      const closeButtonElement = toast.element.querySelector<HTMLButtonElement>(selectorsMap.toast.close);
      const closeBtnClassList = closeButtonElement?.classList.toString();
      toast.element.remove();

      expect(closeBtnClassList?.match('d-none')?.length).toBeUndefined();
    });
  });

  describe('without container or existing empty container in the DOM', () => {
    it('should append fallback container if container is not exists in the DOM', () => {
      resetHTMLBodyContent(Toastify.WithoutContainer);

      const toast = useToast('');
      toast.instance.show();
      const toastContainer = toast.element.parentElement;

      expect(toastContainer?.classList.contains(Toastify.FallbackContainerClass)).toBeTruthy();
    });

    it('should insert fallback template in existing empty container in the DOM', () => {
      resetHTMLBodyContent(Toastify.WithContainerWithoutTemplate);

      const toast = useToast('');
      toast.instance.show();
      const toastContainer = toast.element.parentElement;

      expect(toastContainer?.classList.contains(Toastify.FallbackContainerClass)).toBeFalsy();
    });
  });

  describe('with template override', () => {
    it('should append overriden container if container is not exists in the DOM', () => {
      resetHTMLBodyContent(Toastify.WithoutContainer);

      const toast = useToast('', {type: 'success', template: Toastify.Override});
      toast.instance.show();
      const toastContainer = toast.element.parentElement;

      expect(toastContainer?.classList.contains(Toastify.OverrideContainerClass)).toBeTruthy();
    });

    it('should insert overriden template in existing empty container in the DOM', () => {
      resetHTMLBodyContent(Toastify.WithContainerWithoutTemplate);

      const toast = useToast('', {type: 'success', template: Toastify.Override});
      toast.instance.show();
      const toastContainer = toast.element.parentElement;
      const overridenToast = toastContainer?.querySelectorAll<HTMLElement>(Toastify.OverridenToastClass);

      expect(toastContainer?.classList.contains(Toastify.FallbackContainerClass)).toBeFalsy();
      expect(overridenToast?.length).toBe(1);
    });
  });
});

const resetHTMLBodyContent = (bodyContent: string) => {
  const body = document.querySelector<HTMLBodyElement>('body');

  if (body) {
    body.innerHTML = bodyContent;
  } else {
    throw new DOMException('The object can not be found here.');
  }
};
