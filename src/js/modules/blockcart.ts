/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
import {Modal} from 'bootstrap';
import {isHTMLElement} from '@helpers/typeguards';

const {prestashop} = window;

prestashop.blockcart = prestashop.blockcart || {};

prestashop.blockcart.showModal = (html: string) => {
  const {Theme} = window;
  const {events} = Theme;
  const {blockcart: BlockcartMap} = Theme.selectors;

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
        prestashop.emit(events.updateProduct, {
          reason: target.dataset,
          event,
        });
      }
    });
  }
};
