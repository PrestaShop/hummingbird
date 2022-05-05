/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import selectorsMap from '@constants/selectors-map';
import useToast from '@js/components/useToast';
import * as Toastify from '@constants/mocks/useToast-data';
import resetHTMLBodyContent from '@helpers/resetBody';

describe('useToast', () => {
  describe('wrapper functions', () => {
    beforeAll(() => {
      resetHTMLBodyContent(Toastify.WithContainerWithTemplate);
      console.group = jest.fn();
      console.error = jest.fn();
      console.info = jest.fn();
    });

    it('must returns false when useToast failed to initialize', () => {
      const {
        show: showToast,
        hide: hideToast,
        dispose: disposeToast,
        message: toastMessage,
        remove: removeToast,
      } = useToast('', {type: 'info', template: 'dummy'});

      expect(console.error).toHaveBeenCalledTimes(1);
      expect(showToast()).toBeFalsy();
      expect(hideToast()).toBeFalsy();
      expect(disposeToast()).toBeFalsy();
      expect(toastMessage()).toBeFalsy();
      expect(removeToast()).toBeFalsy();
    });

    it('must returns true when useToast successfully initialized', () => {
      const {
        show: showToast,
        hide: hideToast,
        dispose: disposeToast,
        message: toastMessage,
        remove: removeToast,
      } = useToast('');

      toastMessage(Toastify.TestMarkupMessage);

      expect(showToast()).toBeTruthy();
      expect(hideToast()).toBeTruthy();
      expect(disposeToast()).toBeTruthy();
      expect(toastMessage()).toEqual(Toastify.TestMarkupMessage);
      expect(removeToast()).toBeTruthy();
    });

    it('must returns false when useToast initialized but afterwhile toast element is removed', () => {
      const {
        show: showToast,
        hide: hideToast,
        dispose: disposeToast,
        message: toastMessage,
        remove: removeToast,
      } = useToast('');

      removeToast();

      expect(showToast()).toBeFalsy();
      expect(hideToast()).toBeFalsy();
      expect(disposeToast()).toBeFalsy();
      expect(toastMessage()).toBeFalsy();
      expect(removeToast()).toBeFalsy();
    });
  });

  describe('with container and template existing in the DOM', () => {
    beforeEach(() => {
      resetHTMLBodyContent(Toastify.WithContainerWithTemplate);
    });

    it('should display the HTML markup message when used', () => {
      const {show: showToast, message: toastMessage} = useToast(Toastify.TestMarkupMessage);
      showToast();

      expect(toastMessage()).toEqual(Toastify.TestMarkupMessage);
    });

    it('should style the toast as same as the type when is set', () => {
      const {show: showToast, element: toastElement} = useToast('', Toastify.TestTypeOption);
      showToast();
      const toastClassList = toastElement?.classList.toString();

      expect(toastClassList).toMatch(new RegExp(Toastify.ExpectedTypeClassList));
    });

    it('should add the custom class list to the toast when is set', () => {
      const {show: showToast, element: toastElement} = useToast('', Toastify.TestClassListOption);
      showToast();
      const toastClassList = toastElement?.classList.toString();
      const customClassList = Toastify.TestClassListOption.classlist?.toString() ?? '';

      expect(toastClassList).toMatch(new RegExp(customClassList));
    });

    it('should display the close button when autohide is false', () => {
      const {show: showToast, element: toastElement} = useToast('', Toastify.TestAutoHideOption);
      showToast();
      const closeButtonElement = toastElement?.querySelector<HTMLButtonElement>(selectorsMap.toast.close);
      const closeBtnClassList = closeButtonElement?.classList.toString();

      expect(closeBtnClassList).toEqual(expect.not.stringContaining('d-none'));
    });
  });

  describe('without container or existing empty container in the DOM', () => {
    it('should append fallback container to the DOM if container is not exists', () => {
      resetHTMLBodyContent(Toastify.WithoutContainer);

      const {show: showToast, element: toastElement} = useToast('');
      showToast();
      const toastContainer = toastElement?.parentElement;
      const toastContainerClassList = toastContainer?.classList.toString();

      expect(toastContainerClassList).toEqual(expect.stringContaining(Toastify.FallbackContainerClass));
    });

    it('should append fallback template to the existing empty container in the DOM', () => {
      resetHTMLBodyContent(Toastify.WithContainerWithoutTemplate);

      const {show: showToast, element: toastElement} = useToast('');
      showToast();
      const toastClassList = toastElement?.classList.toString();
      const toastContainer = toastElement?.parentElement;
      const toastContainerClassList = toastContainer?.classList.toString();

      expect(toastClassList).toEqual(expect.stringContaining(Toastify.FallbackToastClass));
      expect(toastContainerClassList).toEqual(expect.not.stringContaining(Toastify.FallbackContainerClass));
    });
  });

  describe('with override template option', () => {
    it('should append override template to the existing container in the DOM', () => {
      resetHTMLBodyContent(Toastify.WithContainerWithoutTemplate);

      const {show: showToast, element: toastElement} = useToast('', Toastify.TestTemplateOption);
      showToast();
      const toastClassList = toastElement?.classList.toString();

      expect(toastClassList).toEqual(expect.stringContaining(Toastify.OverrideToastClass));
    });

    it('should append override template to the fallback container if container is not exists in the DOM', () => {
      resetHTMLBodyContent(Toastify.WithoutContainer);

      const {show: showToast, element: toastElement} = useToast('', Toastify.TestTemplateOption);
      showToast();
      const toastClassList = toastElement?.classList.toString();
      const toastContainer = toastElement?.parentElement;
      const toastContainerClassList = toastContainer?.classList.toString();

      expect(toastClassList).toEqual(expect.stringContaining(Toastify.OverrideToastClass));
      expect(toastContainerClassList).toEqual(expect.stringContaining(Toastify.FallbackContainerClass));
    });
  });
});
