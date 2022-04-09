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

export const facetedsearch = {
  range: '.js-faceted-slider',
  rangeContainer: '.js-faceted-slider-container',
  filterSlider: '.js-faceted-filter-slider',
};

export const pageLoader = '.js-page-loader';

export const listing = {
  searchFilterToggler: '#search_filter_toggler, .js-search-toggler',
  searchFiltersWrapper: '#search_filters_wrapper',
  searchFilterControls: '#search_filter_controls',
  searchFilters: '#search-filters',
  activeSearchFilters: '#js-active-search-filters',
  listTop: '#js-product-list-top',
  product: '.js-product',
  list: '#js-product-list',
  listBottom: '#js-product-list-bottom',
  listHeader: '#js-product-list-header',
  searchFiltersClearAll: '.js-search-filters-clear-all',
  searchLink: '.js-search-link',
};

export const cart = {
  discountCode: '.js-discount .js-code',
  discountName: '[name=discount_name]',
  displayPromo: '.display-promo',
  promoCode: '#promo-code',
};

export const progressRing = {
  checkout: {
    element: '.progress-ring',
    circle: '.progress-ring__circle',
    backgroundCircle: '.progress-ring__background-circle',
  },
};

const selectorsMap = {
  qtyInput: {
    default: '.js-quantity-button',
    modal: '.modal-dialog .js-quantity-button',
    increment: '.js-increment-button',
    decrement: '.js-decrement-button',
    confirm: '.confirmation',
    icon: '.material-icons',
    spinner: '.spinner-border',
    alert: (id: number): string => `#js-product-line-alert--${id}`,
  },
  alert: {
    selector: '#notifications .container',
    alert: '.alert',
    heading: '.alert-heading',
    body: '.alert-body',
    icon: '.material-icons',
    close: '.btn-close',
  },
  toast: {
    container: '#js-toast-container',
    template: '.js-toast-template',
    toast: '.toast',
    body: '.toast-body',
    close: '.btn-close',
  },
  product: {
    carousel: '.js-product-carousel',
    miniature: '.js-product-miniature',
    thumbnail: '.js-thumb-container',
    activeThumbail: (id: number): string => `.js-thumb-container:nth-child(${id + 1})`,
  },
  quickview: '.js-quickview',
  facetedsearch,
  pageLoader,
  listing,
  cart,
  progressRing,
};

export default selectorsMap;

window.prestashop.themeSelectors = selectorsMap;
