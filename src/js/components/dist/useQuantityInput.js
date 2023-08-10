/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
const __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
  function adopt(value) { return value instanceof P ? value : new P((resolve) => { resolve(value); }); }
  return new (P || (P = Promise))((resolve, reject) => {
    function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
    function rejected(value) { try { step(generator.throw(value)); } catch (e) { reject(e); } }
    function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
    step((generator = generator.apply(thisArg, _arguments || [])).next());
  });
};
const __generator = (this && this.__generator) || function (thisArg, body) {
  let _ = {
    label: 0, sent() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [],
  }; let f; let y; let t; let
    g;

  return g = {next: verb(0), throw: verb(1), return: verb(2)}, typeof Symbol === 'function' && (g[Symbol.iterator] = function () { return this; }), g;
  function verb(n) { return function (v) { return step([n, v]); }; }
  function step(op) {
    if (f) throw new TypeError('Generator is already executing.');
    while (_) {
      try {
        if (f = 1, y && (t = op[0] & 2 ? y.return : op[0] ? y.throw || ((t = y.return) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
        if (y = 0, t) op = [op[0] & 2, t.value];
        switch (op[0]) {
          case 0: case 1: t = op; break;
          case 4: _.label++; return {value: op[1], done: false};
          case 5: _.label++; y = op[1]; op = [0]; continue;
          case 7: op = _.ops.pop(); _.trys.pop(); continue;
          default:
            if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
            if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
            if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
            if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
            if (t[2]) _.ops.pop();
            _.trys.pop(); continue;
        }
        op = body.call(thisArg, _);
      } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
    }
    if (op[0] & 5) throw op[1]; return {value: op[0] ? op[1] : void 0, done: true};
  }
};
exports.__esModule = true;
const useQuantityInput_data_1 = require('@constants/useQuantityInput-data');
const selectors_map_1 = require('@constants/selectors-map');
const debounce_1 = require('@helpers/debounce');
const useAlert_1 = require('./useAlert');
const useToast_1 = require('./useToast');

const ENTER_KEY = 'Enter';
const ESCAPE_KEY = 'Escape';
const ARROW_UP_KEY = 'ArrowUp';
const ARROW_DOWN_KEY = 'ArrowDown';
const useQuantityInput = function (selector, delay) {
  if (selector === void 0) { selector = selectors_map_1.qtyInput.default; }
  if (delay === void 0) { delay = useQuantityInput_data_1.default.delay; }
  const qtyInputNodeList = document.querySelectorAll(selector);
  qtyInputNodeList.forEach((qtyInputWrapper) => {
    const qtyInput = qtyInputWrapper.querySelector('input');

    if (qtyInput) {
      const incrementButton = qtyInputWrapper.querySelector(selectors_map_1.qtyInput.increment);
      const decrementButton = qtyInputWrapper.querySelector(selectors_map_1.qtyInput.decrement);

      if (incrementButton && decrementButton) {
        const qtyInputGroup_1 = {qtyInput, incrementButton, decrementButton};
        // The changeQuantity() will be called immediatly and change the input value for Mouse actions
        incrementButton.addEventListener('click', () => changeQuantity(qtyInput, 1));
        decrementButton.addEventListener('click', () => changeQuantity(qtyInput, -1));
        // The changeQuantity() will be called immediatly and change the input value for Keyboard actions
        qtyInput.addEventListener('keydown', (event) => {
          if (event.key === ARROW_UP_KEY) {
            changeQuantity(qtyInput, 1, true);
          }
          if (event.key === ARROW_DOWN_KEY) {
            changeQuantity(qtyInput, -1, true);
          }
        });
        // The updateQuantity() will be called after timeout and send the update request with current input value
        if (qtyInput.hasAttribute('data-update-url')) {
          incrementButton.addEventListener('click', debounce_1.default(() => __awaiter(void 0, void 0, void 0, function () {
            return __generator(this, (_a) => {
              updateQuantity(qtyInputGroup_1, 1);
              return [2];
            });
          }), delay));
          decrementButton.addEventListener('click', debounce_1.default(() => __awaiter(void 0, void 0, void 0, function () {
            return __generator(this, (_a) => {
              updateQuantity(qtyInputGroup_1, -1);
              return [2];
            });
          }), delay));
          // If the input element has update URL (e.g. Cart)
          // then convert the buttons when user changed the value manually
          qtyInput.addEventListener('keyup', (event) => {
            const baseValue = qtyInput.getAttribute('value');

            if (qtyInput.value !== baseValue) {
              showConfirmationButtons(qtyInputGroup_1);
            } else {
              showSpinButtons(qtyInputGroup_1);
            }
            if (event.key === ENTER_KEY) {
              updateQuantity(qtyInputGroup_1, 1);
            }
            if (event.key === ESCAPE_KEY) {
              showSpinButtons(qtyInputGroup_1);
            }
          });
        }
      }
    }
  });
};
const isValidInputNum = function (inputNum) { return !Number.isNaN(inputNum) && Number.isInteger(inputNum); };
var changeQuantity = function (qtyInput, change, keyboard) {
  if (keyboard === void 0) { keyboard = false; }
  const {mode} = qtyInput.dataset;

  if (mode !== 'confirmation' || keyboard) {
    const baseValue = Number(qtyInput.getAttribute('value'));
    const currentValue = Number(qtyInput.value);
    const min = (qtyInput.dataset.updateUrl === undefined) ? Number(qtyInput.getAttribute('min')) : 0;
    const newValue = Math.max(currentValue + change, min);
    qtyInput.value = String(isValidInputNum(newValue) ? newValue : baseValue);
  }
};
var updateQuantity = function (qtyInputGroup, change) {
  return __awaiter(void 0, void 0, void 0, function () {
    let prestashop; let events; let qtyInput; let mode; let targetValue; let baseValue; let quantity; let requestUrl; let targetButton; let targetButtonIcon; let targetButtonSpinner; let response; let data_1; var errors; let productAlertSelector_1; var errors; let productData; let diff; let error_1; let errorData; let errorMsg; let
      productAlertSelector;
    let _a; let
      _b;

    return __generator(this, (_c) => {
      switch (_c.label) {
        case 0:
          prestashop = window.prestashop, events = window.Theme.events;
          qtyInput = qtyInputGroup.qtyInput;
          mode = qtyInput.dataset.mode;
          if (!(mode === 'confirmation' && change < 0)) return [3 /* break */, 1];
          showSpinButtons(qtyInputGroup);
          return [3 /* break */, 13];
        case 1:
          targetValue = Number(qtyInput.value);
          baseValue = Number(qtyInput.getAttribute('value'));
          quantity = targetValue - baseValue;
          if (!(isValidInputNum(targetValue) && quantity !== 0)) return [3 /* break */, 12];
          requestUrl = qtyInput.dataset.updateUrl;
          if (!(requestUrl !== undefined)) return [3 /* break */, 11];
          targetButton = getTargetButton(qtyInputGroup, change);
          targetButtonIcon = targetButton.querySelector('i:not(.d-none)');
          targetButtonSpinner = targetButton.querySelector(selectors_map_1.qtyInput.spinner);
          toggleButtonSpinner(targetButton, targetButtonIcon, targetButtonSpinner);
          _c.label = 2;
        case 2:
          _c.trys.push([2, 9, 10, 11]);
          return [4 /* yield */, sendUpdateCartRequest(requestUrl, quantity)];
        case 3:
          response = _c.sent();
          if (!response.ok) return [3 /* break */, 7];
          return [4 /* yield */, response.json()];
        case 4:
          data_1 = _c.sent();
          if (data_1.hasError) {
            errors = data_1.errors;
            productAlertSelector_1 = resetAlertContainer(qtyInput);
            if (errors && productAlertSelector_1) {
              errors.forEach((error) => {
                useAlert_1.default(error, {type: 'danger', selector: productAlertSelector_1}).show();
              });
            }
          } else {
            errors = data_1.errors;
            if (errors) {
              useToast_1.default(errors, {type: 'danger', autohide: false}).show();
            }
          }
          if (!(((_b = (_a = data_1.cart) === null || _a === void 0 ? void 0 : _a.products) === null || _b === void 0 ? void 0 : _b.length) > 0)) return [3 /* break */, 6];
          productData = data_1.cart.products.find((product) => data_1.id_product === Number(product.id_product)
                    && data_1.id_product_attribute === Number(product.id_product_attribute));
          if (!(productData
                    && productData.availability === 'unavailable'
                    && productData.allow_oosp === 0
                    && Number(productData.quantity_wanted) > Number(productData.stock_quantity))) return [3 /* break */, 6];
          diff = Number(productData.stock_quantity) - Number(productData.quantity_wanted);
          return [4 /* yield */, sendUpdateCartRequest(productData.update_quantity_url, diff)];
        case 5:
          _c.sent();
          _c.label = 6;
        case 6:
          prestashop.emit(events.updateCart, {
            reason: qtyInput.dataset,
            resp: data_1,
          });
          // Change the input value based on returned quantity
          qtyInput.value = data_1.quantity;
          // If user used the confirmation mode, need to update input value in the DOM
          qtyInput.setAttribute('value', data_1.quantity);
          return [3 /* break */, 8];
        case 7:
        // Something went wrong so call the catch block
          throw response;
        case 8: return [3 /* break */, 11];
        case 9:
          error_1 = _c.sent();
          // An error has occurred on update so revert to the value in the DOM
          qtyInput.value = String(baseValue);
          errorData = error_1;
          if (errorData.status !== undefined) {
            errorMsg = `${errorData.statusText}: ${errorData.url}`;
            productAlertSelector = resetAlertContainer(qtyInput);
            useAlert_1.default(errorMsg, {type: 'danger', selector: productAlertSelector}).show();
            prestashop.emit(events.handleError, {
              eventType: 'updateProductInCart',
              resp: errorData,
            });
          }
          return [3 /* break */, 11];
        case 10:
          toggleButtonSpinner(targetButton, targetButtonIcon, targetButtonSpinner);
          showSpinButtons(qtyInputGroup);
          return [7];
        case 11: return [3 /* break */, 13];
        case 12:
        // The input value is not a correct number
          showSpinButtons(qtyInputGroup);
          _c.label = 13;
        case 13: return [2];
      }
    });
  });
};
var getTargetButton = function (qtyInputGroup, change) {
  const {incrementButton} = qtyInputGroup;
  const {decrementButton} = qtyInputGroup;

  return (change > 0) ? incrementButton : decrementButton;
};
var resetAlertContainer = function (qtyInput) {
  const {alertId} = qtyInput.dataset;

  if (alertId) {
    const productAlertSelector = selectors_map_1.qtyInput.alert(alertId);
    const productAlertContainer = document.querySelector(productAlertSelector);

    if (productAlertContainer) {
      productAlertContainer.innerHTML = '';
    }
    return productAlertSelector;
  }
  return undefined;
};
var toggleButtonSpinner = function (button, icon, spinner) {
  button.toggleAttribute('disabled');
  icon === null || icon === void 0 ? void 0 : icon.classList.toggle('d-none');
  spinner === null || spinner === void 0 ? void 0 : spinner.classList.toggle('d-none');
};
var showSpinButtons = function (qtyInputGroup) {
  const {qtyInput} = qtyInputGroup;
  const {incrementButton} = qtyInputGroup;
  const {decrementButton} = qtyInputGroup;
  const {mode} = qtyInput.dataset;

  if (mode === 'confirmation') {
    toggleButtonIcon(incrementButton, decrementButton);
    qtyInput.dataset.mode = 'spin';
    const baseValue = qtyInput.getAttribute('value');

    // Maybe user changed the input value manually bu not confirmed
    // so revert the input value based on the value in the DOM
    if (baseValue) {
      qtyInput.value = baseValue;
    }
  }
};
var showConfirmationButtons = function (qtyInputGroup) {
  const {qtyInput} = qtyInputGroup;
  const {incrementButton} = qtyInputGroup;
  const {decrementButton} = qtyInputGroup;
  const {mode} = qtyInput.dataset;

  if (mode !== 'confirmation') {
    toggleButtonIcon(incrementButton, decrementButton);
    qtyInput.dataset.mode = 'confirmation';
  }
};
var toggleButtonIcon = function (incrementButton, decrementButton) {
  const incrementButtonIcons = incrementButton.querySelectorAll('i');
  incrementButtonIcons.forEach((icon) => {
    icon.classList.toggle('d-none');
  });
  const decrementButtonIcons = decrementButton.querySelectorAll('i');
  decrementButtonIcons.forEach((icon) => {
    icon.classList.toggle('d-none');
  });
};
var sendUpdateCartRequest = function (updateUrl, quantity) {
  return __awaiter(void 0, void 0, void 0, function () {
    let formData; let
      response;

    return __generator(this, (_a) => {
      switch (_a.label) {
        case 0:
          formData = new FormData();
          formData.append('ajax', '1');
          formData.append('action', 'update');
          formData.append('qty', String(Math.abs(quantity)));
          formData.append('op', (quantity > 0) ? 'up' : 'down');
          return [4 /* yield */, fetch(updateUrl, {
            method: 'POST',
            headers: {
              Accept: 'application/json, text/javascript, */*; q=0.01',
            },
            body: formData,
          })];
        case 1:
          response = _a.sent();
          return [2 /* return */, response];
      }
    });
  });
};
document.addEventListener('DOMContentLoaded', () => {
  const {prestashop} = window;
  const _a = window.Theme;
  const {events} = _a;
  const {selectors} = _a;
  prestashop.on(events.updatedCart, () => {
    useQuantityInput(selectors_map_1.qtyInput.productCartList);
    const cartMap = selectors.cart;
    const cartOverview = document.querySelector(cartMap.overview);
    cartOverview === null || cartOverview === void 0 ? void 0 : cartOverview.focus();
  });
  prestashop.on(events.quickviewOpened, () => useQuantityInput(selectors_map_1.qtyInput.modal));
});
exports.default = useQuantityInput;
