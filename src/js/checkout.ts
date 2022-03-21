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
import useProgressRing from '@js/components/useProgressRing';
import selectorsMap from '@constants/selectors-map';

const {progressRing: ProgressRingMap} = selectorsMap;

const initCheckout = () => {
  const steps = document.querySelectorAll<HTMLElement>('.js-step-item');
  const progressElement = document.querySelector<HTMLElement>(ProgressRingMap.checkout.element);
  const {setProgress} = useProgressRing(progressElement);

  const toggleStep = (content: HTMLElement) => {
    const currentContent = document.querySelector('.js-current-step');
    currentContent?.classList.remove('step--current', 'js-current-step');
    currentContent?.classList.add('d-none');

    content.classList.remove('d-none');
    content.classList.add('js-current-step');
  }

  steps.forEach((step, index) => {
    const stepContent = document.querySelector<HTMLElement>(`#${step.dataset.step}`)

    if (stepContent) {
      if(stepContent.classList.contains('step--complete')) {
        step.classList.add('checkout__steps--success');
      }

      if(stepContent.classList.contains('step--current')) {
        step.classList.add('checkout__steps--current');
        const responsiveStep = document.querySelector<HTMLElement>(`.checkout__steps__step[data-step="${step.dataset.step}"]`)
        const shownResponsiveStep = document.querySelector<HTMLElement>(`.checkout__steps__step:not(.d-none)`);

        responsiveStep?.classList.remove('d-none');
        shownResponsiveStep?.classList.add('d-none');

        const progressText = progressElement?.querySelector('text');

        if (progressText) {
          progressText.innerHTML = `${index + 1} / 4`;
        }

        if (setProgress) {
          setProgress((index + 1) / 4 * 100);
        }
      }

      if(stepContent.classList.contains('step--reachable')) {
        const button = step.querySelector<HTMLButtonElement>('button');

        button?.classList.add('btn-link')

        button?.addEventListener('click', () => {
          toggleStep(stepContent);
        })
      }

      if(stepContent.classList.contains('step--unreachable')) {
        const button = step.querySelector<HTMLButtonElement>('button');

        button?.setAttribute('disabled', 'true')

        button?.addEventListener('click', () => {
          toggleStep(stepContent);
        })
      }
    }
  })
};

export default initCheckout;
