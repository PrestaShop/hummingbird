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

import {Collapse} from 'bootstrap';

function isHTMLElement(element: EventTarget | null): element is HTMLElement {
  return (element as HTMLElement).innerText !== undefined;
}

export default () => {
  const {prestashop} = window;
  const voucherCodes = document.querySelectorAll(prestashop.themeSelectors.cart.discountCode);

  voucherCodes.forEach((voucher) => {
    voucher.addEventListener('click', (event: Event) => {
      event.stopPropagation();

      if (isHTMLElement(event.currentTarget)) {
        const code = event.currentTarget;
        const discountInput = document.querySelector(prestashop.themeSelectors.cart.discountName);
        const formCollapser = new Collapse(document.querySelector(prestashop.themeSelectors.cart.promoCode));

        discountInput.value = code.innerText;
        // Show promo code field
        formCollapser.show();
      }

      return false;
    });
  })
};
