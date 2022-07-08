/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
import selectorsMap from './constants/selectors-map';

export default function initQuickviews() {
  const {prestashop, Theme: {events}} = window;

  prestashop.on(events.clickQuickview, (elm: HTMLElement) => {
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
        productModal.on('hidden.bs.modal', () => {
          productModal.remove();
        });
        prestashop.emit(events.quickviewOpened);
      })
      .fail((resp) => {
        prestashop.emit(events.handleError, {
          eventType: 'clickQuickView',
          resp,
        });
      });
  });

  $(document).ready(() => {
    $('body').on('click', selectorsMap.quickview, (event) => {
      prestashop.emit(events.clickQuickview, {
        dataset: $(event.target).closest(selectorsMap.product.miniature).data(),
      });
      event.preventDefault();
    });
    prestashop.on('updateCart', () => {
      $(selectorsMap.quickviewModal).modal('hide');
    });
  });
}
