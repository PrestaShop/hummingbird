{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
 {$componentName = 'order-confirmation'}

<div class="{$componentName}__table{block name='order-confirmation-classes'}{/block}">
  <div class="{$componentName}__items">
    {foreach from=$products item=product}
      <div class="carrier-info">
        <span><b>Delivery option</b>: {$product.carrier.name}</span>
        <p>{$product.carrier.delay}</p>
      </div>
    {foreach from=$product['products'] item=productDetail}
    <div class="item row gx-3">
      <div class="item__image col-lg-1 col-md-2 col-sm-2 col-3 mb-2 mb-md-0">
          {if !empty($productDetail.default_image)}
            <picture>
              {if isset($productDetail.default_image.bySize.default_xs.sources.avif)}
                <source
                  srcset="
                    {$productDetail.default_image.bySize.default_xs.sources.avif},
                    {$productDetail.default_image.bySize.default_m.sources.avif} 2x"
                  type="image/avif"
                >
              {/if}

              {if isset($productDetail.default_image.bySize.default_xs.sources.webp)}
                <source
                  srcset="
                    {$productDetail.default_image.bySize.default_xs.sources.webp},
                    {$productDetail.default_image.bySize.default_m.sources.webp} 2x"
                  type="image/webp"
                >
              {/if}

              <img
                class="img-fluid"
                srcset="
                  {$productDetail.default_image.bySize.default_xs.url},
                  {$productDetail.default_image.bySize.default_m.url} 2x"
                loading="lazy"
                width="{$productDetail.default_image.bySize.default_xs.width}"
                height="{$productDetail.default_image.bySize.default_xs.height}"
                alt="{$productDetail.default_image.legend}"
                title="{$productDetail.default_image.legend}"
              >
            </picture>
          {else}
            <picture>
              {if isset($urls.no_picture_image.bySize.default_xs.sources.avif)}
                <source
                  srcset="
                    {$urls.no_picture_image.bySize.default_xs.sources.avif},
                    {$urls.no_picture_image.bySize.default_m.sources.avif} 2x"
                  type="image/avif"
                >
              {/if}

              {if isset($urls.no_picture_image.bySize.default_xs.sources.webp)}
                <source
                  srcset="
                    {$urls.no_picture_image.bySize.default_xs.sources.webp},
                    {$urls.no_picture_image.bySize.default_m.sources.webp} 2x"
                  type="image/webp"
                >
              {/if}

              <img
                class="img-fluid"
                srcset="
                  {$urls.no_picture_image.bySize.default_xs.url},
                  {$urls.no_picture_image.bySize.default_m.url} 2x"
                width="{$urls.no_picture_image.bySize.default_xs.width}"
                height="{$urls.no_picture_image.bySize.default_xs.height}"
                loading="lazy"
              >
            </picture>
          {/if}
      </div>

      <div class="item__details col-lg-9 col-md-8 col-sm-10 col-7">
        {if $add_product_link}<a href="{$productDetail.url}" target="_blank">{/if}
          <p class="item__title">{$productDetail.name}</p>
        {if $add_product_link}</a>{/if}

        {if !empty($productDetail.reference)}
          {foreach from=$productDetail.attributes key=key item=value}
            <span>{$key}: {$value} </span>{if !$smarty.foreach.attr.last} *{/if}
          {/foreach}
          {l s='Reference' d='Shop.Theme.Catalog'} {$productDetail.reference}
        {/if}

        {if is_array($productDetail.customizations) && $productDetail.customizations|count}
          {include file='catalog/_partials/product-customization-modal.tpl' product=$product}
        {/if}

        <p>{$productDetail.total}</p>

        {hook h='displayProductPriceBlock' product=$productDetail type="unit_price"}
      </div>

    </div>
    {/foreach}
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
