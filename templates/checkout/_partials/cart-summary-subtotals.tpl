{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<div class="card-block cart-summary__subtotals__container js-cart-summary-subtotals-container">
  {foreach from=$cart.subtotals item="subtotal"}
    {if $subtotal && $subtotal.value|count_characters> 0 && $subtotal.type !== 'tax'}
      <div class="cart-summary__line cart-summary__subtotals" id="cart-subtotal-{$subtotal.type}">
        <span class="cart-summary__label">
            {$subtotal.label}
        </span>

        <span class="cart-summary__value">
          {if 'discount' == $subtotal.type}-&nbsp;{/if}{$subtotal.value}
        </span>
      </div>
    {/if}
  {/foreach}
</div>
