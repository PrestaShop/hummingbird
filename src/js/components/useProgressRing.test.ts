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
  describe('with text template', () => {
    beforeAll(() => {
      resetHTMLBodyContent(ProgressRing.Template);
      window.prestashop = {};
      initEmitter();
    });

    it('should display a progress ring on third step', async () => {
      useProgressRing(ProgressRingMap.checkout.element, {steps: 4});
      const text = document.querySelector(ProgressRingMap.text);

      expect(text?.innerHTML).toBe('3 / 4');
    });

    it('should be on step 4 after setProgress', async () => {
      const {setProgress} = useProgressRing(ProgressRingMap.checkout.element, {steps: 4});
      expect(setProgress).toBeDefined();

      if (!setProgress) return;

      setProgress(4);
      const text = document.querySelector(ProgressRingMap.text);

      expect(text?.innerHTML).toBe('4 / 4');
    });

    it('should be on step 86 after setProgress', async () => {
      const {setProgress} = useProgressRing(ProgressRingMap.checkout.element, {steps: 100});
      expect(setProgress).toBeDefined();

      if (!setProgress) return;

      setProgress(86);
      const text = document.querySelector(ProgressRingMap.text);

      expect(text?.innerHTML).toBe('86 / 100');
    });
  });

  describe('without text template', () => {
    beforeAll(() => {
      resetHTMLBodyContent(ProgressRing.TemplateWithoutText);
      window.prestashop = {};
      initEmitter();
    });

    it('should display a progress ring without any text', async () => {
      useProgressRing(
        ProgressRingMap.checkout.element,
        {steps: 4},
      );
      const text = document.querySelector(ProgressRingMap.text);

      expect(text?.innerHTML).toBeUndefined();
    });

    it('should display a progress ring without any text when using setProgress', async () => {
      const {setProgress} = useProgressRing(ProgressRingMap.checkout.element, {steps: 4});

      if (!setProgress) return;

      setProgress(4);

      const text = document.querySelector(ProgressRingMap.text);

      expect(text?.innerHTML).toBeUndefined();
    });
  });
});
