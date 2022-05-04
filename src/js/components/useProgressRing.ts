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

import selectorsMap from '@constants/selectors-map';

const {progressRing: ProgressRingMap} = selectorsMap;
const PROGRESS_ERROR = 'The circle is not linked to an SVG circle';

export interface ProgressRingReturn {
  setProgress?: (step: number) => void,
  progressElement?: HTMLElement,
  error?: Error,
}

export enum ProgressRingText {
  enum = 'enum',
  percent = 'percent',
  hidden = 'hidden'
}

export interface ProgressRingOptions {
  steps: number;
  text?: keyof typeof ProgressRingText;
}

export const useProgressRing = (selector: string, options: ProgressRingOptions): ProgressRingReturn => {
  const progressElement = document.querySelector<HTMLElement>(selector);

  if (progressElement) {
    const progressText = progressElement.querySelector('text');
    const circle = progressElement.querySelector<SVGCircleElement>(ProgressRingMap.checkout.circle);

    if (circle) {
      const radius = Number(circle.getAttribute('r'));
      const circumference = radius * 2 * Math.PI;

      // This function makes the progress editable after initialization
      const setProgress = (step: number) => {
        const percent = (Math.min(step, options.steps) / options.steps) * 100;
        const offset = circumference - (percent / 100) * circumference;
        circle.style.strokeDashoffset = offset.toString();
        circle.dataset.percent = String(percent);

        if (progressText && options.text !== ProgressRingText.hidden) {
          const text = (options.text === undefined || options.text === ProgressRingText.enum)
            ? `${Math.min(step, options.steps)} / ${options.steps}` : `${percent}%`;
          progressText.innerHTML = text;
        }
      };

      return {
        setProgress,
        progressElement,
      };
    }
  }

  return {
    error: new Error(PROGRESS_ERROR),
  };
};

export default useProgressRing;
