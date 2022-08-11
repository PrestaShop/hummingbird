/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
import themeSelectors from './constants/selectors-map';
import EVENTS from './constants/events-map';
import initEmitter from './prestashop';
import initResponsiveToggler from './responsive-toggler';
import initQuickview from './quickview';
import initCustomer from './pages/customer';
import initMobileMenu from './mobile-menu';
import initSearchbar from './modules/ps_searchbar';
import initVisiblePassword from './visible-password';
import useToast from './components/useToast';
import useAlert from './components/useAlert';
import useProgressRing from './components/useProgressRing';
import useQuantityInput from './components/useQuantityInput';
import initDesktopMenu from './modules/ps_mainmenu';
import initFormValidation from './form-validation';

initEmitter();

$(() => {
  const {prestashop, Theme: {events}} = window;

  initQuickview();
  initCustomer();
  initResponsiveToggler();
  useQuantityInput();
  initSearchbar();
  initMobileMenu();
  initVisiblePassword();
  initDesktopMenu();
  initFormValidation();

  prestashop.on(events.responsiveUpdate, () => {
    initSearchbar();
    initDesktopMenu();
  });
});

export const components = {
  useToast,
  useAlert,
  useProgressRing,
  useQuantityInput,
};

export const selectors = themeSelectors;

export const events = EVENTS;

window.Theme = {
  default: {
    initQuickview,
    initResponsiveToggler,
    useQuantityInput,
    initSearchbar,
    initMobileMenu,
    initVisiblePassword,
    initDesktopMenu,
  },
  events,
  components,
  selectors,
};
