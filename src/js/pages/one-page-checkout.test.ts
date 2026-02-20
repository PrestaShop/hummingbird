/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
import initEmitter from '@js/prestashop';
import resetHTMLBodyContent from '@helpers/resetBody';
import {FormWithRequiredFields, FormWithoutRequiredFields, FormEmpty} from '@constants/mocks/onePageCheckout-data';
import initOnePageCheckout from '@js/pages/one-page-checkout';

const getPayButton = (): HTMLButtonElement =>
  document.querySelector<HTMLButtonElement>('#opc-pay-button')!;

const getBillingSection = (): HTMLElement =>
  document.querySelector<HTMLElement>('#opc-billing-section')!;

const fillField = (selector: string, value: string) => {
  const field = document.querySelector<HTMLInputElement | HTMLSelectElement>(selector)!;
  field.value = value;
  field.dispatchEvent(new Event('input', {bubbles: true}));
};

const toggleCheckbox = (selector: string, checked: boolean) => {
  const cb = document.querySelector<HTMLInputElement>(selector)!;
  cb.checked = checked;
  cb.dispatchEvent(new Event('change', {bubbles: true}));
};

describe('One Page Checkout', () => {
  beforeAll(() => {
    window.prestashop = {} as any;
    initEmitter();
  });

  afterEach(() => {
    window.prestashop.removeAllListeners('updatedOpcAddressForm');
  });

  describe('validateForm', () => {
    describe('with required fields', () => {
      beforeEach(() => {
        resetHTMLBodyContent(FormWithRequiredFields);
        initOnePageCheckout();
      });

      it('should disable pay button when required fields are empty', () => {
        expect(getPayButton().disabled).toBe(true);
      });

      it('should enable pay button when all visible required fields are filled', () => {
        fillField('#field-email', 'test@example.com');
        fillField('#field-firstname', 'John');
        fillField('#field-lastname', 'Doe');
        fillField('#field-id_country', '8');
        toggleCheckbox('#conditions', true);

        expect(getPayButton().disabled).toBe(false);
      });

      it('should disable pay button when one required field is empty', () => {
        fillField('#field-email', 'test@example.com');
        fillField('#field-firstname', 'John');
        // lastname left empty
        fillField('#field-id_country', '8');
        toggleCheckbox('#conditions', true);

        expect(getPayButton().disabled).toBe(true);
      });

      it('should disable pay button when terms checkbox is unchecked', () => {
        fillField('#field-email', 'test@example.com');
        fillField('#field-firstname', 'John');
        fillField('#field-lastname', 'Doe');
        fillField('#field-id_country', '8');
        // conditions left unchecked

        expect(getPayButton().disabled).toBe(true);
      });

      it('should ignore required fields inside hidden billing section', () => {
        // billing section is hidden by default, so invoice_firstname/invoice_lastname are skipped
        fillField('#field-email', 'test@example.com');
        fillField('#field-firstname', 'John');
        fillField('#field-lastname', 'Doe');
        fillField('#field-id_country', '8');
        toggleCheckbox('#conditions', true);

        expect(getPayButton().disabled).toBe(false);
      });

      it('should require billing fields when billing section is visible', () => {
        // Uncheck "use same address" to show billing section
        toggleCheckbox('.js-opc-use-same-address', false);

        fillField('#field-email', 'test@example.com');
        fillField('#field-firstname', 'John');
        fillField('#field-lastname', 'Doe');
        fillField('#field-id_country', '8');
        toggleCheckbox('#conditions', true);
        // invoice fields left empty

        expect(getPayButton().disabled).toBe(true);
      });

      it('should enable pay button when billing fields are also filled', () => {
        toggleCheckbox('.js-opc-use-same-address', false);

        fillField('#field-email', 'test@example.com');
        fillField('#field-firstname', 'John');
        fillField('#field-lastname', 'Doe');
        fillField('#field-id_country', '8');
        fillField('#field-invoice_firstname', 'Jane');
        fillField('#field-invoice_lastname', 'Doe');
        toggleCheckbox('#conditions', true);

        expect(getPayButton().disabled).toBe(false);
      });
    });

    describe('without required fields', () => {
      beforeEach(() => {
        resetHTMLBodyContent(FormWithoutRequiredFields);
        initOnePageCheckout();
      });

      it('should enable pay button when there are no required fields', () => {
        expect(getPayButton().disabled).toBe(false);
      });
    });

    describe('empty form', () => {
      beforeEach(() => {
        resetHTMLBodyContent(FormEmpty);
        initOnePageCheckout();
      });

      it('should enable pay button when form has no fields at all', () => {
        expect(getPayButton().disabled).toBe(false);
      });
    });
  });

  describe('initBillingToggle', () => {
    beforeEach(() => {
      resetHTMLBodyContent(FormWithRequiredFields);
      initOnePageCheckout();
    });

    it('should hide billing section when checkbox is checked', () => {
      expect(getBillingSection().style.display).toBe('none');
    });

    it('should show billing section when checkbox is unchecked', () => {
      toggleCheckbox('.js-opc-use-same-address', false);
      expect(getBillingSection().style.display).toBe('');
    });

    it('should hide billing section again when checkbox is re-checked', () => {
      toggleCheckbox('.js-opc-use-same-address', false);
      toggleCheckbox('.js-opc-use-same-address', true);
      expect(getBillingSection().style.display).toBe('none');
    });

    it('should re-validate form after toggling billing section', () => {
      // Fill all delivery fields + terms
      fillField('#field-email', 'test@example.com');
      fillField('#field-firstname', 'John');
      fillField('#field-lastname', 'Doe');
      fillField('#field-id_country', '8');
      toggleCheckbox('#conditions', true);

      expect(getPayButton().disabled).toBe(false);

      // Show billing section -> billing fields are empty -> should disable
      toggleCheckbox('.js-opc-use-same-address', false);
      expect(getPayButton().disabled).toBe(true);

      // Hide billing section again -> should re-enable
      toggleCheckbox('.js-opc-use-same-address', true);
      expect(getPayButton().disabled).toBe(false);
    });
  });
});
