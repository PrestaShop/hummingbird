/**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 */
import {Modal} from 'bootstrap';
import useProgressRing from '@js/components/useProgressRing';

const initCheckout = () => {
  const {prestashop} = window;
  const {themeSelectors: selectorsMap} = prestashop;
  const {progressRing: ProgressRingMap, checkout: CheckoutMap} = selectorsMap;

  const steps = document.querySelectorAll<HTMLElement>(CheckoutMap.steps.item);
  const actionButtons = document.querySelectorAll<HTMLElement>(CheckoutMap.actionsButtons);
  const progressElement = document.querySelector<HTMLElement>(ProgressRingMap.checkout.element);
  const {setProgress} = useProgressRing(ProgressRingMap.checkout.element, {steps: steps.length, text: 'enum'});
  const termsLink = document.querySelector<HTMLLinkElement>(CheckoutMap.termsLink);
  const termsModalElement = document.querySelector<HTMLLinkElement>(CheckoutMap.checkoutModal);

  // Only UI things, the real toggle is handled by Bootstrap Tabs
  const toggleStep = (content: HTMLElement, step?: HTMLElement) => {
    const currentContent = document.querySelector(CheckoutMap.steps.current);
    currentContent?.classList.remove('step--current', 'js-current-step');

    if (step) {
      const responsiveStep = document.querySelector<HTMLElement>(CheckoutMap.steps.specificStep(step.dataset.step));
      const shownResponsiveStep = document.querySelector<HTMLElement>(CheckoutMap.steps.shownResponsiveStep);

      shownResponsiveStep?.classList.add('d-none');
      responsiveStep?.classList.remove('d-none');
    }

    content.classList.add('js-current-step');
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

  steps.forEach((step, index) => {
    const stepContent = document.querySelector<HTMLElement>(
      CheckoutMap.steps.specificStepContent(step.dataset.step),
    );

    if (stepContent) {
      if (stepContent.classList.contains('step--complete')) {
        step.classList.add('checkout__steps--success');
      }

      if (stepContent.classList.contains('step--current')) {
        step.classList.add('checkout__steps--current');
        const responsiveStep = document.querySelector<HTMLElement>(
          CheckoutMap.steps.specificStep(step.dataset.step),
        );
        const shownResponsiveStep = document.querySelector<HTMLElement>(CheckoutMap.steps.shownResponsiveStep);

        shownResponsiveStep?.classList.add('d-none');
        responsiveStep?.classList.remove('d-none');

        if (setProgress) {
          setProgress(index + 1);
        }
      }

      if (stepContent.classList.contains('step--reachable')) {
        const button = step.querySelector<HTMLButtonElement>('button');

        button?.classList.add('btn-link');

        button?.addEventListener('click', () => {
          if (setProgress) {
            setProgress(index + 1);
          }

          toggleStep(stepContent, step);
        });
      }

      if (stepContent.classList.contains('step--unreachable')) {
        const button = step.querySelector<HTMLButtonElement>('button');

        button?.setAttribute('disabled', 'true');

        button?.addEventListener('click', () => {
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
            const modalBody = termsModalElement.querySelector(selectorsMap.modalBody);
            const sanitizedContent = contentElement.querySelector(selectorsMap.pageCms);

            if (sanitizedContent && modalBody) {
              modalBody.innerHTML = sanitizedContent.innerHTML;

              termsModal.show();
            }
          } catch (e) {
            prestashop.emit('handleError', {eventType: 'clickOnTermsLink', error: e});
          }
        })();
      }
    }
  });
};

export default initCheckout;
