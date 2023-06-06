/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
import {Modal} from 'bootstrap';
import useProgressRing from '@js/components/useProgressRing';

const initCheckout = () => {
  const {prestashop} = window;
  const {Theme: {selectors, events}} = window;
  const {progressRing: ProgressRingMap, checkout: CheckoutMap} = selectors;

  const steps = document.querySelectorAll<HTMLElement>(CheckoutMap.steps.item);
  const actionButtons = document.querySelectorAll<HTMLElement>(CheckoutMap.actionsButtons);
  const {setProgress} = useProgressRing(ProgressRingMap.checkout.element, {steps: steps.length});
  const termsLink = document.querySelector<HTMLLinkElement>(CheckoutMap.termsLink);
  const termsModalElement = document.querySelector<HTMLLinkElement>(CheckoutMap.checkoutModal);

  // Only UI things, the real toggle is handled by Bootstrap Tabs
  // A thing we handle manually is the .active class on the toggling buttons
  const toggleStep = (content: HTMLElement, step?: HTMLElement) => {
    const currentContent = document.querySelector(CheckoutMap.steps.current);
    currentContent?.classList.remove('step--current', 'js-current-step');

    if (step) {
      const responsiveStep = document.querySelector<HTMLElement>(CheckoutMap.steps.specificStep(step.dataset.step));
      const shownResponsiveStep = document.querySelector<HTMLElement>(CheckoutMap.steps.shownResponsiveStep);

      shownResponsiveStep?.classList.add('d-none');
      responsiveStep?.classList.remove('d-none');
    }

    content.classList.add('js-current-step', 'step--current');
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
      if (stepContent.classList.contains('step--complete')) {
        step.classList.add('checkout__steps--success');
      }

      // Current step will get an active property
      if (stepContent.classList.contains('step--current')) {
        step.classList.add('checkout__steps--current');
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
      if (stepContent.classList.contains('step--reachable')) {
        stepButton?.classList.add('btn-link');

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

  // Prestashop event triggers after selecting different carrier
  prestashop.on(events.updatedDeliveryForm, (params: Theme.DeliveryOptionForm.DeliveryOptionItem): void => {
    if (typeof params.deliveryOption === 'undefined' || Object.keys(params.deliveryOption).length === 0) {
      return;
    }

    // Hide all extra content in delivery step
    const extraContentElements = document.querySelectorAll(CheckoutMap.carrierExtraContentWrapper);
    extraContentElements.forEach((content: HTMLElement) => {
      content.style.maxHeight = '0';
    });
    const extraContentElementToShow = params.deliveryOption[0]
      ?.querySelector(CheckoutMap.carrierExtraContentWrapper) as HTMLElement;

    // Show selected delivery method extra content
    if (extraContentElementToShow != null) {
      const content = extraContentElementToShow.querySelector(CheckoutMap.carrierExtraContent);

      if (content != null) {
        extraContentElementToShow.style.maxHeight = `${content.clientHeight}px`;
      }
    }
  });

  const setMaxHeightToActiveCarrierExtraContent = () => {
    const activeExtraContent = document.querySelector(`${CheckoutMap.carrierExtraContentActive}`) as HTMLElement;

    if (activeExtraContent === null) {
      return;
    }

    const content = activeExtraContent.querySelector(CheckoutMap.carrierExtraContent) as HTMLElement;

    if (content != null) {
      activeExtraContent.style.maxHeight = `${content.clientHeight}px`;
    }
  };

  // Initiate active carrier extra content height
  if (document.readyState === 'complete' || document.readyState === 'interactive') {
    setTimeout(() => { setMaxHeightToActiveCarrierExtraContent(); }, 1);
  } else {
    document.addEventListener('DOMContentLoaded', () => {
      setMaxHeightToActiveCarrierExtraContent();
    });
  }
};

export default initCheckout;
