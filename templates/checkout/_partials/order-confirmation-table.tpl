{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
{$imageTypes = ['default_xs' => '1x', 'default_md' => '2x']}

{$componentName = 'order-confirmation'}

<div class="{$componentName}__table {block name='order-confirmation-classes'}{/block}">
  <div class="{$componentName}__products">
    {foreach from=$products item=product}
      <div class="{$componentName}__product">
        <div class="{$componentName}__product-image">
          {if !empty($product.default_image)}
            {$srcset = $product.default_image|srcset:$imageTypes}
            <picture>
              {include file='_partials/picture-sources.tpl' srcset=$srcset}

              <img
                class="{$componentName}__product-img img-fluid"
                {if $srcset.url}
                  srcset="{$srcset.url}"
                {/if}
                {if $srcset.src}
                  src="{$srcset.src}"
                  width="{$srcset.width}"
                  height="{$srcset.height}"
                {/if}
                loading="lazy"
                alt="{$product.default_image.legend}"
                title="{$product.default_image.legend}"
              >
            </picture>
          {else}
            {$srcset = $urls.no_picture_image|srcset:$imageTypes}
            <picture>
              {include file='_partials/picture-sources.tpl' srcset=$srcset}

              <img
                class="{$componentName}__product-img img-fluid"
                {if $srcset.url}
                  srcset="{$srcset.url}"
                {/if}
                {if $srcset.src}
                  src="{$srcset.src}"
                  width="{$srcset.width}"
                  height="{$srcset.height}"
                {/if}
                loading="lazy"
              >
            </picture>
          {/if}

          {if !empty($product.quantity) && $product.quantity > 1}
            <p class="{$componentName}__product-quantity">{l s='x%quantity%' sprintf=['%quantity%' => $product.quantity] d='Shop.Theme.Global'}</p>
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

            {if !empty($product.attributes)}
              <div class="{$componentName}__product-attributes">
                {foreach from=$product.attributes key="attribute" item="value"}
                  <div class="{$componentName}__product-attribute">
                    <span class="label">{$attribute}:</span>
                    <span class="value">{$value}</span>
                  </div>
                {/foreach}
              </div>
            {/if}

            {if !empty($product.reference)}
              <p class="{$componentName}__product-reference">{l s='Reference:' d='Shop.Theme.Catalog'} {$product.reference}</p>
            {/if}

            {if $product.price}
              <div class="{$componentName}__product-price">
                {$product.price}
              </div>
            {/if}

            {if is_array($product.customizations) && $product.customizations|count}
              {include file='catalog/_partials/product-customization-modal.tpl' product=$product}
            {/if}
            
            {hook h='displayProductPriceBlock' product=$product type="unit_price"}
          </div>
          
          <div class="{$componentName}__product-prices">
            {if !empty($product.is_gift)}
              <div class="{$componentName}__product-gift">
                <i class="{$componentName}__product-gift-icon material-icons" aria-hidden="true">&#xE8B1;</i>{$product.quantity} {l s='Gift(s)' d='Shop.Theme.Checkout'}
              </div>
            {else}
              <div class="{$componentName}__product-total">
                {$product.total}
              </div>
            {/if}
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
