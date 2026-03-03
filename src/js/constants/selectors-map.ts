/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

export const layout = {
  stickyHeader: '.js-sticky-header',
};

export const facetedsearch = {
  range: '.js-faceted-slider',
  rangeContainer: '.js-faceted-slider-container',
  rangeValues: '.js-faceted-values',
  filterSlider: '.js-faceted-filter-slider',
  offCanvasFaceted: '#offcanvas-faceted',
  colorLabel: '[data-ps-ref="color-label"]',
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
  listFooter: '#js-product-list-footer',
  searchFiltersClearAll: '.js-search-filters-clear-all',
  searchLink: '.js-search-link',
  paginationLink: '.js-pager-link',
};

export const cart = {
  container: '.js-cart-container',
  summaryContainer: '.js-cart-summary',
  overview: '.js-cart',
  voucherCode: '.js-voucher-code',
  voucherInput: '.js-voucher-input',
  voucherAccordion: '.js-voucher-accordion',
  productQuantity: '.js-cart-list .js-quantity-button',
  productItem: '.js-cart-item',
  productItemQuantityInput: '.js-cart-line-product-quantity',
  removeFromCart: '.js-remove-from-cart',
  alertPlaceholder: '.js-cart-update-alert',
  deleteLinkAction: 'delete-from-cart',
  removeVoucherLinkAction: 'remove-voucher',
  voucherContainer: '[data-ps-ref="voucher-container"]',
  voucherAccordionButton: '[data-ps-ref="voucher-accordion-button"]',
  voucherForm: '[data-ps-ref="voucher-form"]',
  voucherList: '[data-ps-ref="voucher-list"]',
  voucherError: '[data-ps-ref="voucher-error"]',
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
  searchIcon: '.js-search-icon',
  searchClear: '.js-search-clear',
  searchResultLink: '[data-ps-ref="searchbar-result-link"]',
};

