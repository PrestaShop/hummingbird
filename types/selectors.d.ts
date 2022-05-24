/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

declare type facetedsearch = {
  range: '.js-faceted-slider',
  rangeContainer: '.js-faceted-slider-container',
  filterSlider: '.js-faceted-filter-slider',
};

declare type pageLoader = '.js-page-loader';

declare type listing = {
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

declare type cart = {
  discountCode: '.js-discount .js-code',
  discountName: '[name=discount_name]',
  displayPromo: '.display-promo',
  promoCode: '#promo-code',
};

declare type blockcart = {
  modal: '#blockcart-modal',
};

declare type currencySelector = {
  currencySelector: '.js-currency-selector',
};

declare type languageSelector = {
  languageSelector: '.js-language-selector',
};

declare type searchBar = {
  searchCanvas: '.js-search-offcanvas',
  searchWidget: '.js-search-widget',
  searchDropdown: '.js-search-dropdown',
  searchResults: '.js-search-results',
  searchTemplate: '.js-search-template',
  searchInput: '.js-search-input',
};

declare type checkout = {
  steps: {
    item: '.js-step-item',
    current: '.js-current-step',
    shownResponsiveStep: '.checkout__steps__step:not(.d-none)',
    specificStep: (param: string | undefined) => string,
    specificStepContent: (param: string | undefined) => string,
    backButton: (param: string | undefined) => string,
  },
  actionsButtons: '.js-back, .js-edit-addresses, .js-edit-shipping',
  termsLink: '.js-terms a',
  checkoutModal: '#checkout-modal',
};

declare type progressRing = {
  checkout: {
    element: '.progress-ring',
    circle: '.progress-ring__circle',
    backgroundCircle: '.progress-ring__background-circle',
  },
  text: '.progress-ring text',
};

declare type mobileMenu = {
  openChildsButton: '.js-menu-open-child',
  backTitle: '.js-menu-back-title',
  backButton: '.js-back-button',
  menuCanvas: '.js-menu-canvas',
  menuCurrent: '.menu--current',
  specificParent: (param: string | number | undefined) => string,
  specificChild: (param: string | number | undefined) => string,
};

declare type visiblePassword = {
  visiblePassword: '.js-visible-password',
};

declare type desktopMenu = {
  dropdownToggles: '.js-menu-desktop .dropdown .dropdown-toggle[data-depth]',
  dropdownItemAnchor: (depth: number) => string,
};

declare type quantityInput = {
  default: '.js-quantity-button',
  modal: '.modal-dialog .js-quantity-button',
  increment: '.js-increment-button',
  decrement: '.js-decrement-button',
  confirm: '.confirmation',
  icon: '.material-icons',
  spinner: '.spinner-border',
  alert: (param: string) => string,
};

type SelectorsMap = {
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
    activeThumbail: (id: number) => string,
  },
  modalBody: '.modal-body',
  pageCms: '.page-cms',
  quickview: '.js-quickview',
  facetedsearch: facetedsearch,
  pageLoader: pageLoader,
  listing: listing,
  cart: cart,
  progressRing: progressRing,
  checkout: checkout,
  blockcart: blockcart,
  currencySelector: currencySelector,
  languageSelector: languageSelector,
  searchBar: searchBar,
  mobileMenu: mobileMenu,
  visiblePassword: visiblePassword,
  desktopMenu: desktopMenu,
  quantityInput: quantityInput,
};
