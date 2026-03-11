/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

/**
 * One Page Checkout — theme entry point
 *
 * The core (opc-form.js, opc-carrier-list.js, opc-carrier-select.js) owns
 * the full OPC lifecycle:
 *   - Form validation and pay button gating
 *   - Billing section toggle
 *   - Carrier list fetch, loader and error states
 *   - Cart summary and pay button amount update
 *
 * Add theme-specific behaviour here only — the core handles everything else.
 */
const initOnePageCheckout = (): void => {
  // Theme-specific OPC behaviour goes here.
};

export default initOnePageCheckout;
