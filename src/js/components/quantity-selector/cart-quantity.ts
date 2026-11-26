/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */

import {quantitySelector as selectors} from '@constants/selectors-map';
import parseData from '@helpers/parseData';
import A11yHelpers from '@helpers/a11y';
import useToast from '@js/components/useToast';
import {state, availableLastUpdateAction} from '@js/state';
import {
  getInput, getRoot, setLoading, setValue,
} from './quantity-selector';

type CartData = Theme.QuantitySelector.CartData;
type CartUpdateResponse = Theme.QuantitySelector.CartUpdateResponse;

const a11y = new A11yHelpers();

const isCartData = (data: unknown): data is CartData => {
  const candidate = data as Partial<CartData> | null;

  return typeof candidate?.updateUrl === 'string' && candidate.updateUrl !== '';
};

export const sendUpdateCartRequest = async (updateUrl: string, quantity: number): Promise<Response> => {
  const formData = new FormData();
  formData.append('ajax', '1');
  formData.append('action', 'update');
  formData.append('qty', String(Math.abs(quantity)));
  formData.append('op', (quantity > 0) ? 'up' : 'down');

  return fetch(updateUrl, {
    method: 'POST',
    headers: {
      Accept: 'application/json, text/javascript, */*; q=0.01',
    },
    body: formData,
  });
};

const showErrors = (errors: CartUpdateResponse['errors']): void => {
  const messages = Array.isArray(errors) ? errors : [errors];

  messages.forEach((message) => {
    if (message) {
      useToast(message, {type: 'danger'}).show();
    }
  });
};

// Core accepts a quantity above the stock when out of stock orders are disabled,
// so lower it back to the stock. This belongs in the core, the theme only keeps parity.
const reconcileStock = async (data: CartUpdateResponse): Promise<void> => {
  const productData = data.cart?.products?.find((product) => (
    data.id_product === Number(product.id_product)
    && data.id_product_attribute === Number(product.id_product_attribute)
  ));

  if (productData
    && productData.availability === 'unavailable'
    && productData.allow_oosp === 0
    && Number(productData.quantity_wanted) > Number(productData.stock_quantity)
  ) {
    const diff = Number(productData.stock_quantity) - Number(productData.quantity_wanted);
    await sendUpdateCartRequest(productData.update_quantity_url, diff);
  }
};

// The translated message is rendered on the live region, e.g. "Quantity of X updated to %quantity%."
const announce = (root: HTMLElement, quantity: number): void => {
  const status = root.querySelector<HTMLElement>(selectors.status);
  const template = status?.dataset.psData;

  if (status && template) {
    status.textContent = template.replace('%quantity%', String(quantity));
  }
};

// The core re-renders the cart lines after the update, so announce again on the new line
const announceAfterRefresh = (inputId: string, quantity: number): void => {
  const {prestashop, Theme: {events}} = window;

  prestashop.once(events.updatedCart, () => {
    const root = getRoot(document.getElementById(inputId));

    if (root) {
      window.setTimeout(() => announce(root, quantity), 100);
    }
  });
};

const updateCartLine = async ({root, value, previous}: Theme.QuantitySelector.QuantityChangedDetail): Promise<void> => {
  const {prestashop, Theme: {events}} = window;
  const data = parseData<CartData>(root, isCartData);

  if (!data) {
    setValue(root, previous);
    return;
  }

  // The cart is re-rendered after the update, accessibility/cart.ts restores focus by element id
  if (root.contains(document.activeElement)) {
    state.set('lastUpdateAction', availableLastUpdateAction.UPDATE_PRODUCT_QUANTITY);
    a11y.storeFocus();
  }

  setLoading(root, true);

  // Once the server answered, the cart may hold the new quantity: reverting the field
  // after a later failure would make the next delta wrong
  let answered = false;

  try {
    const response = await sendUpdateCartRequest(data.updateUrl, value - previous);

    if (!response.ok) {
      throw response;
    }

    answered = true;
    const resp = await response.json() as CartUpdateResponse;
    showErrors(resp.errors);

    const returned = Number(resp.quantity);
    const quantity = Number.isNaN(returned) ? previous : returned;
    setLoading(root, false);
    const shown = setValue(root, quantity) ?? quantity;
    announce(root, shown);

    // A refused update has no cart to refresh the page with
    if (resp.hasError) {
      return;
    }

    await reconcileStock(resp);

    const inputId = getInput(root)?.id;

    if (inputId) {
      announceAfterRefresh(inputId, shown);
    }

    prestashop.emit(events.updateCart, {
      reason: {
        idProduct: data.idProduct,
        idProductAttribute: data.idProductAttribute,
        idCustomization: data.idCustomization,
        updateUrl: data.updateUrl,
      },
      resp,
    });
  } catch (error) {
    setLoading(root, false);

    if (!answered) {
      setValue(root, previous);
    }

    const errorData = error as Response;

    if (errorData?.status !== undefined) {
      useToast(`${errorData.statusText}: ${errorData.url}`, {type: 'danger'}).show();

      prestashop.emit(events.handleError, {
        eventType: 'updateProductInCart',
        resp: errorData,
      });
    }
  }
};

export default updateCartLine;
