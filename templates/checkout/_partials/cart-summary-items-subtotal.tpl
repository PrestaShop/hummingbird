{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{block name='cart_summary_items_subtotal'}
  <div class="card-block cart-summary-line cart-summary-items-subtotal " id="items-subtotal">
    <span class="label">{$cart.summary_string}</span>
    <span class="value">{$cart.subtotals.products.amount}</span>
  </div>
{/block}
