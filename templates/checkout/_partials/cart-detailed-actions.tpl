{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{block name='cart_detailed_actions'}
    {$disableCheckout = false}
    {foreach $cart.products as $product}
        {if isset($product.availability) && $product.availability == 'unavailable' }
            {$disableCheckout = true}
        {/if}
    {/foreach}
  <div class="checkout cart-detailed__actions js-cart-detailed-actions card-footer">
    {if $cart.minimalPurchaseRequired}
      <div class="alert alert-warning" role="alert">
        {$cart.minimalPurchaseRequired}
      </div>

      <div class="text-sm-center d-grid">
        <button type="button" class="btn btn-primary disabled" disabled>{l s='Proceed to checkout' d='Shop.Theme.Actions'}</button>
      </div>
    {elseif empty($cart.products) || $disableCheckout === true}
      <div class="text-sm-center d-grid">
        <button type="button" class="btn btn-primary disabled" disabled>{l s='Proceed to checkout' d='Shop.Theme.Actions'}</button>
      </div>
    {else}
      <div class="text-sm-center">
        <a href="{$urls.pages.order}" class="btn btn-primary">{l s='Proceed to checkout' d='Shop.Theme.Actions'}</a>

        {hook h='displayExpressCheckout'}
      </div>
    {/if}
  </div>
{/block}
