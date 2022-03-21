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
import swapElements from '@helpers/swapElements';

export function toggleMobileStyles() {
  const {prestashop} = window;

  if (prestashop.responsive.mobile) {
    Array.prototype.forEach.call(document.querySelectorAll("*[id^='_desktop_']"), (el: HTMLElement): void => {
      const source = document.querySelector(`#${el.id}`);
      const target = document.querySelector(`#${el.id.replace('_desktop_', '_mobile_')}`);

      if (target && source) {
        swapElements(source, target);
      }
    });
  } else {
    Array.prototype.forEach.call(document.querySelectorAll("*[id^='_mobile_']"), (el) => {
      const source = document.querySelector(`#${el.id}`);
      const target = document.querySelector(`#${el.id.replace('_mobile_', '_desktop_')}`);

      if (target && source) {
        swapElements(source, target);
      }
    });
  }
  prestashop.emit('responsive update', {
    mobile: prestashop.responsive.mobile,
  });
}

export default function initResponsiveToggler() {
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

  document.addEventListener('DOMContentLoaded', () => {
    if (prestashop.responsive.mobile) {
      toggleMobileStyles();
    }
  });
}
