{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<div class="card-block cart-summary__totals">
  {block name='cart_summary_total'}
    {if !$configuration.display_prices_tax_incl && $configuration.taxes_enabled}
      <div class="cart-summary__line">
        <span class="cart-summary__label">{$cart.totals.total.label}&nbsp;{$cart.labels.tax_short}</span>
        <span class="cart-summary__value">{$cart.totals.total.value}</span>
      </div>

      <div class="cart-summary__line cart-total">
        <span class="cart-summary__label">{$cart.totals.total_including_tax.label}</span>
        <span class="cart-summary__value">{$cart.totals.total_including_tax.value}</span>
      </div>
    {else}
      <div class="cart-summary__line cart-total">
        <span class="cart-summary__label">{$cart.totals.total.label}&nbsp;{if $configuration.taxes_enabled}{$cart.labels.tax_short}{/if}</span>
        <span class="cart-summary__value">{$cart.totals.total.value}</span>
      </div>
    {/if}
  {/block}

  {block name='cart_summary_tax'}
    {if $cart.subtotals.tax}
      <div class="cart-summary__line">
        <span class="cart-summary__label cart-summary__label--sub">{l s='%label%:' sprintf=['%label%' => $cart.subtotals.tax.label] d='Shop.Theme.Global'}</span>
        <span class="cart-summary__value cart-summary__label--sub">{$cart.subtotals.tax.value}</span>
      </div>
    {/if}
  {/block}
</div>
