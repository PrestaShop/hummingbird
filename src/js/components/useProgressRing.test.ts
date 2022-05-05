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

import initEmitter from '@js/prestashop';
import {progressRing as ProgressRingMap} from '@constants/selectors-map';
import resetHTMLBodyContent from '@helpers/resetBody';
import * as ProgressRing from '@constants/mocks/useProgressRing-data';
import useProgressRing, {ProgressRingText} from '@js/components/useProgressRing';

describe('useProgressRing', () => {
  describe('with valid template', () => {
    beforeAll(() => {
      resetHTMLBodyContent(ProgressRing.Template);
      window.prestashop = {};
      initEmitter();
    });

    it('should display an empty text when setProgress not used', async () => {
      const complete = 4;
      useProgressRing(ProgressRingMap.checkout.element, {steps: complete});
      const text = document.querySelector(ProgressRingMap.text);

      expect(text?.innerHTML).toBe('');
    });

    it('should be on specefic step after setProgress', async () => {
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
        {steps: complete, text: ProgressRingText.percent},
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
      resetHTMLBodyContent(ProgressRing.TemplateWithoutText);
      const complete = 4;
      const {setProgress} = useProgressRing(ProgressRingMap.checkout.element, {steps: complete});

      if (setProgress) {
        setProgress(4);
      }

      const text = document.querySelector(ProgressRingMap.text);

      expect(text?.innerHTML).toBeUndefined();
    });

    it('should return undefiend setProgress when the circle is not in the tempalte', async () => {
      resetHTMLBodyContent(ProgressRing.TemplateWithoutCircle);
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
