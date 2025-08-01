/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
import { Modal } from 'bootstrap';

import { getModalContentContainer } from '@js/helpers/modal';
import selectorsMap from '@js/constants/selectors-map';

import type { QuickviewResponse } from '../../types/quickview';

export default function initQuickview() {
  const { prestashop, Theme: { events } } = window as any;
  let lastQuickviewOpener: HTMLElement | null = null;

  async function fetchQuickview(data: Record<string, unknown>): Promise<QuickviewResponse> {
    const url = prestashop.urls.pages.product as string;
    const params = new URLSearchParams();

    Object.entries(data).forEach(([key, value]) => {
      if (value !== undefined && value !== null) {
        params.append(key, String(value));
      }
    });

    const resp = await fetch(url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'X-Requested-With': 'XMLHttpRequest',
        'Accept': 'application/json',
      },
      body: params,
      credentials: 'same-origin',
    });

    if (!resp.ok) {
      const errorText = await resp.text().catch(() => '');

      throw new Error(`Quickview fetch failed: ${resp.status} ${errorText}`);
    }

    return resp.json();
  }

  function openModalFromHtml(resp: QuickviewResponse, openerContext: HTMLElement) {
    const modalContainer = getModalContentContainer();

    if (modalContainer) {
      modalContainer.innerHTML = resp.quickview_html;
    } else {
      throw new Error('Modal container not found.');
    }

    const modalId = `quickview-modal-${resp.product.id}-${resp.product.id_product_attribute}`;
    const modalElement = document.getElementById(modalId) as HTMLElement | null;

    if (!modalElement) {
      throw new Error(`Modal element #${modalId} not found.`);
    }

    let dismissIntent: 'keyboard' | 'pointer' | 'unknown' = 'unknown';

    const onKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape' || e.key === 'Esc') {
        dismissIntent = 'keyboard';
      }
  
      const active = document.activeElement as HTMLElement | null;

      if (
        active &&
        active.closest('[data-bs-dismiss="modal"]') &&
        (e.key === 'Enter' || e.key === ' ' || e.code === 'Space')
      ) {
        dismissIntent = 'keyboard';
      }
    };

    const onPointerDown = () => {
      dismissIntent = 'pointer';
    };

    modalElement.addEventListener('shown.bs.modal', () => {
      document.addEventListener('keydown', onKeyDown, { capture: true });
      document.addEventListener('pointerdown', onPointerDown, { capture: true });

      prestashop.emit(events.quickviewOpened);
    });

    modalElement.addEventListener('hidden.bs.modal', () => {
      document.removeEventListener('keydown', onKeyDown, { capture: true });
      document.removeEventListener('pointerdown', onPointerDown, { capture: true });

      if (dismissIntent === 'keyboard' && lastQuickviewOpener && document.contains(lastQuickviewOpener)) {
        lastQuickviewOpener.focus();
      } else if (!lastQuickviewOpener) {
        console.error('Last quickview opener not found.');
      }

      modalElement.remove();
    });

    Modal.getOrCreateInstance(modalElement, { focus: true, keyboard: true }).show();
  }

  prestashop.on(events.clickQuickview, (elm: HTMLElement) => {
    const data = {
      action: 'quickview',
      id_product: elm.dataset.idProduct,
      id_product_attribute: elm.dataset.idProductAttribute,
    };

    fetchQuickview(data)
      .then((resp) => openModalFromHtml(resp, elm))
      .catch((err) => {
        prestashop.emit(events.handleError, {
          eventType: 'clickQuickView',
          resp: err,
        });
      });
  });

  document.addEventListener('click', (event: MouseEvent) => {
    const target = event.target as Element | null;
    if (!target) return;

    const quickviewButton = target.closest(selectorsMap.quickview) as HTMLElement | null;

    if (quickviewButton) {
      const productMiniature = quickviewButton.closest(selectorsMap.product.miniature) as HTMLElement | null;

      if (productMiniature) {
        lastQuickviewOpener = quickviewButton;
        quickviewButton.focus();
        prestashop.emit(events.clickQuickview, productMiniature);
      }
    }
  });

  prestashop.on(events.updateCart, () => {
    document.querySelectorAll<HTMLElement>(selectorsMap.quickviewModal).forEach((el) => {
      const instance = Modal.getInstance(el) || Modal.getOrCreateInstance(el);
      instance.hide();
    });
  });
}
