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
 * Add a mail alert notification for a product
 */
const addNotification = async (
  wrapper: HTMLElement,
  productId: string,
  productAttributeId: string,
): Promise<void> => {
  const {url} = wrapper.dataset as {url: string};

  if (!url) return;

  const emailInput = wrapper.querySelector<HTMLInputElement>(emailAlerts.emailInput);
  const customerEmail = emailInput ? emailInput.value : '';
  const alertsContainer = wrapper.querySelector<HTMLElement>(emailAlerts.alertsContainer);

  const formData = new URLSearchParams({
    id_product: productId,
    id_product_attribute: productAttributeId,
    customer_email: customerEmail,
  });

  try {
    const response = await fetch(url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: formData.toString(),
    });

    const data: MailAlertResponse = await response.json();
    const alertType: Theme.Alert.Type = data.error ? 'danger' : 'success';

    if (alertsContainer) {
      alertsContainer.innerHTML = '';
      alertsContainer.classList.remove('d-none');

      const alert = useAlert(data.message, {
        type: alertType,
        selector: emailAlerts.alertsContainer,
      });

      alert.show();
    }

    if (!data.error) {
      const content = wrapper.querySelector<HTMLElement>(emailAlerts.content);

      if (content) {
        content.classList.add('d-none');
      }
    }
  } catch (error) {
    console.error('Mail alert error:', error);
  }
};

/**
 * Show the "no alerts" message and hide the product list
 */
const showNoAlertsMessage = (): void => {
  const productList = document.querySelector<HTMLElement>(emailAlerts.productList);
  const noAlertsMessage = document.querySelector<HTMLElement>(emailAlerts.noAlerts);

  productList?.classList.add('d-none');
  noAlertsMessage?.classList.remove('d-none');
};

/**
 * Remove a mail alert for a product
 */
const removeAlert = async (button: HTMLElement): Promise<void> => {
  const {url, productId, productAttributeId} = button.dataset;

  if (!url || !productId || !productAttributeId) return;

  const parentItem = button.closest<HTMLElement>(emailAlerts.product)?.closest('li');

  if (!parentItem) return;

  const formData = new URLSearchParams({
    id_product: productId,
    id_product_attribute: productAttributeId,
  });

  try {
    const response = await fetch(url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: formData.toString(),
    });

    const result = await response.text();

    if (result === '0') {
      parentItem.remove();

      // Check if there are remaining products
      const remainingProducts = document.querySelectorAll(emailAlerts.product);

      if (remainingProducts.length === 0) {
        showNoAlertsMessage();
      }
    }
  } catch (error) {
    console.error('Remove alert error:', error);
  }
};

/**
 * Initialize email alerts module
 */
const initEmailalerts = (): void => {
  // Handle submit button click (delegated)
  document.addEventListener('click', (event: MouseEvent) => {
    const target = event.target as HTMLElement;
    const submitButton = target.closest<HTMLButtonElement>(emailAlerts.submitButton);

    if (submitButton) {
      event.preventDefault();

      const alertWrapper = submitButton.closest<HTMLElement>(emailAlerts.wrapper);
      const productId = submitButton.dataset.product;
      const productAttributeId = submitButton.dataset.productAttribute;

      if (alertWrapper && productId && productAttributeId) {
        addNotification(alertWrapper, productId, productAttributeId);
      }
    }
  });

  // Handle remove button click (delegated)
  document.addEventListener('click', (event: MouseEvent) => {
    const target = event.target as HTMLElement;
    const removeButton = target.closest<HTMLElement>(emailAlerts.removeButton);

    if (removeButton) {
      event.preventDefault();
      removeAlert(removeButton);
    }
  });
};

export default initEmailalerts;
