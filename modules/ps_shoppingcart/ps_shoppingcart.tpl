{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<div id="_desktop_cart">
  <div class="header-block blockcart cart-preview {if $cart.products_count> 0}header-block--active{else}inactive{/if}" data-refresh-url="{$refresh_url}">
    {if $cart.products_count> 0}
      <a class="header-block__action-btn" rel="nofollow" href="{$cart_url}">
    {else}
      <span class="header-block__action-btn">
    {/if}

    {*
      OLD ICON
      <i class="material-icons header-block__icon" aria-hidden="true">shopping_cart</i>
    *}

    {renderThemeIcon
      iconName="cart"
      extraAttributes=[
        "aria-hidden" => "true",
        "class" => "header-block__icon"
      ]
    }

    {renderThemeIconSvg
      iconName="cart"
      extraAttributes=[
        "aria-hidden" => "true",
        "class" => "header-block__icon"
      ]
    }

    {renderThemeIconSvgExternal
      iconName="cart"
      extraAttributes=[
        "aria-hidden" => "true",
        "class" => "header-block__icon"
      ]
    }

    <span class="d-none d-md-flex header-block__title">{l s='Cart' d='Shop.Theme.Checkout'}</span>
    <span class="header-block__badge">{$cart.products_count}</span>

    {if $cart.products_count> 0}
      </a>
    {else}
      </span>
    {/if}
  </div>
</div>
