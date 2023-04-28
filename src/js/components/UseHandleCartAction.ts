/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

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
