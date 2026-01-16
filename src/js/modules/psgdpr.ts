/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import {gdpr} from '@constants/selectors-map';

// Types
interface GdprConfig {
  frontController: string;
  idCustomer: string;
  customerToken: string;
  idGuest: string;
  guestToken: string;
}

/**
 * Get GDPR configuration from the consent element
 */
const getConfig = (consentElement: HTMLElement): GdprConfig | null => {
  const {
    frontController,
    idCustomer,
    customerToken,
    idGuest,
    guestToken,
  } = consentElement.dataset;

  if (!frontController) return null;

  return {
    frontController: frontController.replace(/&amp;/g, '&'),
    idCustomer: idCustomer ?? '',
    customerToken: customerToken ?? '',
    idGuest: idGuest ?? '',
    guestToken: guestToken ?? '',
  };
};

/**
 * Find the submit button for a consent element
 */
const findSubmitButton = (consentElement: HTMLElement): HTMLButtonElement | null => {
  // First, try to find a custom wrapper
  const customWrapper = consentElement.closest<HTMLElement>(gdpr.consentWrapper);

  if (customWrapper) {
    return customWrapper.querySelector<HTMLButtonElement>(gdpr.submitButton)
      ?? customWrapper.querySelector<HTMLButtonElement>('[type="submit"]');
  }

  // Fall back to form
  const form = consentElement.closest<HTMLFormElement>('form');

  if (form) {
    return form.querySelector<HTMLButtonElement>('[type="submit"]');
  }

  return null;
};

/**
 * Toggle the submit button state based on checkbox
 */
const toggleSubmitButton = (checkbox: HTMLInputElement, submitButton: HTMLButtonElement): void => {
  submitButton.disabled = !checkbox.checked;
};

/**
 * Log consent to the GDPR module
 */
const logConsent = async (config: GdprConfig, moduleId: string): Promise<void> => {
  const formData = new URLSearchParams({
    ajax: 'true',
    action: 'AddLog',
    id_customer: config.idCustomer,
    customer_token: config.customerToken,
    id_guest: config.idGuest,
    guest_token: config.guestToken,
    id_module: moduleId,
  });

  try {
    await fetch(config.frontController, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: formData.toString(),
    });
  } catch (error) {
    console.error('GDPR consent log error:', error);
  }
};

/**
 * Handle checkbox change event (delegated)
 */
const handleCheckboxChange = (event: Event): void => {
  const checkbox = event.target as HTMLInputElement;

  // Check if the changed element is a GDPR checkbox
  if (!checkbox.matches(gdpr.checkbox)) return;

  const consentElement = checkbox.closest<HTMLElement>(gdpr.consent);

  if (!consentElement) return;

  const submitButton = findSubmitButton(consentElement);

  if (submitButton) {
    toggleSubmitButton(checkbox, submitButton);
  }
};

/**
 * Handle submit button click for consent logging (delegated)
 */
const handleSubmitClick = (event: Event): void => {
  const target = event.target as HTMLElement;
  const submitButton = target.closest<HTMLButtonElement>(gdpr.submitButton);

  if (!submitButton) return;

  // Find the associated consent element within the wrapper
  const wrapper = submitButton.closest<HTMLElement>(gdpr.consentWrapper);

  if (!wrapper) return;

  const consentElement = wrapper.querySelector<HTMLElement>(gdpr.consent);

  if (!consentElement) return;

  const {moduleId} = consentElement.dataset;
  const checkbox = consentElement.querySelector<HTMLInputElement>(gdpr.checkbox);
  const config = getConfig(consentElement);

  if (config && moduleId && checkbox?.checked) {
    logConsent(config, moduleId);
  }
};

/**
 * Handle form submit for consent logging (delegated)
 */
const handleFormSubmit = (event: Event): void => {
  const form = event.target as HTMLFormElement;

  if (!form.matches('form')) return;

  const consentElement = form.querySelector<HTMLElement>(gdpr.consent);

  if (!consentElement) return;

  const {moduleId} = consentElement.dataset;
  const checkbox = consentElement.querySelector<HTMLInputElement>(gdpr.checkbox);
  const config = getConfig(consentElement);

  if (config && moduleId && checkbox?.checked) {
    logConsent(config, moduleId);
  }
};

/**
 * Disable submit buttons for unchecked GDPR consents
 */
const initSubmitButtonsState = (): void => {
  const consentElements = document.querySelectorAll<HTMLElement>(gdpr.consent);

  consentElements.forEach((consentElement) => {
    const checkbox = consentElement.querySelector<HTMLInputElement>(gdpr.checkbox);
    const submitButton = findSubmitButton(consentElement);

    if (checkbox && submitButton) {
      toggleSubmitButton(checkbox, submitButton);
    }
  });
};

/**
 * Initialize GDPR consent module with event delegation
 */
const initGdpr = (): void => {
  // Set initial state for all submit buttons
  initSubmitButtonsState();

  // Use event delegation for checkbox changes - works with dynamically added content
  document.addEventListener('change', handleCheckboxChange);

  // Use event delegation for submit button clicks (custom wrappers)
  document.addEventListener('click', handleSubmitClick);

  // Use event delegation for form submits
  document.addEventListener('submit', handleFormSubmit);

  // Re-initialize after PrestaShop AJAX updates
  const {prestashop} = window;

  if (prestashop) {
    prestashop.on('updatedProduct', initSubmitButtonsState);
    prestashop.on('updatedCart', initSubmitButtonsState);
  }
};

export default initGdpr;
