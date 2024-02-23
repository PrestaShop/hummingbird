{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{block name='cart_detailed_product'}
  <div class="cart-overview js-cart"
    data-refresh-url="{url entity='cart' params=['ajax' => true, 'action' => 'refresh']}"
    tabindex="-1"
  >
    <hr />

    {if $cart.products}
      <ul class="cart__items">
        {foreach from=$cart.products item=product}
          <li class="cart__item">
            {block name='cart_detailed_product_line'}
              {include file='checkout/_partials/cart-detailed-product-line.tpl' product=$product}
            {/block}
            <hr />
          </li>

          {if is_array($product.customizations) && $product.customizations|count>1}
          <hr>{/if}
        {/foreach}
      </ul>
    {else}
      <p class="mb-3">{l s='There are no more items in your cart' d='Shop.Theme.Checkout'}</p>
    {/if}
  </div>
{/block}
