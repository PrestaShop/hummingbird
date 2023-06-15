/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import {Collapse} from 'bootstrap';
import {isHTMLElement} from '@helpers/typeguards';
import handleCartAction from '../components/UseHandleCartAction';

export default () => {
  const {Theme} = window;
  const voucherCodes = document.querySelectorAll(Theme.selectors.cart.discountCode);

  voucherCodes.forEach((voucher) => {
    voucher.addEventListener('click', (event: Event) => {
      event.stopPropagation();

      if (isHTMLElement(event.currentTarget)) {
        const code = event.currentTarget;
        const discountInput = document.querySelector<HTMLInputElement>(Theme.selectors.cart.discountName);
        const promoCode = document.querySelector(Theme.selectors.cart.promoCode);

        if (promoCode && discountInput) {
          const formCollapser = new Collapse(promoCode);

          discountInput.value = code.innerText;
          // Show promo code field
          formCollapser.show();
        }
      }

      return false;
    });
  });

  const cartContainer = document.querySelector<HTMLElement>(Theme.selectors.cart.container);

  if (cartContainer) {
    cartContainer.addEventListener('click', (event: Event) => {
      const eventTarget = event.target as HTMLElement;

      if (eventTarget.dataset.linkAction === Theme.selectors.cart.deleteLinkAction) {
        handleCartAction(event);
      }
    });
  }
};
