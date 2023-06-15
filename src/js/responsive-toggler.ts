/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
import swapElements from '@helpers/swapElements';
import {facetedsearch} from '@constants/selectors-map';
import {initSliders} from '@js/modules/facetedsearch';
import {Offcanvas} from 'bootstrap';

const {prestashop} = window;

if (prestashop) {
  prestashop.responsive = prestashop.responsive || {};

  prestashop.responsive.current_width = window.innerWidth;
  prestashop.responsive.min_width = 768;
  prestashop.responsive.mobile = prestashop.responsive.current_width < prestashop.responsive.min_width;
}

export function toggleMobileStyles() {
  // TODO: Find a better way to manage this with JSDom for tests
  // eslint-disable-next-line @typescript-eslint/no-shadow
  const {prestashop, Theme: {events}} = window;

  if (prestashop.responsive.mobile) {
    Array.prototype.forEach.call(document.querySelectorAll("*[id^='_desktop_']"), (el: HTMLElement): void => {
      const source = document.querySelector(`#${el.id}`);
      const target = document.querySelector(`#${el.id.replace('_desktop_', '_mobile_')}`);

      if (target && source) {
        swapElements(source, target);
      }
    });

    // we have to init again sliders because we reconstruct the dom
    initSliders();
  } else {
    Array.prototype.forEach.call(document.querySelectorAll("*[id^='_mobile_']"), async (el) => {
      const source = document.querySelector(`#${el.id}`);
      const target = document.querySelector(`#${el.id.replace('_mobile_', '_desktop_')}`);

      if (target && source) {
        swapElements(source, target);
      }
    });

    // we close the old mobile interface
    const offCanvasFacetedElement = document.querySelector(facetedsearch.offCanvasFaceted) as HTMLElement;

    if (offCanvasFacetedElement != null) {
      Offcanvas.getInstance(offCanvasFacetedElement)?.hide();
    }

    // we have to init again sliders because we reconstruct the dom
    initSliders();
  }

  prestashop.emit(events.responsiveUpdate, {
    mobile: prestashop.responsive.mobile,
  });
}

export default function initResponsiveToggler() {
  // TODO: Find a better way to manage this with JSDom for tests
  // eslint-disable-next-line @typescript-eslint/no-shadow
  const {prestashop} = window;

  prestashop.responsive = prestashop.responsive || {};

  prestashop.responsive.current_width = window.innerWidth;
  prestashop.responsive.min_width = 768;
  prestashop.responsive.mobile = prestashop.responsive.current_width < prestashop.responsive.min_width;

  window.addEventListener('resize', () => {
    const currentWidth = prestashop.responsive.current_width;
    const minWidth = prestashop.responsive.min_width;
    const screenWidth = window.innerWidth;
    const toggle = (currentWidth >= minWidth && screenWidth < minWidth)
      || (currentWidth < minWidth && screenWidth >= minWidth);

    prestashop.responsive.current_width = screenWidth;
    prestashop.responsive.mobile = prestashop.responsive.current_width < prestashop.responsive.min_width;
    if (toggle) {
      toggleMobileStyles();
    }
  });
}

document.addEventListener('DOMContentLoaded', () => {
  if (prestashop.responsive.mobile) {
    toggleMobileStyles();
  }
});
