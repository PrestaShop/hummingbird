/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import SelectorsMap from '@constants/selectors-map';
import A11yHelpers from '@helpers/a11y';
import {state, availableLastUpdateAction} from '@js/state';

const a11y = new A11yHelpers();

export default () => {
  const {prestashop, Theme: {events}} = window;

  // Once PrestaShop finishes updating the cart set aria-live on alerts to announce it to screen readers
  prestashop.on(events.updatedCart, () => {
    if (state.get('lastUpdateAction') === availableLastUpdateAction.DELETE_FROM_CART) {
      const alertPlaceholder = document.querySelector<HTMLElement>(SelectorsMap.cart.alertPlaceholder);

      if (alertPlaceholder) {
        Array.from(alertPlaceholder.children).forEach((child) => {
          const childElement = child as HTMLElement;

          if (childElement.getAttribute('data-ps-action') === 'to-be-announced') {
            childElement.removeAttribute('data-ps-action');
            childElement.setAttribute('tabindex', '-1');
            childElement.focus();
          }
        });
      } else {
        const cartOverview = document.querySelector<HTMLElement>(SelectorsMap.cart.overview);

        if (cartOverview) {
          a11y.setFocus(cartOverview);
        }
      }
    }

    if (state.get('lastUpdateAction') === availableLastUpdateAction.UPDATE_PRODUCT_QUANTITY) {
      a11y.restoreFocus(document.querySelector<HTMLElement>(SelectorsMap.cart.overview));
    }

    if (state.get('lastUpdateAction') === availableLastUpdateAction.SUBMIT_VOUCHER) {
      const voucherError = document.querySelector<HTMLElement>(SelectorsMap.cart.voucherError);
      const voucherList = document.querySelector<HTMLElement>(SelectorsMap.cart.voucherList);
      const voucherContainer = document.querySelector<HTMLElement>(SelectorsMap.cart.voucherContainer);

      if (voucherError && voucherError.style.display !== 'none') {
        voucherError.focus();
      } else if (voucherList) {
        voucherList.focus();
      } else if (voucherContainer) {
        voucherContainer.focus();
      }
    }

    if (state.get('lastUpdateAction') === availableLastUpdateAction.REMOVE_VOUCHER) {
      const voucherAccordionButton = document.querySelector<HTMLElement>(SelectorsMap.cart.voucherAccordionButton);

      if (voucherAccordionButton) {
        voucherAccordionButton.focus();
      }
    }

    // Reset the last update action
    state.set('lastUpdateAction', null);
  });
};
