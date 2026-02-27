/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
import {onePageCheckout as OpcMap} from '@constants/selectors-map';

let billingToggleHandler: ((e: Event) => void) | null = null;

const initOnePageCheckout = () => {
  const form = document.querySelector<HTMLFormElement>(OpcMap.form);

  if (!form) {
    return;
  }

  // Delegated listeners on the form (added once, survives DOM refreshes)
  form.addEventListener('input', () => validateForm());
  form.addEventListener('change', () => validateForm());

  initBillingToggle();
  validateForm();

  const {prestashop} = window;

  // Re-init after any address form refresh (country change or other)
  prestashop.on('updatedOpcAddressForm', () => {
    initBillingToggle();
    validateForm();
  });
};

/**
 * Toggle billing address section visibility
 */
const initBillingToggle = () => {
  const checkbox = document.querySelector<HTMLInputElement>(OpcMap.useSameAddress);
  const billingSection = document.querySelector<HTMLElement>(OpcMap.billingSection);

  if (!checkbox || !billingSection) {
    return;
  }

  // Remove previous handler to avoid duplicates after DOM refresh
  if (billingToggleHandler) {
    checkbox.removeEventListener('change', billingToggleHandler);
  }

  billingToggleHandler = () => {
    billingSection.style.display = checkbox.checked ? 'none' : '';
    validateForm();
  };

  checkbox.addEventListener('change', billingToggleHandler);
};

/**
 * Check all visible required fields and toggle pay button
 */
const validateForm = () => {
  const form = document.querySelector<HTMLFormElement>(OpcMap.form);
  const payButton = document.querySelector<HTMLButtonElement>(OpcMap.payButton);

  if (!form || !payButton) {
    return;
  }

  const requiredFields = form.querySelectorAll<HTMLInputElement | HTMLSelectElement | HTMLTextAreaElement>(
    '[required]',
  );

  let isValid = true;

  requiredFields.forEach((field) => {
    // Skip fields inside hidden billing section
    const billingSection = field.closest(OpcMap.billingSection) as HTMLElement | null;

    if (billingSection?.style.display === 'none') {
      return;
    }

    const isCheckbox = field instanceof HTMLInputElement && field.type === 'checkbox';
    const fieldIsValid = isCheckbox ? field.checked : Boolean(field.value?.trim());

    if (!fieldIsValid) {
      isValid = false;
    }
  });

  payButton.disabled = !isValid;
};

export default initOnePageCheckout;
