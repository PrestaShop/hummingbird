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
import {Modal} from 'bootstrap';
import {isHTMLElement} from '@helpers/typeguards';

const {prestashop} = window;

prestashop.blockcart = prestashop.blockcart || {};

prestashop.blockcart.showModal = (html: string) => {
  const {blockcart: BlockcartMap} = prestashop.themeSelectors;

  function getBlockCartModal() {
    const blockCartModal = document.querySelector<HTMLElement>(BlockcartMap.modal);

    return blockCartModal;
  }

  let blockCartModal = getBlockCartModal();

  if (blockCartModal) {
    blockCartModal.remove();
  }

  const mainElement = document.createElement('div');
  mainElement.innerHTML = html;
  // Select the template of the modal
  const modalTemplate = mainElement.querySelector<HTMLElement>(BlockcartMap.modal);

  if (modalTemplate) {
    // If the template exist, append it to the body
    document.querySelector('body')?.append(modalTemplate);
  }

  blockCartModal = getBlockCartModal();

  if (blockCartModal) {
    const modal = new Modal(blockCartModal);

    modal.show();

    blockCartModal.addEventListener('hidden.bs.modal', (event: Event) => {
      const target = event.currentTarget;

      if (isHTMLElement(target)) {
        prestashop.emit('updateProduct', {
          reason: target.dataset,
          event,
        });
      }
    });
  }
};
