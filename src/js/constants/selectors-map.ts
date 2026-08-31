/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */

export const layout = {
  header: '[data-ps-ref="header"]',
};

export const facetedsearch = {
  rangeContainer: '[data-ps-ref="faceted-range-container"]',
  rangeValues: '[data-ps-ref="faceted-range-values"]',
  filterSlider: '[data-ps-ref="faceted-filter-slider"]',
  offCanvasFaceted: '[data-ps-ref="faceted-offcanvas"]',
  colorLabel: '[data-ps-ref="color-label"]',
};

export const pageLoader = '[data-ps-ref="page-loader"]';

export const listing = {
  searchFilters: '[data-ps-target="search-filters"]',
  activeSearchFilters: '[data-ps-target="active-search-filters"]',
  listTop: '[data-ps-target="product-list-top"]',
  list: '[data-ps-target="product-list"]',
  listBottom: '[data-ps-target="product-list-bottom"]',
  listHeader: '[data-ps-target="product-list-header"]',
  listFooter: '[data-ps-target="product-list-footer"]',
  searchFiltersClearAll: '[data-ps-action="clear-search-filters"]',
  searchLink: '[data-ps-action="apply-search-filter"]',
  paginationLink: '[data-ps-action="paginate"]',
};

export const cart = {
  container: '[data-ps-ref="cart-container"]',
  summaryContainer: '[data-ps-observe="cart-summary"]',
  overview: '[data-ps-ref="cart-overview"]',
  voucherCode: '[data-ps-action="fill-voucher-code"]',
  voucherInput: '[data-ps-ref="voucher-input"]',
  voucherAccordion: '[data-ps-ref="voucher-accordion"]',
  productQuantity: '[data-ps-ref="cart-list"] [data-ps-ref="quantity-input"]',
  productItem: '[data-ps-ref="cart-item"]',
  productItemQuantityInput: '[data-ps-ref="cart-line-quantity"]',
  removeFromCart: '[data-ps-action="remove-from-cart"]',
  alertPlaceholder: '[data-ps-target="cart-update-alert"]',
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
  currencySelector: '[data-ps-ref="currency-selector"]',
};

export const languageSelector = {
  languageSelector: '[data-ps-ref="language-selector"]',
};

export const searchBar = {
  searchCanvas: '[data-ps-ref="searchbar-offcanvas"]',
  searchWidget: '[data-ps-ref="searchbar-widget"]',
  searchDropdown: '[data-ps-ref="searchbar-dropdown"]',
  searchResults: '[data-ps-target="searchbar-results"]',
  searchTemplate: '[data-ps-template="searchbar-result"]',
  searchInput: '[data-ps-ref="searchbar-input"]',
  searchIcon: '[data-ps-action="searchbar-submit"]',
  searchClear: '[data-ps-action="searchbar-clear"]',
  searchResultLink: '[data-ps-ref="searchbar-result-link"]',
  searchResultImage: '[data-ps-ref="searchbar-result-image"]',
  searchResultName: '[data-ps-ref="searchbar-result-name"]',
};

export const checkout = {
  steps: {
    item: '[data-ps-ref="checkout-step-item"]',
    current: '[data-ps-ref="checkout-step-content"][data-ps-state="current"]',
    button: '[data-ps-ref="step-button"]',
    shownResponsiveStep: '[data-ps-ref="checkout-step-mobile"]:not(.d-none)',
    specificStep: (param: string | undefined) => `[data-ps-ref="checkout-step-mobile"][data-step="${param}"]`,
    specificStepContent: (param: string | undefined) => `#${param}`,
    backButton: (param: string | undefined) => `[data-ps-ref="checkout-step-item"] button[data-bs-target="#${param}"]`,
  },
  actionsButtons: '[data-ps-action="checkout-back"], [data-ps-action="edit-addresses"], [data-ps-action="edit-shipping"]',
  termsLink: '[data-ps-ref="terms-label"] a',
  checkoutModal: '#checkout-modal',
  carrierExtraContentWrapper: '[data-ps-ref="carrier-extra"]',
  carrierExtraContentWrapperActive: '[data-ps-ref="carrier-extra"][data-ps-state="active"]',
  carrierExtraContent: '[data-ps-ref="carrier-extra-content"]',
  summaryContainer: '[data-ps-observe="checkout-summary"]',
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
  openChildsButton: '[data-ps-action="open-menu-child"]',
  backTitle: '[data-ps-ref="menu-back-title"]',
  backButton: '[data-ps-action="menu-back"]',
  menuCanvas: '[data-ps-ref="menu-canvas"]',
  menuCurrent: '[data-ps-ref="menu-panel"][data-ps-state="current"]',
  specificParent: (param: string | undefined) => `[data-ps-ref="menu-panel"][data-ps-state="parent"][data-depth="${param}"]`,
  specificChild: (param: string | undefined) => `[data-ps-ref="menu-panel"][data-id="${param}"]`,
};

export const guestPasswordToggle = {
  checkbox: '[data-ps-ref="guest-password-checkbox"]',
  passwordWrapper: '[data-ps-ref="guest-password-container"]',
};

export const visiblePassword = {
  visiblePassword: '[data-ps-action="toggle-password"]',
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
  default: '[data-ps-ref="quantity-input"]',
  modal: '.modal-dialog [data-ps-ref="quantity-input"]',
  increment: '[data-ps-action="increment-quantity"]',
  decrement: '[data-ps-action="decrement-quantity"]',
  quantityWanted: '[data-ps-ref="quantity-wanted"]',
  confirm: '[data-ps-ref="quantity-confirm-icon"]',
  spinner: '.spinner-border',
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
    container: '[data-ps-ref="toast-container"]',
    template: '[data-ps-template="toast"]',
    toast: '.toast',
    body: '.toast-body',
    close: '.btn-close',
  },
  product: {
    container: '[data-ps-ref="product-container"]',
    images: '.js-images-container',
    carousel: '[data-ps-ref="product-carousel"]',
    miniature: '.js-product-miniature',
    thumbnail: '[data-ps-ref="product-thumbnail"]',
    productImagesModal: '[data-ps-ref="product-images-modal"]',
    productImagesModalCarousel: '[data-ps-ref="product-images-modal-carousel"]',
    activeThumbail: (id: number): string => `[data-ps-ref="product-thumbnail-item"]:nth-child(${id + 1}) [data-ps-ref="product-thumbnail"]`,
    productAvailability: '[data-ps-ref="product-availability"]',
    rightSection: '[data-ps-ref="product-right"]',
  },
  order: {
    returnForm: '[data-ps-ref="order-return-form"]',
    returnFormSelectAll: '[data-ps-ref="select-all-products"]',
    returnFormProductsTable: '[data-ps-ref="order-return-products-table"]',
    returnFormProductCheckbox: '[data-ps-ref="select-product"]',
  },
  modalBody: '.modal-body',
  pageCms: '[data-ps-ref="cms-content"]',
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
  gdpr,
};

export default selectorsMap;
