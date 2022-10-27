/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import initEmitter from '@js/prestashop';
import {progressRing as ProgressRingMap} from '@constants/selectors-map';
import resetHTMLBodyContent from '@helpers/resetBody';
import * as ProgressRingMockData from '@constants/mocks/useProgressRing-data';
import * as ProgressRingData from '@constants/useProgressRing-data';
import useProgressRing from '@js/components/useProgressRing';

describe('useProgressRing', () => {
  describe('with valid template', () => {
    beforeAll(() => {
      resetHTMLBodyContent(ProgressRingMockData.Template);
      window.prestashop = {};
      initEmitter();
    });

    it('should display an empty text when setProgress not used', async () => {
      const complete = 4;
      useProgressRing(ProgressRingMap.checkout.element, {steps: complete});
      const text = document.querySelector(ProgressRingMap.text);

      expect(text?.innerHTML).toBe('');
    });

    it('should be on specific step after setProgress', async () => {
      const complete = 4;
      const current = 3;
      const {setProgress} = useProgressRing(ProgressRingMap.checkout.element, {steps: complete});

      if (setProgress) {
        setProgress(current);
      }

      const text = document.querySelector(ProgressRingMap.text);

      expect(text?.innerHTML).toBe(`${current} / ${complete}`);
    });

    it('should be in percent style when is selected', async () => {
      const complete = 15;
      const current = 7;
      const percentage = (current / complete) * 100;
      const {setProgress} = useProgressRing(
        ProgressRingMap.checkout.element,
        {steps: complete, text: ProgressRingData.Text.percent},
      );

      if (setProgress) {
        setProgress(current);
      }

      const text = document.querySelector(ProgressRingMap.text);

      expect(text?.innerHTML).toBe(`${percentage}%`);
    });
  });

  describe('without valid template', () => {
    beforeAll(() => {
      window.prestashop = {};
      initEmitter();
    });

    it('should display a progress ring without any text when using setProgress', async () => {
      resetHTMLBodyContent(ProgressRingMockData.TemplateWithoutText);
      const complete = 4;
      const {setProgress} = useProgressRing(ProgressRingMap.checkout.element, {steps: complete});

      if (setProgress) {
        setProgress(4);
      }

      const text = document.querySelector(ProgressRingMap.text);

      expect(text?.innerHTML).toBeUndefined();
    });

    it('should return undefiend setProgress when the circle is not in the tempalte', async () => {
      resetHTMLBodyContent(ProgressRingMockData.TemplateWithoutCircle);
      const complete = 4;
      const {setProgress} = useProgressRing(ProgressRingMap.checkout.element, {steps: complete});

      expect(setProgress).toBeUndefined();
    });
  });

  describe('without template', () => {
    it('should return an error message', async () => {
      resetHTMLBodyContent('');
      const complete = 4;
      const {error} = useProgressRing(ProgressRingMap.checkout.element, {steps: complete});

      expect(error).toBeDefined();
    });
  });
});
