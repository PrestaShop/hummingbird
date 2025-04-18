{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{block name='cart_detailed_product'}
  {* cart-overview needed for JS *}
  <div class="cart__overview cart-overview js-cart"
    data-refresh-url="{url entity='cart' params=['ajax' => true, 'action' => 'refresh']}"
    tabindex="-1"
  >
    <hr>

    {if $cart.products}
      <div class="cart__list">
        {foreach from=$cart.products item=product}
          <div class="cart__item">
            {block name='cart_detailed_product_line'}
              {include file='checkout/_partials/cart-detailed-product-line.tpl' product=$product}
            {/block}
          </div>
        {/foreach}
      </div>
    {else}
      <p class="cart__empty">{l s='There are no more items in your cart' d='Shop.Theme.Checkout'}</p>
    {/if}

    <hr>
  </div>
{/block}
