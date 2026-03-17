/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

export const FormWithRequiredFields = `
  <form id="opc-form" class="one-page-checkout" method="POST">
    <input type="email" name="email" id="field-email" required>
    <input type="text" name="firstname" id="field-firstname" required>
    <input type="text" name="lastname" id="field-lastname" required>
    <select name="id_country" id="field-id_country" required>
      <option value="" disabled selected>-- please choose --</option>
      <option value="8">France</option>
    </select>

    <div class="form-check">
      <input class="form-check-input" type="checkbox" id="opc-use-same-address" name="use_same_address" value="1" checked>
    </div>

    <section id="opc-billing-section" style="display: none;">
      <input type="text" name="invoice_firstname" id="field-invoice_firstname" required>
      <input type="text" name="invoice_lastname" id="field-invoice_lastname" required>
    </section>

    <div class="form-check">
      <input type="checkbox" name="conditions_to_approve[terms-and-conditions]" id="conditions" required class="form-check-input">
    </div>

    <button type="submit" id="opc-pay-button" disabled>Pay</button>
  </form>
`;

export const FormWithoutRequiredFields = `
  <form id="opc-form" class="one-page-checkout" method="POST">
    <input type="text" name="phone" id="field-phone">
    <button type="submit" id="opc-pay-button" disabled>Pay</button>
  </form>
`;

export const FormEmpty = `
  <form id="opc-form" class="one-page-checkout" method="POST">
    <button type="submit" id="opc-pay-button" disabled>Pay</button>
  </form>
`;

export const FormWithCarriersContainer = `
  <form id="opc-form" class="one-page-checkout" method="POST" action="/order">
    <select name="id_country" id="field-id_country">
      <option value="" disabled selected>-- choose --</option>
      <option value="8">France</option>
    </select>
    <input type="text" name="postcode" id="field-postcode">
    <input type="text" name="city" id="field-city">
    <div id="opc-delivery-methods">
      <div class="card card-body bg-light">Enter your address to see carriers.</div>
    </div>
    <button type="submit" id="opc-pay-button" disabled>Pay</button>
  </form>
`;

export const mockCarriersResponse = {
  // eslint-disable-next-line max-len
  carriers_html: '<div class="delivery-options__list"><input type="radio" name="delivery_option" value="1,">Colissimo<input type="radio" name="delivery_option" value="2,">Chronopost</div>',
  delivery_options: {
    '1,': {
      id: 1,
      name: 'Colissimo',
      delay: '2-3 days',
      price: '€5.00',
      logo: null,
    },
    '2,': {
      id: 2,
      name: 'Chronopost',
      delay: '1 day',
      price: '€10.00',
      logo: null,
    },
  },
  selected_delivery_option: '1,',
  carrier_was_reset: false,
};

export const mockEmptyCarriersResponse = {
  carriers_html: '<p class="alert alert-warning mb-0">Unfortunately, there are no carriers available.</p>',
  delivery_options: {},
  selected_delivery_option: null,
  carrier_was_reset: false,
};
