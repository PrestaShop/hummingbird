/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import {Collapse} from 'bootstrap';
import {isHTMLElement} from '@helpers/typeguards';
import handleCartAction from '../components/UseHandleCartAction';

export default () => {
  const {Theme} = window;
  const cartContainer = document.querySelector<HTMLElement>(Theme.selectors.cart.container);
  const cartSummary = document.querySelector<HTMLElement>(Theme.selectors.cart.summary);

  if (cartSummary) {
    cartSummary.addEventListener('click', (event: Event) => {
      const target = event.target as HTMLElement;

      // Check if the clicked element is a voucher code or inside one
      const voucher = target.closest(Theme.selectors.cart.discountCode);

      if (!voucher || !isHTMLElement(voucher)) return;

      event.stopPropagation();

      const discountInput = document.querySelector<HTMLInputElement>(Theme.selectors.cart.discountName);
      const promoCode = document.querySelector(Theme.selectors.cart.promoCode);

      if (promoCode && discountInput) {
        const formCollapser = new Collapse(promoCode, {
          toggle: false,
        });

        discountInput.value = voucher.innerText;
        // Show promo code field
        formCollapser.show();
      }
    });
  }

  if (cartContainer) {
    cartContainer.addEventListener('click', (event: Event) => {
      const eventTarget = event.target as HTMLElement;

      const targetItem = eventTarget.closest('.cart__item');
      const targetValue = targetItem?.querySelector('.js-cart-line-product-quantity') as HTMLInputElement | null;
      const removeButton = targetItem?.querySelector('.remove-from-cart') as HTMLElement | null;

      if (targetValue) {
        if (eventTarget.classList.contains('js-increment-button')) {
          if (targetValue.dataset.mode === 'confirmation' && Number(targetValue.value) < 1) {
            if (removeButton) {
              removeButton.click();
            }
          }
        }

        if (eventTarget.classList.contains('js-decrement-button')) {
          if (targetValue.getAttribute('value') === '1' && targetValue.getAttribute('min') === '1') {
            if (removeButton) {
              removeButton.click();
            }
          }
        }
      }

      if (eventTarget.dataset.linkAction === Theme.selectors.cart.deleteLinkAction) {
        handleCartAction(event);
      }
    });
  }
};
