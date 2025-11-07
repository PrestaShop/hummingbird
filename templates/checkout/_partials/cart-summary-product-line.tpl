{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$componentName = 'cart-summary-product'}

{block name='cart_summary_product_line'}
  <div class="{$componentName}">
    <div class="{$componentName}__image">
      <a href="{$product.url}" title="{$product.name}">
        {if $product.default_image}
          <picture>
            {if isset($product.default_image.bySize.default_xs.sources.avif)}
              <source 
                srcset="
                  {$product.default_image.bySize.default_xs.sources.avif},
                  {$product.default_image.bySize.default_sm.sources.avif} 2x"
                type="image/avif"
              >
            {/if}

            {if isset($product.default_image.bySize.default_xs.sources.webp)}
              <source 
                srcset="
                  {$product.default_image.bySize.default_xs.sources.webp},
                  {$product.default_image.bySize.default_sm.sources.webp} 2x"
                type="image/webp"
              >
            {/if}

            <img
              class="{$componentName}__img img-fluid"
              srcset="
                {$product.default_image.bySize.default_xs.url},
                {$product.default_image.bySize.default_sm.url} 2x"
              width="{$product.default_image.bySize.default_xs.width}"
              height="{$product.default_image.bySize.default_xs.height}"
              loading="lazy"
              alt="{$product.name}"
              title="{$product.name}"
            >
          </picture>
        {else}
          <picture>
            {if isset($urls.no_picture_image.bySize.default_xs.sources.avif)}
              <source 
                srcset="
                  {$urls.no_picture_image.bySize.default_xs.sources.avif},
                  {$urls.no_picture_image.bySize.default_sm.sources.avif} 2x"
                type="image/avif"
              >
            {/if}

            {if isset($urls.no_picture_image.bySize.default_xs.sources.webp)}
              <source 
                srcset="
                  {$urls.no_picture_image.bySize.default_xs.sources.webp},
                  {$urls.no_picture_image.bySize.default_sm.sources.webp} 2x"
                type="image/webp"
              >
            {/if}

            <img
              class="{$componentName}__img img-fluid"
              srcset="
                {$urls.no_picture_image.bySize.default_xs.url},
                {$urls.no_picture_image.bySize.default_sm.url} 2x"
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

        <div class="{$componentName}__quantity">
          <span class="label">{l s='Quantity:' d='Shop.Theme.Checkout'}</span>
          <span class="value">x{$product.quantity}</span>
        </div>
      </div>

      <div class="{$componentName}__content-right">
        <div class="{$componentName}__prices">
          <div class="{$componentName}__price">{$product.total}</div>

          {if $product.unit_price_full}
            <div class="{$componentName}__unit-price">{$product.unit_price_full}</div>
          {/if}

          {if $product.has_discount}
            <div class="{$componentName}__regular-price">{$product.regular_price}</div>
          {/if}

          {hook h='displayProductPriceBlock' product=$product type="unit_price"}
        </div>
      </div>
    </div>
  </div>
{/block}
