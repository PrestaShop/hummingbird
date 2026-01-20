/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import {emailAlerts} from '@constants/selectors-map';
import useAlert from '@js/components/useAlert';
import parseData from '@helpers/parseData';

// Types and validators
interface MailAlertResponse {
  error: boolean;
  message: string;
}

interface SubscribeData {
  product_id: string;
  product_attribute_id: string;
}

interface UnsubscribeData {
  product_id: string;
  product_attribute_id: string;
  url: string;
}

const subscribeValidator: Validator<SubscribeData> = (data): data is SubscribeData => (
  typeof data === 'object'
    && data !== null
    && typeof (data as SubscribeData).product_id === 'string'
    && typeof (data as SubscribeData).product_attribute_id === 'string'
);

const unsubscribeValidator: Validator<UnsubscribeData> = (data): data is UnsubscribeData => (
  typeof data === 'object'
    && data !== null
    && typeof (data as UnsubscribeData).product_id === 'string'
    && typeof (data as UnsubscribeData).product_attribute_id === 'string'
    && typeof (data as UnsubscribeData).url === 'string'
);

/**
 * Subscribe to a mail alert notification for a product
 */
const subscribe = async (wrapper: HTMLElement, data: SubscribeData): Promise<void> => {
  const {url} = wrapper.dataset as {url: string};

  if (!url) return;

  const emailInput = wrapper.querySelector<HTMLInputElement>(emailAlerts.emailInput);
  const alertsContainer = wrapper.querySelector<HTMLElement>(emailAlerts.alertsContainer);

  const formData = new URLSearchParams({
    id_product: data.product_id,
    id_product_attribute: data.product_attribute_id,
    customer_email: emailInput?.value ?? '',
  });

  try {
    const response = await fetch(url, {
      method: 'POST',
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: formData.toString(),
    });

    const result: MailAlertResponse = await response.json();

    if (alertsContainer) {
      alertsContainer.innerHTML = '';
      alertsContainer.classList.remove('d-none');

      const alert = useAlert(result.message, {
        type: result.error ? 'danger' : 'success',
        selector: emailAlerts.alertsContainer,
      });

      alert.show();
    }

    if (!result.error) {
      wrapper.querySelector<HTMLElement>(emailAlerts.content)?.classList.add('d-none');
    }
  } catch (error) {
    console.error('[EmailAlerts] Subscribe error:', error);
  }
};

/**
 * Remove a mail alert subscription
 */
const unsubscribe = async (button: HTMLElement, data: UnsubscribeData): Promise<void> => {
  const productElement = button.closest<HTMLElement>(emailAlerts.product);

  if (!productElement) return;

  const formData = new URLSearchParams({
    id_product: data.product_id,
    id_product_attribute: data.product_attribute_id,
  });

  try {
    const response = await fetch(data.url, {
      method: 'POST',
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: formData.toString(),
    });

    const result = await response.text();

    if (result === '0') {
      productElement.remove();

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
    const result = parseData<SubscribeData>(subscribeButton, subscribeValidator);

    if (result && wrapper) {
      subscribe(wrapper, result);
    }

    return;
  }

  // Handle remove button
  const deleteButton = target.closest<HTMLElement>(emailAlerts.deleteButton);

  if (deleteButton) {
    event.preventDefault();

    const result = parseData<UnsubscribeData>(deleteButton, unsubscribeValidator);

    if (result) {
      unsubscribe(deleteButton, result);
    }
  }
};

/**
 * Initialize email alerts module
 */
const initEmailalerts = (): void => {
  document.addEventListener('click', handleClick);
};

export default initEmailalerts;
