/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import selectorsMap from '@constants/selectors-map';
import * as ProgressRingData from '@constants/useProgressRing-data';

const {progressRing: ProgressRingMap} = selectorsMap;
const PROGRESS_ERROR = 'The circle is not linked to an SVG circle';

export const useProgressRing = (selector: string, options: Theme.ProgressRing.Options): Theme.ProgressRing.Return => {
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

        if (progressText && options.text !== ProgressRingData.Text.hidden) {
          const text = (options.text === undefined || options.text === ProgressRingData.Text.enum)
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
