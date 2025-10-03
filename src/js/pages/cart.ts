/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import {Collapse} from 'bootstrap';
import {isHTMLElement} from '@helpers/typeguards';
import handleCartAction from '@js/components/UseHandleCartAction';
import SelectorsMap from '@constants/selectors-map';
import {state, availableLastUpdateAction} from '@js/state';

export default () => {
  // Event delegation for voucher code clicks
  const handleVoucherClick = (event: Event) => {
    event.stopPropagation();

    const voucher = event.target as HTMLElement;

    if (isHTMLElement(voucher) && voucher.matches(SelectorsMap.cart.voucherCode)) {
      const code = voucher;
      const voucherInput = document.querySelector<HTMLInputElement>(SelectorsMap.cart.voucherInput);
      const voucherAccordion = document.querySelector(SelectorsMap.cart.voucherAccordion);

      if (voucherAccordion && voucherInput) {
        const voucherAccordionCollapser = new Collapse(voucherAccordion, {
          toggle: false,
        });

        voucherInput.value = code.innerText;
        voucherAccordionCollapser.show();
      }
    }
  };

  // Event delegation for voucher form submit
  const handleVoucherSubmit = () => {
    state.set('lastUpdateAction', availableLastUpdateAction.SUBMIT_VOUCHER);
  };

  // Event delegation for cart container (handles item removal, quantity change, etc.)
  const handleCartContainerClick = (event: Event) => {
    const eventTarget = event.target as HTMLElement;

    const targetItem = eventTarget.closest(SelectorsMap.cart.productItem);
    const targetValue = targetItem?.querySelector(
      SelectorsMap.cart.productItemQuantityInput,
    ) as HTMLInputElement | null;
    const removeButton = targetItem?.querySelector(
      SelectorsMap.cart.removeFromCart,
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
    if (eventTarget.dataset.linkAction === SelectorsMap.cart.deleteLinkAction) {
      handleCartAction(event);
    }
  };

  // Event delegation for summary container (handles voucher removal)
  const handleSummaryContainerClick = (event: Event) => {
    const target = (event.target as HTMLElement).closest(
      `[data-link-action="${SelectorsMap.cart.removeVoucherLinkAction}"]`,
    );

    if (target) {
      // Set state.lastUpdateAction to track the last update action
      state.set('lastUpdateAction', availableLastUpdateAction.REMOVE_VOUCHER);

      event.preventDefault();

      const syntheticClick = new Event('click', {bubbles: true});
      Object.defineProperty(syntheticClick, 'target', {value: target});

      handleCartAction(syntheticClick);
    }
  };

  // Add event listeners for dynamic elements
  const attachEventListeners = () => {
    const voucherCodes = document.querySelectorAll(SelectorsMap.cart.voucherCode);
    const cartContainer = document.querySelector<HTMLElement>(SelectorsMap.cart.container);
    const cartSummaryContainer = document.querySelector<HTMLElement>(SelectorsMap.cart.summaryContainer);
    const checkoutSummaryContainer = document.querySelector<HTMLElement>(SelectorsMap.checkout.summaryContainer);
    const voucherForm = document.querySelector<HTMLFormElement>(SelectorsMap.cart.voucherForm);

    // Add click listener for voucher codes
    voucherCodes.forEach((voucher) => {
      voucher.addEventListener('click', handleVoucherClick);
    });

    // Add submit listener for voucher form
    if (voucherForm) {
      voucherForm.addEventListener('submit', handleVoucherSubmit);
    }

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
    const cartSummaryContainer = document.querySelector<HTMLElement>(SelectorsMap.cart.summaryContainer);
    const checkoutSummaryContainer = document.querySelector<HTMLElement>(SelectorsMap.checkout.summaryContainer);

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
