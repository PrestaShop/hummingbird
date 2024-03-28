/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import Quantity from '@constants/useQuantityInput-data';
import {qtyInput as quantityInputMap, cart as cartSelectorMap} from '@constants/selectors-map';
import debounce from '@helpers/debounce';
import useAlert from './useAlert';
import useToast from './useToast';

const ENTER_KEY = 'Enter';
const ESCAPE_KEY = 'Escape';
const ARROW_UP_KEY = 'ArrowUp';
const ARROW_DOWN_KEY = 'ArrowDown';

const useQuantityInput: Theme.QuantityInput.Function = (
  selector = quantityInputMap.default, delay = Quantity.delay) => {
  const qtyInputNodeList = document.querySelectorAll<HTMLElement>(selector);

  qtyInputNodeList.forEach((qtyInputWrapper: HTMLElement) => {
    const qtyInput = qtyInputWrapper.querySelector<HTMLInputElement>('input');

    if (qtyInput) {
      const incrementButton = qtyInputWrapper.querySelector<HTMLButtonElement>(quantityInputMap.increment);
      const decrementButton = qtyInputWrapper.querySelector<HTMLButtonElement>(quantityInputMap.decrement);

      if (incrementButton && decrementButton) {
        const qtyInputGroup: Theme.QuantityInput.InputGroup = {qtyInput, incrementButton, decrementButton};

        // The changeQuantity() will be called immediatly and change the input value for Mouse actions
        incrementButton.addEventListener('click', () => changeQuantity(qtyInput, 1));
        decrementButton.addEventListener('click', () => changeQuantity(qtyInput, -1));

        // The changeQuantity() will be called immediatly and change the input value for Keyboard actions
        qtyInput.addEventListener('keydown', (event: KeyboardEvent) => {
          if (event.key === ARROW_UP_KEY) {
            changeQuantity(qtyInput, 1, true);
          }

          if (event.key === ARROW_DOWN_KEY) {
            changeQuantity(qtyInput, -1, true);
          }
        });

        // The updateQuantity() will be called after timeout and send the update request with current input value
        if (qtyInput.hasAttribute('data-update-url')) {
          incrementButton.addEventListener('click', debounce(async () => {
            updateQuantity(qtyInputGroup, 1);
          }, delay));
          decrementButton.addEventListener('click', debounce(async () => {
            updateQuantity(qtyInputGroup, -1);
          }, delay));

          // If the input element has update URL (e.g. Cart)
          // then convert the buttons when user changed the value manually
          qtyInput.addEventListener('keyup', (event: KeyboardEvent) => {
            const baseValue = qtyInput.getAttribute('value');

            if (qtyInput.value !== baseValue) {
              showConfirmationButtons(qtyInputGroup);
            } else {
              showSpinButtons(qtyInputGroup);
            }

            if (event.key === ENTER_KEY) {
              if (qtyInput.value === '0') {
                const targetItem = qtyInput.closest(cartSelectorMap.productItem);
                const removeButton = targetItem?.querySelector(cartSelectorMap.removeFromCartLink) as HTMLElement
                    | null;

                if (removeButton) {
                  removeButton.click();
                } else {
                  updateQuantity(qtyInputGroup, 1);
                }
              } else {
                updateQuantity(qtyInputGroup, 1);
              }
            }

            if (event.key === ESCAPE_KEY) {
              showSpinButtons(qtyInputGroup);
            }
          });
        }
      }
    }
  });
};

const isValidInputNum = (inputNum: number) => !Number.isNaN(inputNum) && Number.isInteger(inputNum);

const changeQuantity = (qtyInput: HTMLInputElement, change: number, keyboard = false) => {
  const {mode} = qtyInput.dataset;

  if (mode !== 'confirmation' || keyboard) {
    const baseValue = Number(qtyInput.getAttribute('value'));
    const currentValue = Number(qtyInput.value);
    const min = (qtyInput.dataset.updateUrl === undefined) ? Number(qtyInput.getAttribute('min')) : 0;
    const newValue = Math.max(currentValue + change, min);
    qtyInput.value = String(isValidInputNum(newValue) ? newValue : baseValue);
  }
};

