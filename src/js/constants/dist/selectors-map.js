/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
exports.__esModule = true;
exports.passwordPolicy = exports.formValidation = exports.qtyInput = exports.desktopMenu = exports.visiblePassword = exports.mobileMenu = exports.progressRing = exports.checkout = exports.searchBar = exports.languageSelector = exports.currencySelector = exports.blockcart = exports.cart = exports.listing = exports.pageLoader = exports.facetedsearch = void 0;
exports.facetedsearch = {
  range: '.js-faceted-slider',
  rangeContainer: '.js-faceted-slider-container',
  filterSlider: '.js-faceted-filter-slider',
  offCanvasFaceted: '#offcanvas-faceted',
};
exports.pageLoader = '.js-page-loader';
exports.listing = {
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
exports.cart = {
  container: '.cart-container',
  overview: '.cart-overview',
  discountCode: '.js-discount .js-code',
  discountName: '[name=discount_name]',
  displayPromo: '.display-promo',
  promoCode: '#promo-code',
  deleteLinkAction: 'delete-from-cart',
};
exports.blockcart = {
  modal: '#blockcart-modal',
};
exports.currencySelector = {
  currencySelector: '.js-currency-selector',
};
exports.languageSelector = {
  languageSelector: '.js-language-selector',
};
exports.searchBar = {
  searchCanvas: '.js-search-offcanvas',
  searchWidget: '.js-search-widget',
  searchDropdown: '.js-search-dropdown',
  searchResults: '.js-search-results',
  searchTemplate: '.js-search-template',
  searchInput: '.js-search-input',
};
exports.checkout = {
  steps: {
    item: '.js-step-item',
    current: '.js-current-step',
    shownResponsiveStep: '.checkout__steps__step:not(.d-none)',
    specificStep(param) { return `.checkout__steps__step[data-step="${param}"]`; },
    specificStepContent(param) { return `#${param}`; },
    backButton(param) { return `.js-step-item button[data-bs-target="#${param}"]`; },
  },
  actionsButtons: '.js-back, .js-edit-addresses, .js-edit-shipping',
  termsLink: '.js-terms a',
  checkoutModal: '#checkout-modal',
  carrierExtraContentWrapper: '.carrier__extra-content-wrapper',
  carrierExtraContent: '.carrier__extra-content',
  carrierExtraContentActive: '.carrier__extra-content-wrapper--active',
};
exports.progressRing = {
  checkout: {
    element: '.progress-ring',
    circle: '.progress-ring__circle',
    backgroundCircle: '.progress-ring__background-circle',
  },
  text: '.progress-ring text',
};
exports.mobileMenu = {
  openChildsButton: '.js-menu-open-child',
  backTitle: '.js-menu-back-title',
  backButton: '.js-back-button',
  menuCanvas: '.js-menu-canvas',
  menuCurrent: '.menu--current',
  specificParent(param) { return `.menu--parent[data-depth="${param}"]`; },
  specificChild(param) { return `.menu[data-id="${param}"]`; },
};
exports.visiblePassword = {
  visiblePassword: '.js-visible-password',
};
exports.desktopMenu = {
  dropdownToggles: '.js-menu-desktop .dropdown .dropdown-toggle[data-depth]',
  dropdownItemAnchor(depth) { return `.js-menu-desktop a[data-depth="${depth}"]`; },
};
exports.qtyInput = {
  default: '.js-quantity-button',
  productCartList: '.cart__items .js-quantity-button',
  modal: '.modal-dialog .js-quantity-button',
  increment: '.js-increment-button',
  decrement: '.js-decrement-button',
  confirm: '.confirmation',
  icon: '.material-icons',
  spinner: '.spinner-border',
  alert(param) { return `#js-product-line-alert--${param}`; },
};
exports.formValidation = {
  default: '.form-validation',
};
exports.passwordPolicy = {
  template: '#password-feedback',
  hint: '.js-hint-password',
  container: '.password-strength-feedback',
  strengthText: '.password-strength-text',
  requirementScore: '.password-requirements-score',
  requirementLength: '.password-requirements-length',
  requirementScoreIcon: '.password-requirements-score i',
  requirementLengthIcon: '.password-requirements-length i',
  progressBar: '.progress-bar',
};
const selectorsMap = {
  qtyInput: exports.qtyInput,
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
    activeThumbail(id) { return `.js-thumb-container:nth-child(${id + 1})`; },
  },
  order: {
    returnForm: '.js-order-return-form',
    returnFormMainCheckbox: '.js-order-return-form table thead input[type=checkbox]',
    returnFormItemCheckbox: '.js-order-return-form table tbody input[type=checkbox]',
  },
  modalBody: '.modal-body',
  pageCms: '.page-cms',
  quickview: '.js-quickview',
  quickviewModal: '.quickview',
  facetedsearch: exports.facetedsearch,
  pageLoader: exports.pageLoader,
  listing: exports.listing,
  cart: exports.cart,
  progressRing: exports.progressRing,
  checkout: exports.checkout,
  blockcart: exports.blockcart,
  currencySelector: exports.currencySelector,
  languageSelector: exports.languageSelector,
  searchBar: exports.searchBar,
  mobileMenu: exports.mobileMenu,
  visiblePassword: exports.visiblePassword,
  desktopMenu: exports.desktopMenu,
  formValidation: exports.formValidation,
  passwordPolicy: exports.passwordPolicy,
};
exports.default = selectorsMap;
