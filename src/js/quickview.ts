/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
import useQuantityInput from './components/useQuantityInput';
import selectorsMap from './constants/selectors-map';

const {prestashop} = window;

export default function initQuickviews() {
  prestashop.on('clickQuickView', (elm: HTMLElement) => {
    const data = {
      action: 'quickview',
      id_product: elm.dataset.idProduct,
      id_product_attribute: elm.dataset.idProductAttribute,
    };
    $.post(prestashop.urls.pages.product, data, null, 'json')
      .then((resp) => {
        $('body').append(resp.quickview_html);
        const productModal = $(
          `#quickview-modal-${resp.product.id}-${resp.product.id_product_attribute}`,
        );
        productModal.modal('show');
        useQuantityInput(selectorsMap.qtyInput.modal);
        productModal.on('hidden.bs.modal', () => {
          productModal.remove();
        });
      })
      .fail((resp) => {
        prestashop.emit('handleError', {
          eventType: 'clickQuickView',
          resp,
        });
      });
  });

  $(document).ready(() => {
    $('body').on('click', selectorsMap.quickview, (event) => {
      prestashop.emit('clickQuickView', {
        dataset: $(event.target).closest(selectorsMap.product.miniature).data(),
      });
      event.preventDefault();
    });
  });
}
