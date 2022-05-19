/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import {Collapse} from 'bootstrap';
import {isHTMLElement} from '@helpers/typeguards';

export default () => {
  const {Theme} = window;
  const voucherCodes = document.querySelectorAll(Theme.selectors.cart.discountCode);

  voucherCodes.forEach((voucher) => {
    voucher.addEventListener('click', (event: Event) => {
      event.stopPropagation();

      if (isHTMLElement(event.currentTarget)) {
        const code = event.currentTarget;
        const discountInput = document.querySelector(Theme.selectors.cart.discountName);
        const formCollapser = new Collapse(document.querySelector(Theme.selectors.cart.promoCode));

        discountInput.value = code.innerText;
        // Show promo code field
        formCollapser.show();
      }

      return false;
    });
  });
};
