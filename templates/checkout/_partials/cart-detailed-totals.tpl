{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{block name='cart_detailed_totals'}
  <div class="cart-detailed__totals card-block js-cart-detailed-totals">
    <div class="cart-detailed__subtotals js-cart-detailed-subtotals">
      {foreach from=$cart.subtotals item="subtotal"}
        {if $subtotal && $subtotal.value|count_characters> 0 && $subtotal.type !== 'tax'}
          <div class="cart-summary__line" id="cart-subtotal-{$subtotal.type}">
            <span class="cart-summary__label{if 'products' === $subtotal.type} js-subtotal{/if}">
              {if 'products' == $subtotal.type}
                {$cart.summary_string}
              {else}
                {$subtotal.label}
              {/if}
            </span>

            <div class="cart-summary__line__value">
              <span class="cart-summary__value">
                {if 'discount' == $subtotal.type}-&nbsp;{/if}{$subtotal.value}
              </span>

              {if $subtotal.type === 'shipping'}
                <div><small class="value">{hook h='displayCheckoutSubtotalDetails' subtotal=$subtotal}</small></div>
              {/if}
            </div>
          </div>
        {/if}
      {/foreach}
    </div>

    {block name='cart_summary_totals'}
      {include file='checkout/_partials/cart-summary-totals.tpl' cart=$cart}
    {/block}

    {block name='cart_voucher'}
      {include file='checkout/_partials/cart-voucher.tpl'}
    {/block}
  </div>
{/block}
