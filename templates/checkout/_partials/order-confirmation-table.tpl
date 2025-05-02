{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$componentName = 'order-confirmation'}

<div class="{$componentName}__table {block name='order-confirmation-classes'}{/block}">
  <div class="{$componentName}__products">
    {foreach from=$products item=product}
      <div class="{$componentName}__product">
        <div class="{$componentName}__product-image">
          {if !empty($product.default_image)}
            <picture>
              {if isset($product.default_image.bySize.default_xs.sources.avif)}
                <source 
                  srcset="
                    {$product.default_image.bySize.default_xs.sources.avif},
                    {$product.default_image.bySize.default_md.sources.avif} 2x"
                  type="image/avif"
                >
              {/if}

              {if isset($product.default_image.bySize.default_xs.sources.webp)}
                <source 
                  srcset="
                    {$product.default_image.bySize.default_xs.sources.webp},
                    {$product.default_image.bySize.default_md.sources.webp} 2x"
                  type="image/webp"
                >
              {/if}

              <img
                class="{$componentName}__product-img img-fluid"
                srcset="
                  {$product.default_image.bySize.default_xs.url},
                  {$product.default_image.bySize.default_md.url} 2x"
                loading="lazy"
                width="{$product.default_image.bySize.default_xs.width}"
                height="{$product.default_image.bySize.default_xs.height}"
                alt="{$product.default_image.legend}"
                title="{$product.default_image.legend}"
              >
            </picture>
          {else}
            <picture>
              {if isset($urls.no_picture_image.bySize.default_xs.sources.avif)}
                <source 
                  srcset="
                    {$urls.no_picture_image.bySize.default_xs.sources.avif},
                    {$urls.no_picture_image.bySize.default_md.sources.avif} 2x"
                  type="image/avif"
                >
              {/if}

              {if isset($urls.no_picture_image.bySize.default_xs.sources.webp)}
                <source 
                  srcset="
                    {$urls.no_picture_image.bySize.default_xs.sources.webp},
                    {$urls.no_picture_image.bySize.default_md.sources.webp} 2x"
                  type="image/webp"
                >
              {/if}

              <img
                class="{$componentName}__product-img img-fluid"
                srcset="
                  {$urls.no_picture_image.bySize.default_xs.url},
                  {$urls.no_picture_image.bySize.default_md.url} 2x"
                width="{$urls.no_picture_image.bySize.default_xs.width}"
                height="{$urls.no_picture_image.bySize.default_xs.height}"
                loading="lazy"
              >
            </picture>
          {/if}
        </div>

        <div class="{$componentName}__product-content">
          <div class="{$componentName}__product-details">
            {if $add_product_link}
              <a class="{$componentName}__product-link" href="{$product.url}" target="_blank">
            {/if}
              <p class="{$componentName}__product-title">{$product.name}</p>
            {if $add_product_link}
              </a>
            {/if}

            {if !empty($product.reference)}
              <p class="{$componentName}__product-reference">{l s='Reference:' d='Shop.Theme.Catalog'} {$product.reference}</p>
            {/if}

            {if is_array($product.customizations) && $product.customizations|count}
              {include file='catalog/_partials/product-customization-modal.tpl' product=$product}
            {/if}
            
            {hook h='displayProductPriceBlock' product=$product type="unit_price"}
          </div>
          
          <div class="{$componentName}__product-prices">
            <div class="{$componentName}__product-price">
              {l s='%product_price% (x%product_quantity%)' sprintf=['%product_price%' => $product.price, '%product_quantity%' => $product.quantity] d='Shop.Theme.Catalog'}
            </div>

            <div class="{$componentName}__product-total">
              {$product.total}
            </div>
          </div>
        </div>
      </div>
    {/foreach}
  </div>

  <hr>

  <div class="{$componentName}__subtotals">
    {foreach $subtotals as $subtotal}
      {if $subtotal !== null && $subtotal.type !== 'tax' && $subtotal.label !== null}
        <div class="{$componentName}__line">
          <div class="{$componentName}__line-label">{$subtotal.label}</div>
          <div class="{$componentName}__line-value">{if 'discount' == $subtotal.type}-&nbsp;{/if}{$subtotal.value}</div>
        </div>
      {/if}
    {/foreach}
  </div>

  <hr>

  <div class="{$componentName}__totals">
    {if !$configuration.display_prices_tax_incl && $configuration.taxes_enabled}
      <div class="{$componentName}__line {$componentName}__line--bold">
        <div class="{$componentName}__line-label">{$totals.total.label}&nbsp;{$labels.tax_short}</div>
        <div class="{$componentName}__line-value">{$totals.total.value}</div>
      </div>

      <div class="{$componentName}__line {$componentName}__line--bold">
        <div class="{$componentName}__line-label">{$totals.total_including_tax.label}</div>
        <div class="{$componentName}__line-value">{$totals.total_including_tax.value}</div>
      </div>
    {else}
      <div class="{$componentName}__line {$componentName}__line--bold">
        <div class="{$componentName}__line-label">{$totals.total.label}&nbsp;{if $configuration.taxes_enabled}{$labels.tax_short}{/if}</div>
        <div class="{$componentName}__line-value">{$totals.total.value}</div>
      </div>
    {/if}

    {if $subtotals.tax !== null && $subtotals.tax.label !== null}
      <div class="{$componentName}__line {$componentName}__line--bold">
        <div class="{$componentName}__line-label">{l s='%label%:' sprintf=['%label%' => $subtotals.tax.label] d='Shop.Theme.Global'}</div>
        <div class="{$componentName}__line-value">{$subtotals.tax.value}</div>
      </div>
    {/if}
  </div>
</div>
