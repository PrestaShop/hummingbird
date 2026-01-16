/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import {emailAlerts} from '@constants/selectors-map';
import useAlert from '@js/components/useAlert';

// Types
interface MailAlertResponse {
  error: boolean;
  message: string;
}

/**
 * Subscribe to a mail alert notification for a product
 */
const subscribe = async (wrapper: HTMLElement, productId: string, productAttributeId: string): Promise<void> => {
  const {url} = wrapper.dataset as {url: string};

  if (!url) return;

  const emailInput = wrapper.querySelector<HTMLInputElement>(emailAlerts.emailInput);
  const alertsContainer = wrapper.querySelector<HTMLElement>(emailAlerts.alertsContainer);

  const formData = new URLSearchParams({
    id_product: productId,
    id_product_attribute: productAttributeId,
    customer_email: emailInput?.value ?? '',
  });

  try {
    const response = await fetch(url, {
      method: 'POST',
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: formData.toString(),
    });

    const data: MailAlertResponse = await response.json();

    if (alertsContainer) {
      alertsContainer.innerHTML = '';
      alertsContainer.classList.remove('d-none');

      const alert = useAlert(data.message, {
        type: data.error ? 'danger' : 'success',
        selector: emailAlerts.alertsContainer,
      });

      alert.show();
    }

    if (!data.error) {
      wrapper.querySelector<HTMLElement>(emailAlerts.content)?.classList.add('d-none');
    }
  } catch (error) {
    console.error('[EmailAlerts] Subscribe error:', error);
  }
};

/**
 * Remove a mail alert subscription
 */
const unsubscribe = async (button: HTMLElement): Promise<void> => {
  const {url, productId, productAttributeId} = button.dataset;

  if (!url || !productId || !productAttributeId) return;

  const productElement = button.closest<HTMLElement>(emailAlerts.product);
  const listItem = productElement?.closest('li');

  if (!listItem) return;

  const formData = new URLSearchParams({
    id_product: productId,
    id_product_attribute: productAttributeId,
  });

  try {
    const response = await fetch(url, {
      method: 'POST',
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: formData.toString(),
    });

    const result = await response.text();

    if (result === '0') {
      listItem.remove();

      // Show "no alerts" message if list is empty
      const remainingProducts = document.querySelectorAll(emailAlerts.product);

      if (remainingProducts.length === 0) {
        document.querySelector<HTMLElement>(emailAlerts.productList)?.classList.add('d-none');
        document.querySelector<HTMLElement>(emailAlerts.noAlerts)?.classList.remove('d-none');
      }
    }
  } catch (error) {
    console.error('[EmailAlerts] Unsubscribe error:', error);
  }
};

/**
 * Handle click events (delegated)
 */
const handleClick = (event: MouseEvent): void => {
  const target = event.target as HTMLElement;

  // Handle subscribe button
  const subscribeButton = target.closest<HTMLButtonElement>(emailAlerts.submitButton);

  if (subscribeButton) {
    event.preventDefault();

    const wrapper = subscribeButton.closest<HTMLElement>(emailAlerts.wrapper);
    const {product, productAttribute} = subscribeButton.dataset;

    if (wrapper && product && productAttribute) {
      subscribe(wrapper, product, productAttribute);
    }

    return;
  }

  // Handle remove button
  const removeButton = target.closest<HTMLElement>(emailAlerts.removeButton);

  if (removeButton) {
    event.preventDefault();
    unsubscribe(removeButton);
  }
};

/**
 * Initialize email alerts module
 */
const initEmailalerts = (): void => {
  document.addEventListener('click', handleClick);
};

export default initEmailalerts;
