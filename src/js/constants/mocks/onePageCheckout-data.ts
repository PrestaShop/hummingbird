/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

export const FormWithRequiredFields = `
  <form class="one-page-checkout" method="POST">
    <input type="email" name="email" id="field-email" required>
    <input type="text" name="firstname" id="field-firstname" required>
    <input type="text" name="lastname" id="field-lastname" required>
    <select name="id_country" id="field-id_country" required>
      <option value="" disabled selected>-- please choose --</option>
      <option value="8">France</option>
    </select>

    <div class="form-check">
      <input class="form-check-input js-opc-use-same-address" type="checkbox" id="opc-use-same-address" name="use_same_address" value="1" checked>
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
  <form class="one-page-checkout" method="POST">
    <input type="text" name="phone" id="field-phone">
    <button type="submit" id="opc-pay-button" disabled>Pay</button>
  </form>
`;

export const FormEmpty = `
  <form class="one-page-checkout" method="POST">
    <button type="submit" id="opc-pay-button" disabled>Pay</button>
  </form>
`;
