/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import SelectorsMap from '@constants/selectors-map';
import useAlert from './useAlert';

const handleCartAction = (event: Event): void => {
  event.stopPropagation();
  event.preventDefault();

  // Get the target element and its dataset
  const target = event.target as HTMLElement;

  // Make request to refresh the cart
  sendCartRefreshRequest(target);
};

const sendCartRefreshRequest = (target: HTMLElement): void => {
  const {prestashop, Theme: {events}} = window;
  const {dataset} = target;

  const targetUrl = target.getAttribute('href');

  if (targetUrl === null) {
    return;
  }

  const formData = new FormData();
  formData.append('ajax', '1');
  formData.append('action', 'update');

  fetch(targetUrl, {
    method: 'POST',
    body: formData,
  })
    .then((resp: Response) => {
      // Refresh cart preview
      prestashop.emit(events.updateCart, {
        reason: dataset,
        resp,
      });

      // Show product removal success alert
      if (target && target.getAttribute('data-link-action') === SelectorsMap.cart.deleteLinkAction) {
        const alertPlaceholder = document.querySelector(SelectorsMap.cart.alertPlaceholder);
        const productUrl = target.getAttribute('data-product-url');
        const productName = target.getAttribute('data-product-name');

        if (alertPlaceholder && productUrl && productName) {
          const alertText = alertPlaceholder.getAttribute('data-alert');
          const productLink = `<a class="alert-link" href="${productUrl}">${productName}</a>`;
          const alertMessage = `${productLink} ${alertText}`;

          if (alertMessage) {
            const alert = useAlert(alertMessage, {
              type: 'success',
              selector: SelectorsMap.cart.alertPlaceholder,
            });

            alert.show();
          }
        }
      }
    })
    .catch((err) => {
      const errorData = err as Response;
      prestashop.emit(events.handleError, {
        eventType: 'updateProductInCart',
        errorData,
      });
    });
};

export default handleCartAction;
