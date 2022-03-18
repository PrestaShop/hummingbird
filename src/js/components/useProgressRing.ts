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

export interface ProgressRingReturn {
  setProgress: (perfect: number) => void
}

// Not testable because it manipulates SVG elements, unsupported by JSDom
const useProgressRing = (element: SVGCircleElement | null, size = 74): ProgressRingReturn | Error => {
  if (element && element.parentElement) {
    const backgroundCircle = element.parentElement.querySelector<SVGCircleElement>('.progress-ring__background-circle');

    // We need to dynamically set the sizes of circles because we can use any progress circle sizes
    const setSizes = (sizedElement: SVGCircleElement, parentElement: HTMLElement | null) => {
      if (parentElement) {
        parentElement.style.width = `${size}px`;
        parentElement.style.height = `${size}px`;
        parentElement.setAttribute('width', size.toString());
        parentElement.setAttribute('height', size.toString());

        if (parentElement.getAttribute('width') && element.getAttribute('stroke-width')) {
          // eslint-disable-next-line max-len, @typescript-eslint/no-non-null-assertion
          sizedElement.r.baseVal.value = (parseFloat(parentElement.getAttribute('width')!) / 2) - (parseFloat(element.getAttribute('stroke-width')!) * 2);
        }
      }

      sizedElement.cx.baseVal.value = size / 2;
      sizedElement.cy.baseVal.value = size / 2;
    };

    setSizes(element, element.parentElement);

    if (backgroundCircle) {
      setSizes(backgroundCircle, backgroundCircle.parentElement);
    }

    const radius = element.r.baseVal.value;
    const circumference = radius * 2 * Math.PI;

    element.style.strokeDasharray = `${circumference} ${circumference}`;
    element.style.strokeDashoffset = `${circumference}`;

    // This function makes the progress editable after initialization
    const setProgress = (percent: number) => {
      const offset = circumference - (percent / 100) * circumference;
      element.style.strokeDashoffset = offset.toString();
    };

    setProgress(element.dataset.percent ? parseFloat(element.dataset.percent) : 0);

    return {
      setProgress,
    };
  }

  return new Error('The circle is not linked to an SVG circle');
};

export default useProgressRing;
