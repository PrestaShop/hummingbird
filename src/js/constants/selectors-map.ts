/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
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

export const blockcart = {
  modal: '#blockcart-modal',
};

export const currencySelector = {
  currencySelector: '.js-currency-selector',
};

export const languageSelector = {
  languageSelector: '.js-language-selector',
};

export const searchBar = {
  searchCanvas: '.js-search-offcanvas',
  searchWidget: '.js-search-widget',
  searchDropdown: '.js-search-dropdown',
  searchResults: '.js-search-results',
  searchTemplate: '.js-search-template',
  searchInput: '.js-search-input',
};

export const checkout = {
  steps: {
    item: '.js-step-item',
    current: '.js-current-step',
    shownResponsiveStep: '.checkout__steps__step:not(.d-none)',
    specificStep: (param: string | undefined) => `.checkout__steps__step[data-step="${param}"]`,
    specificStepContent: (param: string | undefined) => `#${param}`,
    backButton: (param: string | undefined) => `.js-step-item button[data-bs-target="#${param}"]`,
  },
  actionsButtons: '.js-back, .js-edit-addresses, .js-edit-shipping',
  termsLink: '.js-terms a',
  checkoutModal: '#checkout-modal',
};

export const progressRing = {
  checkout: {
    element: '.progress-ring',
    circle: '.progress-ring__circle',
    backgroundCircle: '.progress-ring__background-circle',
  },
  text: '.progress-ring text',
};

export const mobileMenu = {
  openChildsButton: '.js-menu-open-child',
  backTitle: '.js-menu-back-title',
  backButton: '.js-back-button',
  menuCanvas: '.js-menu-canvas',
  menuCurrent: '.menu--current',
  specificParent: (param: string | undefined) => `.menu--parent[data-depth="${param}"]`,
  specificChild: (param: string | undefined) => `.menu[data-id="${param}"]`,
};

export const visiblePassword = {
  visiblePassword: '.js-visible-password',
};

export const dropdownToggles = {
  dropdownToggles: '.js-menu-desktop .dropdown .dropdown-toggle[data-depth]',
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
  modalBody: '.modal-body',
  pageCms: '.page-cms',
  quickview: '.js-quickview',
  facetedsearch,
  pageLoader,
  listing,
  cart,
  progressRing,
  checkout,
  blockcart,
  currencySelector,
  languageSelector,
  searchBar,
  mobileMenu,
  visiblePassword,
  dropdownToggles,
};

export default selectorsMap;
