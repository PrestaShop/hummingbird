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
import SelectorsMap from './selectors-map';

export default function initQuantityInput(selector = SelectorsMap.qtyInput.default) {
  const qtyInputList = document.querySelectorAll(selector);

  if (qtyInputList) {
    qtyInputList.forEach(function(qtyInput) {
      const qtyInputWrapper = qtyInput.parentNode;

      let subtractButton = createSpinButton('remove');
      subtractButton.addEventListener('click', () => changeQuantity(<HTMLInputElement>qtyInput, -1));
  
      let addButton = createSpinButton('add');
      addButton.addEventListener('click', () => changeQuantity(<HTMLInputElement>qtyInput, 1));
  
      qtyInputWrapper?.insertBefore(subtractButton, qtyInput);
      qtyInputWrapper?.appendChild(addButton);
    });
  }
}

function createSpinButton(text: string) {
  let spinButton = document.createElement('button');
  spinButton.type = 'button';
  spinButton.classList.add('btn');
  spinButton.innerHTML = '<i class="material-icons">' + text + '</i>';

  return spinButton;
}

function changeQuantity(input: HTMLInputElement, change: number) {
  const quantity = Number(input.value);
  
  if (isNaN(quantity))
    return;

  const min = Number(input.getAttribute('min')) ?? 0;
  input.value = String(Math.max(quantity + change, min));
}