const updateQuantity = async (qtyInputGroup: Theme.QuantityInput.InputGroup, change: number) => {
  const {prestashop, Theme: {events}} = window;
  const {qtyInput} = qtyInputGroup;
  const {mode} = qtyInput.dataset;

  // If confirmation buttons displayed and the Cancel button selected then change the buttons to the spin mode
  // else send the update request (user clicked spin buttons or the OK button in the confirmation mode)
  if (mode === 'confirmation' && change < 0) {
    showSpinButtons(qtyInputGroup);
  } else {
    const targetValue = Number(qtyInput.value);
    const baseValue = Number(qtyInput.getAttribute('value'));
    const quantity = targetValue - baseValue;

    if (isValidInputNum(targetValue) && quantity !== 0) {
      const requestUrl = qtyInput.dataset.updateUrl;

      if (requestUrl !== undefined) {
        const targetButton = getTargetButton(qtyInputGroup, change);
        const targetButtonIcon = targetButton.querySelector<HTMLElement>('i:not(.d-none)');
        const targetButtonSpinner = targetButton.querySelector<HTMLElement>(quantityInputMap.spinner);

        toggleButtonSpinner(targetButton, targetButtonIcon, targetButtonSpinner);

        try {
          const response = await sendUpdateCartRequest(requestUrl, quantity);

          if (response.ok) {
            const data = await response.json();

            if (data.hasError) {
              const errors = data.errors as Array<string>;
              const productAlertSelector = resetAlertContainer(qtyInput);

              if (errors && productAlertSelector) {
                errors.forEach((error: string) => {
                  useAlert(error, {type: 'danger', selector: productAlertSelector}).show();
                });
              }
            } else {
              const errors = data.errors as string;

              if (errors) {
                useToast(errors, {type: 'danger', autohide: false}).show();
              }
            }

            // we check if the quantity is more than wanted and if oosp is disabled
            // to recall with the correct number we can have
            if (data.cart?.products?.length > 0) {
              const productData = data.cart.products.find(
                (product: Record<string, unknown>) => data.id_product === Number(product.id_product)
                      && data.id_product_attribute === Number(product.id_product_attribute));

              if (productData
                  && productData.availability === 'unavailable'
                  && productData.allow_oosp === 0
                  && Number(productData.quantity_wanted) > Number(productData.stock_quantity)
              ) {
                const diff = Number(productData.stock_quantity) - Number(productData.quantity_wanted);
                await sendUpdateCartRequest(productData.update_quantity_url as string, diff);
              }
            }

            prestashop.emit(events.updateCart, {
              reason: qtyInput.dataset,
              resp: data,
            });

            // Change the input value based on returned quantity
            qtyInput.value = data.quantity;
            // If user used the confirmation mode, need to update input value in the DOM
            qtyInput.setAttribute('value', data.quantity);
          } else {
            // Something went wrong so call the catch block
            throw response;
          }
        } catch (error) {
          // An error has occurred on update so revert to the value in the DOM
          qtyInput.value = String(baseValue);
          const errorData = error as Response;

          if (errorData.status !== undefined) {
            const errorMsg = `${errorData.statusText}: ${errorData.url}`;
            const productAlertSelector = resetAlertContainer(qtyInput);
            useAlert(errorMsg, {type: 'danger', selector: productAlertSelector}).show();

            prestashop.emit(events.handleError, {
              eventType: 'updateProductInCart',
              resp: errorData,
            });
          }
        } finally {
          toggleButtonSpinner(targetButton, targetButtonIcon, targetButtonSpinner);
          showSpinButtons(qtyInputGroup);
        }
      }
    } else {
      // The input value is not a correct number
      showSpinButtons(qtyInputGroup);
    }
  }
};

const getTargetButton = (qtyInputGroup: Theme.QuantityInput.InputGroup, change: number) => {
  const {incrementButton, decrementButton} = qtyInputGroup;

  return (change > 0) ? incrementButton : decrementButton;
};

const resetAlertContainer = (qtyInput: HTMLInputElement) => {
  const {alertId} = qtyInput.dataset;

  if (alertId) {
    const productAlertSelector = quantityInputMap.alert(alertId);
    const productAlertContainer = document.querySelector<HTMLDivElement>(productAlertSelector);

    if (productAlertContainer) {
      productAlertContainer.innerHTML = '';
    }
    return productAlertSelector;
  }
  return undefined;
};

