{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
 {$componentName = 'order-confirmation'}

<div class="{$componentName}__table{block name='order-confirmation-classes'}{/block}">
  <div class="{$componentName}__items">
  {foreach from=$products item=product}
    <div class="item row gx-3">

      <div class="item__image col-lg-1 col-md-2 col-sm-2 col-3 mb-2 mb-md-0">
          {if !empty($product.default_image)}
            <img src="{$product.default_image.medium.url}" loading="lazy" class="img-fluid" />
          {else}
            <img src="{$urls.no_picture_image.bySize.medium_default.url}" loading="lazy" class="img-fluid" />
          {/if}
      </div>

      <div class="item__details col-lg-9 col-md-8 col-sm-10 col-7">
        {if $add_product_link}<a href="{$product.url}" target="_blank">{/if}
          <p class="item__title">{$product.name}</p>
        {if $add_product_link}</a>{/if}

        {if !empty($product.reference)}
          <p class="item__reference">{l s='Reference' d='Shop.Theme.Catalog'} {$product.reference}</p>
        {/if}

        {if is_array($product.customizations) && $product.customizations|count}
          {foreach from=$product.customizations item="customization"}
            <div class="customizations">
              <a href="#" data-bs-toggle="modal" data-target="#product-customizations-modal-{$customization.id_customization}">{l s='Product customization' d='Shop.Theme.Catalog'}</a>
            </div>
            <div class="modal fade customization-modal" id="product-customizations-modal-{$customization.id_customization}" tabindex="-1" role="dialog" aria-hidden="true">
              <div class="modal-dialog" role="document">
                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{l s='Close' d='Shop.Theme.Global'}"></button>
                    <h4 class="modal-title">{l s='Product customization' d='Shop.Theme.Catalog'}</h4>
                  </div>
                  <div class="modal-body">
                    {foreach from=$customization.fields item="field"}
                      <div class="product-customization-line row">
                        <div class="col-sm-3 col-4 label">
                          {$field.label}
                        </div>
                        <div class="col-sm-9 col-8 value">
                          {if $field.type == 'text'}
                            {if (int)$field.id_module}
                              {$field.text nofilter}
                            {else}
                              {$field.text}
                            {/if}
                          {elseif $field.type == 'image'}
                            <img src="{$field.image.small.url}" loading="lazy">
                          {/if}
                        </div>
                      </div>
                    {/foreach}
                  </div>
                </div>
              </div>
            </div>
          {/foreach}
        {/if}
        
        {hook h='displayProductPriceBlock' product=$product type="unit_price"}
      </div>
      
      <div class="item__prices col-md-2 col-sm-12 col-12">
        <div class="text-md-end">{l s='%product_price% (x%product_quantity%)' sprintf=['%product_price%' => $product.price, '%product_quantity%' => $product.quantity] d='Shop.Theme.Catalog'}</div>
        <div class="text-md-end">{$product.total}</div>
      </div>

    </div>
  {/foreach}
  </div>
  <hr>

  <div class="{$componentName}__subtotals">
    {foreach $subtotals as $subtotal}
      {if $subtotal !== null && $subtotal.type !== 'tax' && $subtotal.label !== null}
        <div class="row">
          <div class="col-6">{$subtotal.label}</div>
          <div class="col-6 text-end">{if 'discount' == $subtotal.type}-&nbsp;{/if}{$subtotal.value}</div>
        </div>
      {/if}
    {/foreach}
  </div>
  <hr>

  <div class="{$componentName}__totals fw-bold">
    {if !$configuration.display_prices_tax_incl && $configuration.taxes_enabled}
      <div class="row">
        <div class="col-6">{$totals.total.label}&nbsp;{$labels.tax_short}</div>
        <div class="col-6 text-end">{$totals.total.value}</div>
      </div>
      <div class="row fw-bold">
        <div class="col-6">{$totals.total_including_tax.label}</div>
        <div class="col-6 text-end">{$totals.total_including_tax.value}</div>
      </div>
    {else}
      <div class="row fw-bold">
        <div class="col-6">{$totals.total.label}&nbsp;{if $configuration.taxes_enabled}{$labels.tax_short}{/if}</div>
        <div class="col-6 text-end">{$totals.total.value}</div>
      </div>
    {/if}
    {if $subtotals.tax !== null && $subtotals.tax.label !== null}
      <div class="row">
        <div class="col-6">{l s='%label%:' sprintf=['%label%' => $subtotals.tax.label] d='Shop.Theme.Global'}</div>
        <div class="col-6 text-end">{$subtotals.tax.value}</div>
      </div>
    {/if}
  </div>
</div>
