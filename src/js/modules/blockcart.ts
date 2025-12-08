/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
import {Modal} from 'bootstrap';

import {events} from '@js/theme';
import getModalContentContainer from '@helpers/modal';
import selectorsMap from '@constants/selectors-map';

export default function initBlockCart() {
  const {prestashop} = window;
  let lastCartModalOpener: HTMLElement | null = null;
  let targetProductCard: HTMLElement | null = null;
  let quickviewCard: HTMLElement | null = null;

  function openModalFromHtml(addToCartModal: string) {
    const modalContainer = getModalContentContainer();

    modalContainer.innerHTML = addToCartModal;
    const modalElement = modalContainer.querySelector<HTMLElement>(selectorsMap.blockcartModal);

    if (!modalElement) {
      throw new Error('Blockcart modal element not found in provided HTML.');
    }

    // Track how the modal gets dismissed for accessibility reasons
    let dismissIntent: 'keyboard' | 'pointer' | 'unknown' = 'unknown';

    const onKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape' || e.key === 'Esc') {
        dismissIntent = 'keyboard';
      }

      const active = document.activeElement as HTMLElement | null;

      if (
        active
        && active.closest('[data-bs-dismiss="modal"]')
        && (e.key === 'Enter' || e.key === ' ' || e.code === 'Space')
      ) {
        dismissIntent = 'keyboard';
      }
    };

    const onPointerDown = () => {
      dismissIntent = 'pointer';
    };

    modalElement.addEventListener('shown.bs.modal', () => {
      document.addEventListener('keydown', onKeyDown, {capture: true});
      document.addEventListener('pointerdown', onPointerDown, {capture: true});

      const modalStatus = modalElement.querySelector<HTMLElement>(selectorsMap.blockcartModalStatus);

      if (modalStatus) {
        modalStatus.textContent = modalStatus.getAttribute('data-ps-data') ?? '';
      }
    });

    modalElement.addEventListener('hidden.bs.modal', (event: Event) => {
      const target = event.currentTarget as HTMLElement;

      if (target) {
        prestashop.emit(events.updateProduct, {
          reason: target.dataset,
          event,
        });
      }

      document.removeEventListener('keydown', onKeyDown, {capture: true});
      document.removeEventListener('pointerdown', onPointerDown, {capture: true});

      if (dismissIntent === 'keyboard' && lastCartModalOpener && document.contains(lastCartModalOpener)) {
        lastCartModalOpener.focus();
        targetProductCard = null;
      } else if (!lastCartModalOpener) {
        console.error('Last blockcart opener not found.');
      }

      modalElement.remove();
    });

    Modal.getOrCreateInstance(modalElement, {focus: true, keyboard: true}).show();
  }

  prestashop.on(events.clickQuickview, (productMiniature: HTMLElement) => {
    quickviewCard = productMiniature;
  });

  document.addEventListener('click', (event: MouseEvent) => {
    const target = event.target as HTMLElement | null;

    if (!target) return;

    const {
      quickview,
      quickviewButton,
      addToCartButton,
      product: {miniature, container},
    } = selectorsMap;

    const isQuickviewBtn = target.closest<HTMLElement>(quickviewButton) !== null;
    const isAddToCartBtn = target.closest<HTMLElement>(addToCartButton) !== null;

    if (isQuickviewBtn) {
      targetProductCard = target.closest<HTMLElement>(miniature);
      lastCartModalOpener = targetProductCard?.querySelector<HTMLElement>(quickview) ?? null;
    } else if (isAddToCartBtn) {
      const productCard = target.closest<HTMLElement>(miniature);
      const productPage = target.closest<HTMLElement>(container);

      if (productCard) {
        targetProductCard = productCard;
        lastCartModalOpener = targetProductCard?.querySelector<HTMLElement>(addToCartButton) ?? null;
      } else if (productPage) {
        const targetProductPage = productPage;
        lastCartModalOpener = targetProductPage?.querySelector<HTMLElement>(addToCartButton) ?? null;
      } else {
        targetProductCard = quickviewCard;
        lastCartModalOpener = targetProductCard?.querySelector<HTMLElement>(quickview) ?? null;
      }
    }
  });

  // Legacy support for function call
  prestashop.blockcart = prestashop.blockcart || {};
  prestashop.blockcart.showModal = function showAddToCartModal(addToCartModal: string) {
    openModalFromHtml(addToCartModal);
  };
}
