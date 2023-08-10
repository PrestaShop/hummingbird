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
  const cartContainer = document.querySelector<HTMLElement>(Theme.selectors.cart.container);

  if (cartContainer) {
    cartContainer.addEventListener('click', (event: Event) => {
      const eventTarget = event.target as HTMLElement;

      if (eventTarget.classList.contains('js-decrement-button')) {
        const targetItem = eventTarget.closest('.cart__item');
        const targetValue = targetItem?.querySelector('.js-cart-line-product-quantity') as HTMLElement | null;

        if (targetValue && targetValue.getAttribute('value') === '1' && targetValue.getAttribute('min') === '1') {
          if (targetItem) {
            const removeButton = targetItem.querySelector('.remove-from-cart') as HTMLElement | null;

            if (removeButton) {
              removeButton.click();
            }
          }
        }
      }
    });
  }

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

  if (cartContainer) {
    cartContainer.addEventListener('click', (event: Event) => {
      const eventTarget = event.target as HTMLElement;

      if (eventTarget.dataset.linkAction === Theme.selectors.cart.deleteLinkAction) {
        handleCartAction(event);
      }
    });
  }
};
