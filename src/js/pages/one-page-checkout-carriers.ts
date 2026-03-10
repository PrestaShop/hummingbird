/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
import {onePageCheckout as OpcMap} from '@constants/selectors-map';
import EVENTS from '@constants/events-map';
import {validateForm} from '@js/pages/one-page-checkout';

export interface DeliveryOption {
  name: string;
  delay: string;
  price: string;
  logo: string | false | null;
  id?: number;
}

export interface OpcCarriersResponse {
  delivery_options: Record<string, DeliveryOption>;
  selected_delivery_option: string | null;
  carrier_was_reset: boolean;
  id_address_delivery?: number;
  preview?: string;
}

/**
 * Render carrier list HTML from delivery_options JSON.
 * Mirrors carriers.tpl for client-side re-renders.
 */
export const renderCarrierList = (
  options: Record<string, DeliveryOption>,
  selected: string | null,
  noCarriersMessage?: string,
): string => {
  if (!Object.keys(options).length) {
    const msg = noCarriersMessage ?? 'Unfortunately, there are no carriers available for your delivery address.';

    return `<p class="alert alert-warning mb-0">${msg}</p>`;
  }

  const items = Object.entries(options)
    .map(([key, carrier]) => {
      const inputId = `opc_delivery_option_${carrier.id ?? key}`;
      const logo = carrier.logo
        ? `<img class="delivery-option__carrier-logo" src="${carrier.logo}" alt="${carrier.name}" loading="lazy" aria-hidden="true">`
        : '';

      return `
        <div class="delivery-option__item js-delivery-option">
          <label class="delivery-option__label" for="${inputId}">
            <div class="delivery-option__left">
              <span class="delivery-option__check form-check">
                <input type="radio" class="form-check-input" name="delivery_option"
                  id="${inputId}" value="${key}"${selected === key ? ' checked' : ''}>
              </span>
              <div class="delivery-option__carrier${carrier.logo ? ' delivery-option__carrier--hasLogo' : ''}">
                ${logo}
                <span class="delivery-option__carrier-name">${carrier.name}</span>
              </div>
            </div>
            <div class="delivery-option__content">${carrier.delay}</div>
            <div class="delivery-option__price">${carrier.price}</div>
          </label>
        </div>`;
    })
    .join('');

  return `<div class="delivery-options__list">${items}</div>`;
};

const updateCartSummary = (preview: string): void => {
  const summaryEl = document.querySelector('#js-checkout-summary');
  if (!summaryEl) return;

  const tmpl = document.createElement('template');
  tmpl.innerHTML = preview.trim();
  const newSummary = tmpl.content.firstElementChild;
  if (!newSummary) return;

  summaryEl.replaceWith(newSummary);

  const totalEl = newSummary.querySelector('.js-cart-summary-totals .cart-summary__value:last-child');
  const payBtn = document.querySelector('.js-opc-pay-amount');
  if (totalEl && payBtn) {
    payBtn.textContent = totalEl.textContent?.trim() ?? '';
  }
};

const getTemplateHTML = (id: string): string => {
  const tpl = document.querySelector<HTMLTemplateElement>(`#${id}`);
  return tpl ? tpl.innerHTML : '';
};

// Fetch + emit updatedOpcCarriers is handled by core opc-carriers-list.js.
// This module owns: rendering the carrier list HTML + updating the cart summary.
const initCarriers = (): void => {

  document.querySelector(OpcMap.deliveryMethods)?.addEventListener('click', (e) => {
    if ((e.target as HTMLElement).closest('[data-opc-action="retry-carriers"]')) {
      window.prestashop.emit(EVENTS.opcRetryCarriers);
    }
  });

  window.prestashop.on(EVENTS.opcCarriersLoading, () => {
    const container = document.querySelector<HTMLElement>(OpcMap.deliveryMethods);
    if (container) {
      const height = `${container.offsetHeight}px`;
      container.style.minHeight = height;
      container.style.height = height;
      container.innerHTML = getTemplateHTML('opc-template-loader');
    }
    // Disable directly: no carrier can be selected while loading
    const btn = document.querySelector<HTMLButtonElement>(OpcMap.payButton);
    if (btn) btn.disabled = true;
  });

  window.prestashop.on(EVENTS.updatedOpcCarriers, (data: OpcCarriersResponse) => {
    const container = document.querySelector<HTMLElement>(OpcMap.deliveryMethods);
    if (!container) return;

    container.style.minHeight = '';
    container.style.height = '';
    container.innerHTML = renderCarrierList(
      data.delivery_options,
      data.selected_delivery_option,
      container.dataset.msgNoCarriers,
    );

    if (data.id_address_delivery) {
      container.dataset.idAddress = String(data.id_address_delivery);
    } else {
      delete container.dataset.idAddress;
    }

    if (data.preview) {
      updateCartSummary(data.preview);
    }

    // Let validateForm decide: it checks required fields + carrier selection
    validateForm();
  });

  window.prestashop.on(EVENTS.opcCarriersFailed, () => {
    const container = document.querySelector<HTMLElement>(OpcMap.deliveryMethods);
    if (container) {
      container.style.minHeight = '';
      container.style.height = '';
      container.innerHTML = getTemplateHTML('opc-template-carriers-error');
    }
    // No carrier can be selected after a failure
    validateForm();
  });
};

export default initCarriers;
