{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$componentName = 'order-confirmation'}

<div class="{$componentName}__table {block name='order-confirmation-classes'}{/block}">
  <div class="{$componentName}__products">
    {foreach from=$products['physical_products'] item=product}
      <div class="{$componentName}__carrier-info">
        <div class="{$componentName}__carrier-info-content">
          <b class="{$componentName}__carrier-info-label">{l s='Delivery option: %carrier_name%' sprintf=['%carrier_name%' => $product.carrier.name] d='Shop.Theme.Global'}</b>
          <p class="{$componentName}__carrier-info-delay">{$product.carrier.delay}</p>
        </div>

        {if empty($hide_multishipment_edit_buttons)}
          <button class="{$componentName}__carrier-info-edit-button btn btn-outline-primary btn-sm js-edit-shipping" data-step="checkout-delivery-step" aria-label="{l s='Edit your shipping method' d='Shop.Theme.Actions'}">
            <i class="material-icons" aria-hidden="true">&#xE254;</i> {l s='Edit' d='Shop.Theme.Actions'}
          </button>
        {/if}
      </div>

      {foreach from=$product['products'] item=product}
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
                  src="{$product.default_image.bySize.default_xs.url}"
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
              <div class="{$componentName}__product-total">
                {$product.total}
              </div>
            </div>
          </div>
        </div>
      {/foreach}
    {/foreach}

    {if isset($products['virtual_products']) && !empty($products['virtual_products'])}
      <div class="{$componentName}__virtual-info {if isset($products['physical_products']) && empty($products['physical_products'])}mt-0{/if}">
        <div class="{$componentName}__virtual-info-content">
          <b class="{$componentName}__virtual-info-label">{l s='Virtual product(s)' d='Shop.Theme.Global'}</b>
          <p class="{$componentName}__virtual-info-value">{l s='No delivery service' d='Shop.Theme.Global'}</p>
        </div>
      </div>

      {foreach from=$products['virtual_products'] item=product}
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
                  src="{$product.default_image.bySize.default_xs.url}"
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
              <div class="{$componentName}__product-total">
                {$product.total}
              </div>
            </div>
          </div>
        </div>
      {/foreach}
    {/if}
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
