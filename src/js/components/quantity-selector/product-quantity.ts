/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */

import selectorsMap, {quantitySelector as selectors} from '@constants/selectors-map';
import {
  getContext, getInput, hasPendingChange, parseQuantity, readBounds, restoreValue, setValue,
} from './quantity-selector';

type Context = Theme.QuantitySelector.Context;
type AddToCartReason = Theme.QuantitySelector.AddToCartReason;

const getRoots = (contexts: Context[]): HTMLElement[] => Array
  .from(document.querySelectorAll<HTMLElement>(selectors.root))
  .filter((root) => {
    const context = getContext(root);

    return context !== null && contexts.indexOf(context) !== -1;
  });

// Only the product page selector refreshes the product (price per quantity, availability…)
export const refreshProduct = (): void => {
  const {prestashop, Theme: {events}} = window;

  prestashop.emit(events.updateProduct, {
    eventType: 'updatedProductQuantity',
  });
};

// The core may change the min and the value of the product page or quickview input after a combination change
export const syncProductSelectors = (): void => {
  getRoots(['product', 'quickview']).forEach((root) => {
    const input = getInput(root);

    // A change made while the product was refreshing still has to refresh it again
    if (input && !hasPendingChange(root)) {
      setValue(root, parseQuantity(input.value) ?? readBounds(input).min);
    }
  });
};

/**
 * Quantity still required to reach the minimal quantity, at least 1. Null when the cart does not tell.
 *
 * Business rule duplicated from the core (CartController checks cart quantity + added quantity
 * against the minimal quantity, on the line without customization), because the add to cart
 * response does not expose it. To remove once the core sends the required quantity itself.
 */
const getRequiredQuantity = (reason: AddToCartReason): number | null => {
  const idProduct = Number(reason.idProduct);
  const idProductAttribute = Number(reason.idProductAttribute ?? 0);
  const line = (reason.cart?.products ?? []).find((product) => (
    Number(product.id_product) === idProduct
    && Number(product.id_product_attribute ?? 0) === idProductAttribute
    && Number(product.id_customization ?? 0) === 0
  ));

  if (!line) {
    return null;
  }

  const minimal = Number(line.minimal_quantity);
  const inCart = Number(line.cart_quantity);

  return Number.isNaN(minimal) || Number.isNaN(inCart) ? null : Math.max(1, minimal - inCart);
};

// A listing form only carries id_product_attribute for a combination, the product page form adds the selected one
const isAddedProduct = (form: HTMLFormElement, reason: AddToCartReason): boolean => {
  const idProductInput = form.querySelector<HTMLInputElement>(selectorsMap.addToCartProductId);
  const idProductAttributeInput = form.querySelector<HTMLInputElement>(selectorsMap.addToCartProductAttributeId);

  return idProductInput !== null
    && Number(idProductInput.value) === Number(reason.idProduct)
    && (idProductAttributeInput === null || Number(idProductAttributeInput.value) === Number(reason.idProductAttribute ?? 0));
};

// After an add to cart, the selectors of the added product go back to the quantity still required.
// The core resets #quantity_wanted to 1 after any add to cart: the other product selectors get their value back.
export const resetAddedSelectors = (reason: AddToCartReason | undefined): void => {
  if (reason?.linkAction !== 'add-to-cart' || reason.idProduct === undefined) {
    return;
  }

  const required = getRequiredQuantity(reason);

  getRoots(['product', 'quickview', 'listing']).forEach((root) => {
    const input = getInput(root);

    if (!input?.form || !isAddedProduct(input.form, reason)) {
      if (input && getContext(root) !== 'listing' && !hasPendingChange(root)) {
        restoreValue(root);
      }

      return;
    }

    // The rendered min is stale once the cart holds part of the minimal quantity
    if (required !== null) {
      input.setAttribute('min', String(required));
    }

    setValue(root, readBounds(input).min);
  });
};