const toggleButtonSpinner = (button: HTMLButtonElement, icon: HTMLElement | null, spinner: HTMLElement | null) => {
  button.toggleAttribute('disabled');
  icon?.classList.toggle('d-none');
  spinner?.classList.toggle('d-none');
};

const showSpinButtons = (qtyInputGroup: Theme.QuantityInput.InputGroup) => {
  const {qtyInput, incrementButton, decrementButton} = qtyInputGroup;
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

const showConfirmationButtons = (qtyInputGroup: Theme.QuantityInput.InputGroup) => {
  const {qtyInput, incrementButton, decrementButton} = qtyInputGroup;
  const {mode} = qtyInput.dataset;

  if (mode !== 'confirmation') {
    toggleButtonIcon(incrementButton, decrementButton);
    qtyInput.dataset.mode = 'confirmation';
  }
};

const toggleButtonIcon = (incrementButton: HTMLButtonElement, decrementButton: HTMLButtonElement) => {
  const incrementButtonIcons = incrementButton.querySelectorAll<HTMLElement>('i');
  incrementButtonIcons.forEach((icon: HTMLElement) => {
    icon.classList.toggle('d-none');
  });
  const decrementButtonIcons = decrementButton.querySelectorAll<HTMLElement>('i');
  decrementButtonIcons.forEach((icon: HTMLElement) => {
    icon.classList.toggle('d-none');
  });
};

const sendUpdateCartRequest = async (updateUrl: string, quantity: number) => {
  const formData = new FormData();
  formData.append('ajax', '1');
  formData.append('action', 'update');
  formData.append('qty', String(Math.abs(quantity)));
  formData.append('op', (quantity > 0) ? 'up' : 'down');

  const response = await fetch(updateUrl, {
    method: 'POST',
    headers: {
      Accept: 'application/json, text/javascript, */*; q=0.01',
    },
    body: formData,
  });

  return response;
};

export const populateMinQuantityInput = (selector = quantityInputMap.default) => {
  const qtyInputNodeList = document.querySelectorAll<HTMLElement>(selector);

  // For each product in list
  qtyInputNodeList.forEach((qtyInputWrapper: HTMLElement) => {
    const idProduct = qtyInputWrapper.closest('form')
      ?.querySelector<HTMLInputElement>(quantityInputMap.idProductInput)?.value;
    const qtyInput = qtyInputWrapper.querySelector<HTMLInputElement>('input');
    const qtyInputMin = qtyInput?.getAttribute('min');

    // if the idproduct is set, and the input has a min attribute
    if (idProduct && qtyInput && qtyInputMin) {
      // we check if the product is already in the cart
      const productInCart = window.prestashop.cart.products.filter(
        (product: {id: number}) => product.id === parseInt(idProduct, 10),
      ).shift();
      // if the product is in the cart (and if the qty wanted is >= than the min qty, we set the minimal quantity to 1
      const minimalQuantity = productInCart && productInCart.quantity_wanted >= qtyInputMin
        ? 1 : qtyInputMin;
      // we set the min attribute to the input
      qtyInput.setAttribute('min', minimalQuantity.toString());
      qtyInput.setAttribute('value', minimalQuantity.toString());
    }
  });
};

document.addEventListener('DOMContentLoaded', () => {
  const {prestashop, Theme: {events, selectors}} = window;

  populateMinQuantityInput();

  prestashop.on(events.updatedCart, () => {
    useQuantityInput(cartSelectorMap.productQuantity);

    const {cart: cartMap} = selectors;
    const cartOverview = document.querySelector<HTMLElement>(cartMap.overview);
    cartOverview?.focus();

    populateMinQuantityInput();
  });

  prestashop.on(events.updateProduct, () => {
    populateMinQuantityInput();
  });

  prestashop.on(events.quickviewOpened, () => {
    useQuantityInput(quantityInputMap.modal);
    populateMinQuantityInput(quantityInputMap.modal);
  });
});

export default useQuantityInput;
