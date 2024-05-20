/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
import {qtyInput} from "@constants/selectors-map";

declare type facetedsearch = {
  range: string,
  rangeContainer: string,
  filterSlider: string,
  offCanvasFaceted: string,
};

declare type pageLoader = string;

declare type listing = {
  searchFilterToggler: string,
  searchFiltersWrapper: string,
  searchFilterControls: string,
  searchFilters: string,
  activeSearchFilters: string,
  listTop: string,
  product: string,
  list: string,
  listBottom: string,
  listHeader: string,
  searchFiltersClearAll: string,
  searchLink: string,
  pagerLink: string,
};

declare type cart = {
  overview: string,
  discountCode: string,
  discountName: string,
  displayPromo: string,
  promoCode: string,
  deleteLinkAction: string,
  container: string,
};

declare type blockcart = {
  modal: string,
};

declare type currencySelector = {
  currencySelector: string,
};

declare type languageSelector = {
  languageSelector: string,
};

declare type searchBar = {
  searchCanvas: string,
  searchWidget: string,
  searchDropdown: string,
  searchResults: string,
  searchTemplate: string,
  searchInput: string,
  searchIcon: string,
};

declare type checkout = {
  steps: {
    item: string,
    current: string,
    shownResponsiveStep: string,
    specificStep: (param: string | undefined) => string,
    specificStepContent: (param: string | undefined) => string,
    backButton: (param: string | undefined) => string,
  },
  actionsButtons: string,
  termsLink: string,
  checkoutModal: string,
  carrierExtraContentWrapper: string,
  carrierExtraContent: string,
  carrierExtraContentActive: string,
};

declare type progressRing = {
  checkout: {
    element: string,
    circle: string,
    backgroundCircle: string,
  },
  text: string,
};

declare type mobileMenu = {
  openChildsButton: string,
  backTitle: string,
  backButton: string,
  menuCanvas: string,
  menuCurrent: string,
  specificParent: (param: string | number | undefined) => string,
  specificChild: (param: string | number | undefined) => string,
};

declare type visiblePassword = {
  visiblePassword: string,
};

declare type desktopMenu = {
  dropdownToggles: string,
  dropdownItemAnchor: (depth: number) => string,
};

declare type quantityInput = {
  default: string,
  modal: string,
  increment: string,
  decrement: string,
  confirm: string,
  icon: string,
  spinner: string,
  alert: (param: string) => string,
};

declare type formValidation = {
  default: string,
};

type SelectorsMap = {
  alert: {
    selector: string,
    alert: string,
    heading: string,
    body: string,
    icon: string,
    close: string,
  },
  toast: {
    container: string,
    template: string,
    toast: string,
    body: string,
    close: string,
  },
  product: {
    carousel: string,
    miniature: string,
    thumbnail: string,
    activeThumbail: (id: number) => string,
  },
  modalBody: string,
  pageCms: string,
  quickview: string,
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
  qtyInput: quantityInput,
  formValidation: formValidation,
};
