/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
import initEmitter from '@js/prestashop';
import resetHTMLBodyContent from '@helpers/resetBody';
import {
  FormWithCarriersContainer,
  mockCarriersResponse,
  mockEmptyCarriersResponse,
} from '@constants/mocks/onePageCheckout-data';
import initCarriers, {
  renderCarrierList,
} from '@js/pages/one-page-checkout-carriers';
import {onePageCheckout} from '@constants/selectors-map';

const getDeliveryMethods = (): HTMLElement =>
  document.querySelector<HTMLElement>(onePageCheckout.deliveryMethods)!;

describe('One Page Checkout — Carriers', () => {
  beforeAll(() => {
    window.prestashop = {} as any;
    initEmitter();
  });

  beforeEach(() => {
    resetHTMLBodyContent(FormWithCarriersContainer);
  });

  afterEach(() => {
    jest.restoreAllMocks();
    window.prestashop.removeAllListeners('updatedOpcAddressForm');
    window.prestashop.removeAllListeners('updatedOpcCarriers');
  });

  // ---------------------------------------------------------------------------
  // renderCarrierList
  // ---------------------------------------------------------------------------

  describe('renderCarrierList', () => {
    it('shows a warning when delivery_options is empty', () => {
      const html = renderCarrierList({}, null);
      expect(html).toContain('alert');
    });

    it('uses the translated message when provided', () => {
      const html = renderCarrierList({}, null, 'Aucun transporteur disponible.');
      expect(html).toContain('Aucun transporteur disponible.');
    });

    it('falls back to default message when no translation provided', () => {
      const html = renderCarrierList({}, null);
      expect(html).toContain('Unfortunately');
    });

    it('renders one radio per carrier', () => {
      const html = renderCarrierList(mockCarriersResponse.delivery_options, '1,');
      expect(html).toContain('value="1,"');
      expect(html).toContain('value="2,"');
    });

    it('marks the selected carrier as checked', () => {
      const html = renderCarrierList(mockCarriersResponse.delivery_options, '1,');
      const el = document.createElement('div');
      el.innerHTML = html;

      const checked = el.querySelector<HTMLInputElement>('input[value="1,"]');
      const unchecked = el.querySelector<HTMLInputElement>('input[value="2,"]');

      expect(checked?.hasAttribute('checked')).toBe(true);
      expect(unchecked?.hasAttribute('checked')).toBe(false);
    });

    it('renders carrier name and price', () => {
      const html = renderCarrierList(mockCarriersResponse.delivery_options, null);
      expect(html).toContain('Colissimo');
      expect(html).toContain('€5.00');
      expect(html).toContain('Chronopost');
    });
  });

  // ---------------------------------------------------------------------------
  // initCarriers — renders on updatedOpcCarriers event
  // ---------------------------------------------------------------------------

  describe('initCarriers', () => {
    it('renders carriers into #opc-delivery-methods on updatedOpcCarriers', () => {
      initCarriers();
      window.prestashop.emit('updatedOpcCarriers', mockCarriersResponse);

      expect(getDeliveryMethods().innerHTML).toContain('Colissimo');
      expect(getDeliveryMethods().innerHTML).toContain('Chronopost');
    });

    it('renders warning when delivery_options is empty', () => {
      initCarriers();
      window.prestashop.emit('updatedOpcCarriers', mockEmptyCarriersResponse);

      expect(getDeliveryMethods().innerHTML).toContain('alert');
    });

    it('updates data-id-address when id_address_delivery is provided', () => {
      initCarriers();
      window.prestashop.emit('updatedOpcCarriers', {
        ...mockCarriersResponse,
        id_address_delivery: 42,
      });

      expect(getDeliveryMethods().dataset.idAddress).toBe('42');
    });

    it('does not update data-id-address when id_address_delivery is absent', () => {
      initCarriers();
      window.prestashop.emit('updatedOpcCarriers', mockCarriersResponse);

      expect(getDeliveryMethods().dataset.idAddress).toBeUndefined();
    });
  });
});
