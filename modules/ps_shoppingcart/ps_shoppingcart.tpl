{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<div id="_desktop_cart">
  <div class="blockcart cart-preview {if $cart.products_count> 0}active{else}inactive{/if}" data-refresh-url="{$refresh_url}">
    {if $cart.products_count> 0}
      <a rel="nofollow" href="{$cart_url}">
    {/if}
      <i class="material-icons shopping-cart">shopping_cart</i>
      <span class="hidden-on-mobile">{l s='Cart' d='Shop.Theme.Checkout'}</span>
      <span class="cart-products-count">{$cart.products_count}</span>
    {if $cart.products_count> 0}
      </a>
    {/if}
  </div>
</div>
