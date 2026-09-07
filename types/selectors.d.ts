/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */
import {qtyInput} from "@constants/selectors-map";

declare type facetedsearch = {
  rangeContainer: string,
  filterSlider: string,
  offCanvasFaceted: string,
};

declare type pageLoader = string;

declare type listing = {
  searchFilters: string,
  activeSearchFilters: string,
  listTop: string,
  list: string,
  listBottom: string,
  listHeader: string,
  searchFiltersClearAll: string,
  searchLink: string,
  paginationLink: string,
};

declare type cart = {
  overview: string,
  voucherCode: string,
  voucherInput: string,
  voucherAccordion: string,
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
  carrierExtraContentWrapperActive: string,
  carrierExtraContent: string,
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
  container: string,
  menuTree: string,
  menuItem: string,
  menuLink: string,
  dropdownToggle: string,
  subMenu: string,
  subMenuLeft: string,
  subMenuLeftItem: string,
  subMenuRight: string,
  subMenuRightItems: string,
};

declare type quantityInput = {
  default: string,
  modal: string,
  increment: string,
  decrement: string,
  quantityWanted: string,
  confirm: string,
  spinner: string,
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
