/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
import themeSelectors from '@constants/selectors-map';
import EVENTS from '@constants/events-map';
import initEmitter from '@js/prestashop';
import initResponsiveToggler from '@js/responsive-toggler';
import initQuickview from '@js/quickview';
import initCart from '@js/pages/cart';
import initCheckout from '@js/pages/checkout';
import initCustomer from '@js/pages/customer';
import initProductBehavior from '@js/product';
import initMobileMenu from '@js/mobile-menu';
import initSearchbar from '@js/modules/ps_searchbar';
import initLanguageSelector from '@js/modules/ps_languageselector';
import initCurrencySelector from '@js/modules/ps_currencyselector';
import initGuestPasswordToggle from '@js/guest-password-toggle';
import initVisiblePassword from '@js/visible-password';
import initErrorHandler from '@js/errors';
import useToast from '@js/components/useToast';
import useAlert from '@js/components/useAlert';
import usePasswordPolicy from '@js/components/usePasswordPolicy';
import useProgressRing from '@js/components/useProgressRing';
import useQuantityInput from '@js/components/useQuantityInput';
import initBlockCart from '@js/modules/blockcart';
import '@js/modules/facetedsearch';
import initDesktopMenu from '@js/modules/ps_mainmenu';
import initFormValidation from '@js/form-validation';
import initCategoryTree from '@js/modules/ps_categorytree';
import initScrollPaddingTop from '@helpers/scrollPadding';
import themeState from '@js/state';
import initProductAccessibility from '@js/accessibility/product';
import initCartAccessibility from '@js/accessibility/cart';

initEmitter();

document.addEventListener('DOMContentLoaded', () => {
  const {prestashop, Theme: {events}} = window;

  initProductBehavior();
  initQuickview();
  initCheckout();
  initCustomer();
  initResponsiveToggler();
  initCart();
  useQuantityInput();
  initSearchbar();
  initLanguageSelector();
  initCurrencySelector();
  initMobileMenu();
  initGuestPasswordToggle();
  initVisiblePassword();
  initDesktopMenu();
  initFormValidation();
  initErrorHandler();
  usePasswordPolicy();
  initCategoryTree();
  initScrollPaddingTop();
  initBlockCart();
  // Accessibility
  initProductAccessibility();
  initCartAccessibility();

  prestashop.on(events.responsiveUpdate, () => {
    initSearchbar();
    initLanguageSelector();
    initCurrencySelector();
    initDesktopMenu();
  });
});

export const components = {
  useToast,
  useAlert,
  useProgressRing,
  useQuantityInput,
};

export const state = themeState;

export const selectors = themeSelectors;

export const events = EVENTS;

export default {
  initProductBehavior,
  initQuickview,
  initCheckout,
  initResponsiveToggler,
  initCart,
  useQuantityInput,
  initSearchbar,
  initLanguageSelector,
  initCurrencySelector,
  initMobileMenu,
  initGuestPasswordToggle,
  initVisiblePassword,
  initDesktopMenu,
  initBlockCart,
};
