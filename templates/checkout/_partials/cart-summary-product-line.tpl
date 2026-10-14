{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
{$imageTypes = ['default_xs' => '1x', 'default_sm' => '2x']}

{$componentName = 'cart-summary-product'}

{block name='cart_summary_product_line'}
  <div class="{$componentName}">
    <div class="{$componentName}__image">
      <a href="{$product.url}" title="{$product.name}">
        {if $product.default_image}
          {$srcset = $product.default_image|srcset:$imageTypes}
          <picture>
            {include file='_partials/picture-sources.tpl' srcset=$srcset}

            <img
              class="{$componentName}__img img-fluid"
              {if $srcset.url}
                srcset="{$srcset.url}"
              {/if}
              width="{$product.default_image.bySize.default_xs.width}"
              height="{$product.default_image.bySize.default_xs.height}"
              loading="lazy"
              alt="{$product.name}"
              title="{$product.name}"
            >
          </picture>
        {else}
          {$srcset = $urls.no_picture_image|srcset:$imageTypes}
          <picture>
            {include file='_partials/picture-sources.tpl' srcset=$srcset}

            <img
              class="{$componentName}__img img-fluid"
              {if $srcset.url}
                srcset="{$srcset.url}"
              {/if}
              width="{$urls.no_picture_image.bySize.default_xs.width}"
              height="{$urls.no_picture_image.bySize.default_xs.height}"
              loading="lazy"
            >
          </picture>
        {/if}
      </a>
    </div>

    <div class="{$componentName}__content">
      <div class="{$componentName}__content-left">
        <a class="{$componentName}__link" href="{$product.url}" target="_blank" rel="noopener noreferrer nofollow">
          {$product.name}
        </a>
        
        {if !empty($product.attributes)}
          <div class="{$componentName}__attributes">
            {foreach from=$product.attributes key="attribute" item="value"}
              <div class="{$componentName}__attribute">
                <span class="label">{$attribute}:</span>
                <span class="value">{$value}</span>
              </div>
            {/foreach}
          </div>
        {/if}

        <div class="{$componentName}__price">
          <span class="label">{$product.price}</span>
          {if $product.has_discount}
            <span class="value">{$product.regular_price}</span>
          {/if}
        </div>

        {if $product.unit_price_full}
          <div class="{$componentName}__unit-price">
            <span class="value">{$product.unit_price_full}</span>
          </div>
        {/if}

        <div class="{$componentName}__quantity">
          <span class="label">{l s='Quantity:' d='Shop.Theme.Checkout'}</span>
          <span class="value">x{$product.quantity}</span>
        </div>

        <div class="{$componentName}__gift">
          {if !empty($product.is_gift)}
            <i class="{$componentName}__gift-icon material-icons" aria-hidden="true">&#xE8B1;</i> {l s='Gift(s)' d='Shop.Theme.Checkout'}
          {/if}
        </div>
      </div>

      <div class="{$componentName}__content-right">
        <div class="{$componentName}__prices">
          <div class="{$componentName}__total">{$product.total}</div>

          {hook h='displayProductPriceBlock' product=$product type="unit_price"}
        </div>
      </div>
    </div>
  </div>
{/block}
