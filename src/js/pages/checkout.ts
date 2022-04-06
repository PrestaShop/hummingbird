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
import selectorsMap from '@constants/selectors-map';

const {progressRing: ProgressRingMap} = selectorsMap;

const initCheckout = () => {
  const {prestashop} = window;
  const steps = document.querySelectorAll<HTMLElement>('.js-step-item');
  const actionButtons = document.querySelectorAll<HTMLElement>('.js-back, .js-edit-addresses, .js-edit-shipping');
  const progressElement = document.querySelector<HTMLElement>(ProgressRingMap.checkout.element);
  const {setProgress} = useProgressRing(progressElement);
  const termsLink = document.querySelector<HTMLLinkElement>('.js-terms a');
  const termsModalElement = document.querySelector<HTMLLinkElement>('#checkout-modal');

  const toggleStep = (content: HTMLElement, step?: HTMLElement) => {
    const currentContent = document.querySelector('.js-current-step');
    currentContent?.classList.remove('step--current', 'js-current-step');
    if (step) {
      const responsiveStep = document.querySelector<HTMLElement>(
        `.checkout__steps__step[data-step="${step.dataset.step}"]`,
      );
      const shownResponsiveStep = document.querySelector<HTMLElement>('.checkout__steps__step:not(.d-none)');

      shownResponsiveStep?.classList.add('d-none');
      responsiveStep?.classList.remove('d-none');
    }

    content.classList.add('js-current-step');
  };

  actionButtons.forEach((button) => {
    const stepContent = document.querySelector<HTMLElement>(`#${button.dataset.step}`);

    button.addEventListener('click', (event) => {
      event.preventDefault();
      const triggerEl = document.querySelector<HTMLButtonElement>(
        `.js-step-item button[data-bs-target="#${button.dataset.step}"]`,
      );

      if (stepContent && triggerEl) {
        // Click on the corresponding tab
        triggerEl.click();
        toggleStep(stepContent);
      }
    });
  });

  steps.forEach((step, index) => {
    const stepContent = document.querySelector<HTMLElement>(`#${step.dataset.step}`);
    const progressText = progressElement?.querySelector('text');

    if (stepContent) {
      if (stepContent.classList.contains('step--complete')) {
        step.classList.add('checkout__steps--success');
      }

      if (stepContent.classList.contains('step--current')) {
        step.classList.add('checkout__steps--current');
        const responsiveStep = document.querySelector<HTMLElement>(
          `.checkout__steps__step[data-step="${step.dataset.step}"]`,
        );
        const shownResponsiveStep = document.querySelector<HTMLElement>('.checkout__steps__step:not(.d-none)');

        shownResponsiveStep?.classList.add('d-none');
        responsiveStep?.classList.remove('d-none');

        if (progressText) {
          progressText.innerHTML = `${index + 1} / 4`;
        }

        if (setProgress) {
          setProgress(((index + 1) / 4) * 100);
        }
      }

      if (stepContent.classList.contains('step--reachable')) {
        const button = step.querySelector<HTMLButtonElement>('button');

        button?.classList.add('btn-link');

        button?.addEventListener('click', () => {
          if (setProgress) {
            setProgress(((index + 1) / 4) * 100);
          }

          if (progressText) {
            progressText.innerHTML = `${index + 1} / 4`;
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
            const modalBody = termsModalElement.querySelector('.modal-body');
            const sanitizedContent = contentElement.querySelector('.page-cms');

            if (sanitizedContent && modalBody) {
              modalBody.innerHTML = sanitizedContent.innerHTML;

              termsModal.show();
            }
          } catch (e) {
            prestashop.emit('handleError', {eventType: 'clickOnTermsLink', error: e});
          }
        })();
      }

      $(prestashop.themeSelectors.modal).modal('show');
    }
  });
};

export default initCheckout;
