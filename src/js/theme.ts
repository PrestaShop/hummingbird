/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
import themeSelectors from './constants/selectors-map';
import initEmitter from './prestashop';
import initResponsiveToggler from './responsive-toggler';
import initQuickview from './quickview';
import initCart from './pages/cart';
import initCheckout from './pages/checkout';
import initProductBehavior from './product';
import initMobileMenu from './mobile-menu';
import initSearchbar from './modules/ps_searchbar';
import initLanguageSelector from './modules/ps_languageselector';
import initCurrencySelector from './modules/ps_currencyselector';
import initVisiblePassword from './visible-password';
import useToast from './components/useToast';
import useAlert from './components/useAlert';
import useProgressRing from './components/useProgressRing';
import useQuantityInput from './components/useQuantityInput';
import './modules/blockcart';
import './modules/facetedsearch';
import initDesktopMenu from './modules/ps_mainmenu';

initEmitter();

$(() => {
  const {prestashop} = window;

  initProductBehavior();
  initQuickview();
  initCheckout();
  initResponsiveToggler();
  initCart();
  useQuantityInput();
  initSearchbar();
  initLanguageSelector();
  initCurrencySelector();
  initMobileMenu();
  initVisiblePassword();
  initDesktopMenu();

  prestashop.on('responsiveUpdate', () => {
    initSearchbar();
    initLanguageSelector();
    initCurrencySelector();
    initDesktopMenu();
  });

  prestashop.on('updatedCart', () => useQuantityInput());
});

export const components = {
  useToast,
  useAlert,
  useProgressRing,
  useQuantityInput,
};

export const selectors = themeSelectors;

export default {
  initResponsiveToggler,
  initQuickview,
  initProductBehavior,
};
