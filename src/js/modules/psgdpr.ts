/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import {gdpr} from '@constants/selectors-map';
import parseData from '@helpers/parseData';

// Types and validators
interface GdprData {
  moduleId: string;
  frontController: string;
  idCustomer: string;
  customerToken: string;
  idGuest: string;
  guestToken: string;
}

const gdprDataValidator: Validator<GdprData> = (data): data is GdprData => (
  typeof data === 'object'
    && data !== null
    && typeof (data as GdprData).moduleId === 'string'
    && typeof (data as GdprData).frontController === 'string'
    && typeof (data as GdprData).idCustomer === 'string'
    && typeof (data as GdprData).customerToken === 'string'
    && typeof (data as GdprData).idGuest === 'string'
    && typeof (data as GdprData).guestToken === 'string'
);

/**
 * Get GDPR data from element and clean up URL encoding
 */
const getGdprData = (element: HTMLElement): GdprData | null => {
  const result = parseData<GdprData>(element, gdprDataValidator);

  if (!result) {
    return null;
  }

  // Clean up frontController URL encoding
  if (result.frontController) {
    result.frontController = result.frontController.replace(/&amp;/g, '&');
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
  const formData = new URLSearchParams({
    ajax: 'true',
    action: 'AddLog',
    id_customer: data.idCustomer,
    customer_token: data.customerToken,
    id_guest: data.idGuest,
    guest_token: data.guestToken,
    id_module: data.moduleId,
  });

  try {
    await fetch(data.frontController, {
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
