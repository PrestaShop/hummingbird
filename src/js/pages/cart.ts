/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import {Collapse} from 'bootstrap';
import {isHTMLElement} from '@helpers/typeguards';

export default () => {
  const {prestashop} = window;
  const voucherCodes = document.querySelectorAll(prestashop.themeSelectors.cart.discountCode);

  voucherCodes.forEach((voucher) => {
    voucher.addEventListener('click', (event: Event) => {
      event.stopPropagation();

      if (isHTMLElement(event.currentTarget)) {
        const code = event.currentTarget;
        const discountInput = document.querySelector(prestashop.themeSelectors.cart.discountName);
        const formCollapser = new Collapse(document.querySelector(prestashop.themeSelectors.cart.promoCode));

        discountInput.value = code.innerText;
        // Show promo code field
        formCollapser.show();
      }

      return false;
    });
  });
};
