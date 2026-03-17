/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
import initEmitter from '@js/prestashop';
import initOnePageCheckout from '@js/pages/one-page-checkout';

const SUMMARY_SELECTOR = '#cart-summary';
const COLLAPSE_ID = 'cart-summary-product-list';

const buildSummaryHTML = (open: boolean): string => `
  <div id="cart-summary">
    <button data-bs-target="#${COLLAPSE_ID}" aria-expanded="${open ? 'true' : 'false'}" class="${open ? '' : 'collapsed'}">
      Show details
    </button>
    <div id="${COLLAPSE_ID}" class="accordion-collapse${open ? ' show' : ''}"></div>
  </div>
`;

describe('One Page Checkout — accordion state preservation', () => {
  beforeAll(() => {
    window.prestashop = {};
    initEmitter();
    window.prestashop.selectors = {
      checkout: {summarySelector: SUMMARY_SELECTOR},
    };
    initOnePageCheckout();
  });

  it('restores open accordion after cart summary DOM replacement', () => {
    document.body.innerHTML = buildSummaryHTML(true);

    window.prestashop.emit('opcCartSummaryBeforeUpdate', {selector: SUMMARY_SELECTOR});

    // Replace the DOM as updateCartSummary would
    document.body.innerHTML = buildSummaryHTML(false);

    window.prestashop.emit('opcCartSummaryUpdated', {selector: SUMMARY_SELECTOR});

    const collapse = document.getElementById(COLLAPSE_ID)!;
    const btn = document.querySelector(`[data-bs-target="#${COLLAPSE_ID}"]`)!;

    expect(collapse.classList.contains('show')).toBe(true);
    expect(btn.classList.contains('collapsed')).toBe(false);
    expect(btn.getAttribute('aria-expanded')).toBe('true');
  });

  it('does not restore closed accordion after DOM replacement', () => {
    document.body.innerHTML = buildSummaryHTML(false);

    window.prestashop.emit('opcCartSummaryBeforeUpdate', {selector: SUMMARY_SELECTOR});
    document.body.innerHTML = buildSummaryHTML(false);
    window.prestashop.emit('opcCartSummaryUpdated', {selector: SUMMARY_SELECTOR});

    const collapse = document.getElementById(COLLAPSE_ID)!;

    expect(collapse.classList.contains('show')).toBe(false);
  });
});
