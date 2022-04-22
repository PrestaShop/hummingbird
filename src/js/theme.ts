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
import selectorsMap from './constants/selectors-map';
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

initEmitter();

window.prestashop.themeSelectors = selectorsMap;

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

  prestashop.on('responsiveUpdate', () => {
    initSearchbar();
    initLanguageSelector();
    initCurrencySelector();
  });

  prestashop.on('updatedCart', () => useQuantityInput());
});

export const components = {
  useToast,
  useAlert,
  useProgressRing,
  useQuantityInput,
};

export default {
  initResponsiveToggler,
  initQuickview,
  initProductBehavior,
};
