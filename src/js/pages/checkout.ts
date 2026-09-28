/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */
import {Modal} from 'bootstrap';
import useProgressRing from '@js/components/useProgressRing';
import A11yHelpers from '@helpers/a11y';

const initCheckout = () => {
  const {prestashop} = window;
  const {Theme: {selectors, events}} = window;
  const {progressRing: ProgressRingMap, checkout: CheckoutMap} = selectors;
  const a11y = new A11yHelpers();
  const steps = document.querySelectorAll<HTMLElement>(CheckoutMap.steps.item);
  const actionButtons = document.querySelectorAll<HTMLElement>(CheckoutMap.actionsButtons);
  const {setProgress} = useProgressRing(ProgressRingMap.checkout.element, {steps: steps.length});
  const termsLink = document.querySelector<HTMLLinkElement>(CheckoutMap.termsLink);
  const termsModalElement = document.querySelector<HTMLLinkElement>(CheckoutMap.checkoutModal);

  // data-ps-state holds several coexisting tokens on a checkout step, so edit one
  // without clobbering the others — the same semantics as classList.toggle.
  const toggleState = (el: Element | null | undefined, token: string, on: boolean) => {
    if (!el) return;

    const tokens = new Set((el.getAttribute('data-ps-state') ?? '').split(' ').filter(Boolean));

    if (on) {
      tokens.add(token);
    } else {
      tokens.delete(token);
    }

    if (tokens.size) {
      el.setAttribute('data-ps-state', Array.from(tokens).join(' '));
    } else {
      el.removeAttribute('data-ps-state');
    }
  };

  // Only UI things, the real toggle is handled by Bootstrap Tabs
  // A thing we handle manually is the .active class on the toggling buttons
  const toggleStep = (content: HTMLElement, step?: HTMLElement) => {
    const currentContent = document.querySelector(CheckoutMap.steps.current);
    const currentButton = step?.querySelector<HTMLButtonElement>(CheckoutMap.steps.button);
    currentButton?.focus();
    currentContent?.classList.remove('step--current', 'js-current-step');
    // Dropping only the "current" token leaves "complete" and "reachable" untouched.
    toggleState(currentContent, 'current', false);

    if (step) {
      const responsiveStep = document.querySelector<HTMLElement>(CheckoutMap.steps.specificStep(step.dataset.step));
      const shownResponsiveStep = document.querySelector<HTMLElement>(CheckoutMap.steps.shownResponsiveStep);

      shownResponsiveStep?.classList.add('d-none');
      responsiveStep?.classList.remove('d-none');
    }

    content.classList.add('js-current-step', 'step--current');
    toggleState(content, 'current', true);
  };

  actionButtons.forEach((button) => {
    const stepContent = document.querySelector<HTMLElement>(
      CheckoutMap.steps.specificStepContent(button.dataset.step),
    );

    button.addEventListener('click', (event) => {
      event.preventDefault();
      const triggerEl = document.querySelector<HTMLButtonElement>(
        CheckoutMap.steps.backButton(button.dataset.step),
      );

      if (stepContent && triggerEl) {
        // Click on the corresponding tab
        triggerEl.click();
        toggleStep(stepContent);
      }
    });
  });

  // Initial step settings
  steps.forEach((step, index) => {
    // Get step content
    const stepContent = document.querySelector<HTMLElement>(
      CheckoutMap.steps.specificStepContent(step.dataset.step),
    );

    // Get step selector button (toggler)
    const stepButton = step.querySelector<HTMLButtonElement>('button');

    if (stepContent) {
      // If step is finished, we mark it green
      if (stepContent.matches(CheckoutMap.steps.complete)) {
        step.classList.add('checkout-steps__step--success');
      }

      // Current step will get an active property
      if (stepContent.matches(CheckoutMap.steps.current)) {
        step.classList.add('checkout-steps__step--current');
        stepButton?.classList.add('active');
        const responsiveStep = document.querySelector<HTMLElement>(
          CheckoutMap.steps.specificStep(step.dataset.step),
        );
        const shownResponsiveStep = document.querySelector<HTMLElement>(CheckoutMap.steps.shownResponsiveStep);

        shownResponsiveStep?.classList.add('d-none');
        responsiveStep?.classList.remove('d-none');

        if (setProgress) {
          setProgress(index + 1);
        }
      } else {
        stepButton?.classList.remove('active');
      }

      // If the step can be navigated
      if (stepContent.matches(CheckoutMap.steps.reachable)) {
        stepButton?.addEventListener('click', () => {
          if (setProgress) {
            setProgress(index + 1);
          }

          toggleStep(stepContent, step);
        });
      }

      // If the step is not finished yet, we disable the navigator
      if (stepContent.classList.contains('step--unreachable')) {
        stepButton?.setAttribute('disabled', 'true');
        stepButton?.addEventListener('click', () => {
          toggleStep(stepContent, step);
        });
      }
    }
  });

  termsLink?.addEventListener('click', (event) => {
    event.preventDefault();
    a11y.storeFocus();

    if (termsModalElement) {
      const termsModal = new Modal(termsModalElement);
      const linkElement = event.target as HTMLLinkElement;
      let url = linkElement.getAttribute('href');

      if (url) {
        url += '?content_only=1';

        (async () => {
          try {
            const response = await fetch(url);
            const content = await response.text();
            const contentElement = document.createElement('div');
            contentElement.innerHTML = content;
            const modalBody = termsModalElement.querySelector(selectors.modalBody);
            const sanitizedContent = contentElement.querySelector(selectors.pageCms);

            if (sanitizedContent && modalBody) {
              modalBody.innerHTML = sanitizedContent.innerHTML;

              termsModal.show();
            }
          } catch (e) {
            prestashop.emit(events.handleError, {eventType: 'clickOnTermsLink', error: e});
          }
        })();
      }
    }
  });

  // Restore focus when terms modal is closed
  termsModalElement?.addEventListener('hidden.bs.modal', () => {
    a11y.restoreFocus();
  });

  // Prestashop event triggers after selecting different carrier
  prestashop.on(events.updatedDeliveryForm, (params: Theme.DeliveryOptionForm.DeliveryOptionItem): void => {
    const selectedOption = params.deliveryOption?.[0];

    if (!selectedOption) return;

    const selectedWrapper = selectedOption.querySelector(CheckoutMap.carrierExtraContentWrapper);

    if (!(selectedWrapper instanceof HTMLElement)) return;

    const allWrappers = document.querySelectorAll(CheckoutMap.carrierExtraContentWrapper);

    // Reset all wrappers
    allWrappers.forEach((wrapper: HTMLElement) => {
      wrapper.removeAttribute('data-active');
      wrapper.removeAttribute('data-ps-state');
    });

    // Activate the selected wrapper
    selectedWrapper.setAttribute('data-active', '');
    selectedWrapper.setAttribute('data-ps-state', 'active');
  });
};

export default initCheckout;
