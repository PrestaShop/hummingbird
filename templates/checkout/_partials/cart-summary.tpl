{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{* .js-cart needed for JS *}
<section id="js-checkout-summary" class="accordion-collapse collapse show js-cart" data-refresh-url="{$urls.pages.cart}?ajax=1&action=refresh">
  {block name='hook_checkout_summary_top'}
    {include file='checkout/_partials/cart-summary-top.tpl' cart=$cart}
  {/block}

  {block name='cart_summary_products'}
    {include file='checkout/_partials/cart-summary-products.tpl' cart=$cart}
  {/block}

  {block name='cart_summary_subtotals'}
    {include file='checkout/_partials/cart-summary-subtotals.tpl' cart=$cart}
  {/block}

  {block name='cart_summary_totals'}
    {include file='checkout/_partials/cart-summary-totals.tpl' cart=$cart}
  {/block}

  {block name='cart_summary_voucher'}
    {include file='checkout/_partials/cart-voucher.tpl'}
  {/block}
</section>