export const checkout = {
  steps: {
    item: '.js-step-item',
    current: '.js-current-step',
    button: '[data-ps-ref="step-button"]',
    shownResponsiveStep: '.checkout-steps__step-mobile:not(.d-none)',
    specificStep: (param: string | undefined) => `.checkout-steps__step-mobile[data-step="${param}"]`,
    specificStepContent: (param: string | undefined) => `#${param}`,
    backButton: (param: string | undefined) => `.js-step-item button[data-bs-target="#${param}"]`,
  },
  actionsButtons: '.js-back, .js-edit-addresses, .js-edit-shipping',
  termsLink: '.js-terms a',
  checkoutModal: '#checkout-modal',
  carrierExtraContentWrapper: '.js-carrier-extra',
  carrierExtraContentWrapperActive: '.js-carrier-extra[data-active]',
  carrierExtraContent: '.js-carrier-extra-content',
  summaryContainer: '.js-checkout-summary',
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

export const guestPasswordToggle = {
  checkbox: '.js-password-form__check',
  passwordWrapper: '.js-password-form__input-wrapper',
};

export const visiblePassword = {
  visiblePassword: '[data-ps-action="toggle-password"]',
};

export const onePageCheckout = {
  form: '.one-page-checkout',
  useSameAddress: '.js-opc-use-same-address',
  billingSection: '#opc-billing-section',
  payButton: '#opc-pay-button',
};

export const gdpr = {
  consent: '[data-ps-ref="gdpr-consent"]',
  consentWrapper: '[data-ps-component="gdpr"]',
  checkbox: '[data-ps-ref="gdpr-checkbox"]',
  submitButton: '[data-ps-ref="gdpr-submit"]',
};

export const emailAlerts = {
  wrapper: '[data-ps-ref="emailalerts"]',
  content: '[data-ps-ref="emailalerts-content"]',
  submitButton: '[data-ps-action="emailalerts-subscribe"]',
  emailInput: '[data-ps-ref="emailalerts-email"]',
  alertsContainer: '[data-ps-target="emailalerts-alerts"]',
  deleteButton: '[data-ps-action="emailalerts-delete"]',
  product: '[data-ps-ref="emailalerts-product"]',
  productList: '[data-ps-ref="emailalerts-product-list"]',
  noAlerts: '[data-ps-ref="emailalerts-account-no-alerts"]',
};

export const desktopMenu = {
  container: '[data-ps-ref="desktop-menu-container"]',
  menuTree: '[data-ps-ref="desktop-menu-tree"]',
  menuItem: '[data-ps-ref="desktop-menu-item"]',
  menuLink: '[data-ps-ref="desktop-menu-link"]',
  dropdownToggle: '[data-ps-ref="desktop-menu-dropdown-toggle"]',
  subMenu: '[data-ps-ref="desktop-submenu"]',
  subMenuLeft: '[data-ps-ref="desktop-submenu-left"]',
  subMenuLeftItem: '[data-ps-ref="desktop-submenu-left-item"]',
  subMenuRight: '[data-ps-ref="desktop-submenu-right"]',
  subMenuRightItems: '[data-ps-ref="desktop-submenu-right-items"]',
};

export const qtyInput = {
  default: '.js-quantity-button',
  idProductInput: 'input[name="id_product"]',
  modal: '.modal-dialog .js-quantity-button',
  increment: '.js-increment-button',
  decrement: '.js-decrement-button',
  quantityWanted: '.js-quantity-wanted',
  confirm: '.confirmation',
  icon: '.material-icons',
  spinner: '.spinner-border',
  alert: (param: string): string => `#js-product-line-alert--${param}`,
};

export const formValidation = {
  default: '[data-ps-action="form-validation"]',
  submitButton: '[data-ps-action="form-validation-submit"]',
};

export const passwordPolicy = {
  template: '[data-ps-ref="password-feedback-template"]',
  field: '[data-ps-ref="password-field"]',
  input: '[data-ps-ref="password-policy-input"]',
  feedbackContainer: '[data-ps-ref="password-feedback-container"]',
  feedbackTarget: '[data-ps-target="password-feedback-target"]',
  hint: '[data-ps-ref="password-strength-hints"]',
  requirementScore: '[data-ps-ref="password-requirements-score"]',
  requirementLength: '[data-ps-ref="password-requirements-length"]',
  requirementScoreMessage: '[data-ps-ref="password-requirements-score-message"]',
  requirementLengthMessage: '[data-ps-ref="password-requirements-length-message"]',
  requirementScoreIcon: '[data-ps-ref="password-requirements-score-icon"]',
  requirementLengthIcon: '[data-ps-ref="password-requirements-length-icon"]',
  progressBar: '[data-ps-ref="password-strength-progress-bar"]',
  invalidMessage: '[data-ps-ref="password-invalid-message"]',
  validMessage: '[data-ps-ref="password-valid-message"]',
  lengthMessage: '[data-ps-ref="password-length-message"]',
  announceValidity: '[data-ps-target="password-announce-validity"]',
};

const selectorsMap = {
  layout,
  qtyInput,
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
    container: '[data-ps-ref="product-container"]',
    images: '.js-images-container',
    carousel: '.js-product-carousel',
    miniature: '.js-product-miniature',
    thumbnail: '.js-thumb-container',
    productImagesModal: '[data-ps-ref="product-images-modal"]',
    productImagesModalCarousel: '[data-ps-ref="product-images-modal-carousel"]',
    activeThumbail: (id: number): string => `.js-thumb-container:nth-child(${id + 1})`,
    productAvailability: '[data-ps-ref="product-availability"]',
    rightSection: '[data-ps-ref="product-right"]',
  },
  order: {
    returnForm: '.js-order-return-form',
    returnFormSelectAll: '[data-ps-ref="select-all-products"]',
    returnFormProductsTable: '[data-ps-ref="order-return-products-table"]',
    returnFormProductCheckbox: '[data-ps-ref="select-product"]',
  },
  modalBody: '.modal-body',
  pageCms: '.js-page-content-cms',
  quickview: '[data-ps-action="open-quickview"]',
  quickviewModal: '[data-ps-ref="quickview-modal"]',
  quickviewModalStatus: '[data-ps-target="quickview-modal-status"]',
  quickviewButton: '[data-ps-ref="quickview-button"]',
  modalContainer: '[data-ps-target="modal-container"]',
  blockcartModal: '[data-ps-ref="blockcart-modal"]',
  blockcartModalStatus: '[data-ps-target="blockcart-modal-status"]',
  addToCartButton: '[data-ps-ref="add-to-cart"]',
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
  guestPasswordToggle,
  visiblePassword,
  desktopMenu,
  formValidation,
  passwordPolicy,
  emailAlerts,
  onePageCheckout,
  gdpr,
};

export default selectorsMap;
