/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import {Collapse} from 'bootstrap';
import {isHTMLElement} from '@helpers/typeguards';
import handleCartAction from '../components/UseHandleCartAction';

export default () => {
  const {Theme} = window;

  // Event delegation for voucher code clicks
  const handleVoucherClick = (event: Event) => {
    event.stopPropagation();

    const voucher = event.target as HTMLElement;

    if (isHTMLElement(voucher) && voucher.matches(Theme.selectors.cart.voucherCode)) {
      const code = voucher;
      const voucherInput = document.querySelector<HTMLInputElement>(Theme.selectors.cart.voucherInput);
      const voucherAccordion = document.querySelector(Theme.selectors.cart.voucherAccordion);

      if (voucherAccordion && voucherInput) {
        const voucherAccordionCollapser = new Collapse(voucherAccordion, {
          toggle: false,
        });

        voucherInput.value = code.innerText;
        voucherAccordionCollapser.show();
      }
    }
  };

  // Event delegation for cart container (handles item removal, quantity change, etc.)
  const handleCartContainerClick = (event: Event) => {
    const eventTarget = event.target as HTMLElement;

    const targetItem = eventTarget.closest(Theme.selectors.cart.productItem);
    const targetValue = targetItem?.querySelector(
      Theme.selectors.cart.productItemQuantityInput,
    ) as HTMLInputElement | null;
    const removeButton = targetItem?.querySelector(
      Theme.selectors.cart.removeFromCart,
    ) as HTMLElement | null;

    if (targetValue) {
      if (eventTarget.classList.contains('js-increment-button')) {
        if (targetValue.dataset.mode === 'confirmation' && Number(targetValue.value) < 1) {
          removeButton?.click();
        }
      }

      if (eventTarget.classList.contains('js-decrement-button')) {
        if (targetValue.value === '0' && targetValue.getAttribute('min') === '1') {
          removeButton?.click();
        }
      }
    }

    // If it's a delete action, trigger the cart action
    if (eventTarget.dataset.linkAction === Theme.selectors.cart.deleteLinkAction) {
      handleCartAction(event);
    }
  };

  // Event delegation for summary container (handles voucher removal)
  const handleSummaryContainerClick = (event: Event) => {
    const target = (event.target as HTMLElement).closest(
      `[data-link-action="${Theme.selectors.cart.removeVoucherLinkAction}"]`,
    );

    if (target) {
      event.preventDefault();

      const syntheticClick = new Event('click', {bubbles: true});
      Object.defineProperty(syntheticClick, 'target', {value: target});

      handleCartAction(syntheticClick);
    }
  };

  // Add event listeners for dynamic elements
  const attachEventListeners = () => {
    const voucherCodes = document.querySelectorAll(Theme.selectors.cart.voucherCode);
    const cartContainer = document.querySelector<HTMLElement>(Theme.selectors.cart.container);
    const cartSummaryContainer = document.querySelector<HTMLElement>(Theme.selectors.cart.summaryContainer);
    const checkoutSummaryContainer = document.querySelector<HTMLElement>(Theme.selectors.checkout.summaryContainer);

    // Add click listener for voucher codes
    voucherCodes.forEach((voucher) => {
      voucher.addEventListener('click', handleVoucherClick);
    });

    // Add click listener for the cart container
    if (cartContainer) {
      cartContainer.addEventListener('click', handleCartContainerClick);
    }

    // Add click listener for both summary containers
    [cartSummaryContainer, checkoutSummaryContainer].forEach((container) => {
      if (container) {
        container.addEventListener('click', handleSummaryContainerClick);
      }
    });
  };

  // MutationObserver to handle dynamic updates (e.g., when cart is updated or refreshed)
  const setupMutationObserver = () => {
    const cartSummaryContainer = document.querySelector<HTMLElement>(Theme.selectors.cart.summaryContainer);
    const checkoutSummaryContainer = document.querySelector<HTMLElement>(Theme.selectors.checkout.summaryContainer);

    const observer = new MutationObserver(() => {
      attachEventListeners();
    });

    [cartSummaryContainer, checkoutSummaryContainer].forEach((container) => {
      if (container) {
        observer.observe(container, {
          childList: true,
          subtree: true,
        });
      }
    });
  };

  // Initialize event listeners and mutation observer
  attachEventListeners();
  setupMutationObserver();
};
