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
import { Modal } from 'bootstrap';

prestashop.blockcart = prestashop.blockcart || {};

prestashop.blockcart.showModal = (html: string) => {
  function getBlockCartModal() {
    const blockCartModal = <HTMLElement>document.querySelector('#blockcart-modal');

    return blockCartModal;
  }

  let blockCartModal = getBlockCartModal();

  if (blockCartModal) {
    blockCartModal.remove();
  }

  let mainElement = document.createElement('div');
  mainElement.innerHTML = html;

  document.querySelector('body')?.append(<HTMLElement>mainElement.querySelector('#blockcart-modal'));

  blockCartModal = getBlockCartModal();

  const modal = new Modal(blockCartModal);

  if ($addToCartButton !== undefined) {
    toggleSpinner();
  }

  modal.show();

  blockCartModal.addEventListener('hidden.bs.modal', (event: Event) => {
    const target = <HTMLElement>event.currentTarget;

    if (target) {
      prestashop.emit('updateProduct', {
        reason: target.dataset,
        event,
      });
    }
  });
};

const $body = $('body');
let $addToCartButton : any;

$body.on('click', '[data-button-action="add-to-cart"]', (event) => {
  event.preventDefault();

  $addToCartButton = $(event.currentTarget);
  toggleSpinner();
});

function toggleSpinner() {
  $addToCartButton.find('.spinner-border').toggleClass('visually-hidden');
  $addToCartButton.find('.material-icons').toggleClass('visually-hidden');
}
