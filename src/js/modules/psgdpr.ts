/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import {gdpr} from '@constants/selectors-map';
import parseData from '@helpers/parseData';

// Types and validators
interface GdprData {
  id_module: string;
  front_controller: string;
  id_customer: string;
  customer_token: string;
  id_guest: string;
  guest_token: string;
}

const gdprDataValidator: Validator<GdprData> = (data): data is GdprData => (
  typeof data === 'object'
    && data !== null
    && typeof (data as GdprData).id_module === 'string'
    && typeof (data as GdprData).front_controller === 'string'
    && typeof (data as GdprData).id_customer === 'string'
    && typeof (data as GdprData).customer_token === 'string'
    && typeof (data as GdprData).id_guest === 'string'
    && typeof (data as GdprData).guest_token === 'string'
);

/**
 * Get GDPR data from element and clean up URL encoding
 */
const getGdprData = (element: HTMLElement): GdprData | null => {
  const result = parseData<GdprData>(element, gdprDataValidator);

  if (!result) {
    return null;
  }

  // Clean up front_controller URL encoding
  if (result.front_controller) {
    result.front_controller = result.front_controller.replace(/&amp;/g, '&');
  }

  return result;
};

/**
 * Find the submit button associated with a consent element
 * Looks in custom wrapper first, then falls back to parent form
 */
const findSubmitButton = (consentElement: HTMLElement): HTMLButtonElement | null => {
  // Try custom wrapper (data-ps-component="gdpr")
  const wrapper = consentElement.closest<HTMLElement>(gdpr.consentWrapper);

  if (wrapper) {
    return wrapper.querySelector<HTMLButtonElement>(gdpr.submitButton)
      ?? wrapper.querySelector<HTMLButtonElement>('[type="submit"]');
  }

  // Fall back to form
  const form = consentElement.closest<HTMLFormElement>('form');

  return form?.querySelector<HTMLButtonElement>('[type="submit"]') ?? null;
};

/**
 * Update submit button disabled state based on checkbox
 */
const updateButtonState = (checkbox: HTMLInputElement, button: HTMLButtonElement): void => {
  button.disabled = !checkbox.checked;
};

/**
 * Log consent to GDPR module backend
 */
const logConsent = async (data: GdprData): Promise<void> => {
  const {front_controller, ...params} = data;
  const formData = new URLSearchParams({
    ajax: 'true',
    action: 'AddLog',
    ...params,
  });

  try {
    await fetch(front_controller, {
      method: 'POST',
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: formData.toString(),
    });
  } catch (error) {
    console.error('[GDPR] Log consent error:', error);
  }
};

/**
 * Initialize button states for all GDPR consent elements
 */
const initButtonStates = (): void => {
  document.querySelectorAll<HTMLElement>(gdpr.consent).forEach((consentElement) => {
    const checkbox = consentElement.querySelector<HTMLInputElement>(gdpr.checkbox);
    const button = findSubmitButton(consentElement);

    if (checkbox && button) {
      updateButtonState(checkbox, button);
    }
  });
};

/**
 * Handle checkbox change (delegated)
 */
const handleCheckboxChange = (event: Event): void => {
  const checkbox = event.target as HTMLInputElement;

  if (!checkbox.matches(gdpr.checkbox)) return;

  const consentElement = checkbox.closest<HTMLElement>(gdpr.consent);

  if (!consentElement) return;

  const button = findSubmitButton(consentElement);

  if (button) {
    updateButtonState(checkbox, button);
  }
};

/**
 * Handle submit for consent logging
 */
const handleSubmit = (consentElement: HTMLElement): void => {
  const checkbox = consentElement.querySelector<HTMLInputElement>(gdpr.checkbox);
  const data = getGdprData(consentElement);

  if (data && checkbox?.checked) {
    logConsent(data);
  }
};

/**
 * Handle click on custom submit button (delegated)
 */
const handleClick = (event: Event): void => {
  const target = event.target as HTMLElement;
  const button = target.closest<HTMLButtonElement>(gdpr.submitButton);

  if (!button) return;

  const wrapper = button.closest<HTMLElement>(gdpr.consentWrapper);
  const consentElement = wrapper?.querySelector<HTMLElement>(gdpr.consent);

  if (consentElement) {
    handleSubmit(consentElement);
  }
};

/**
 * Handle form submit (delegated)
 */
const handleFormSubmit = (event: Event): void => {
  const form = event.target as HTMLFormElement;

  if (!form.matches('form')) return;

  const consentElement = form.querySelector<HTMLElement>(gdpr.consent);

  if (consentElement) {
    handleSubmit(consentElement);
  }
};

/**
 * Initialize GDPR consent module
 */
const initGdpr = (): void => {
  // Set initial button states
  initButtonStates();

  // Event delegation for dynamic content support
  document.addEventListener('change', handleCheckboxChange);
  document.addEventListener('click', handleClick);
  document.addEventListener('submit', handleFormSubmit);

  // Re-initialize after PrestaShop AJAX updates
  const {prestashop} = window;

  if (prestashop) {
    prestashop.on('updatedProduct', initButtonStates);
    prestashop.on('updatedCart', initButtonStates);
  }
};

export default initGdpr;
