<div 
  class="product-infos-details product-infos-element js-product-details"
  id="product-details"
  data-product="{$product.embedded_attributes|json_encode}"
>
  <h5 class="product-infos-title">{l s='Product Details' d='Shop.Theme.Catalog'}</h5>

  <ul class="prodcut-infos-details-list">
    {block name='product_reference'}
      {if isset($product_manufacturer->id)}
        <li class="product-infos-details-line">
          <div class="product-infos-details-line-left">
            <h5 class="product-infos-details-line-title">{l s='Brand' d='Shop.Theme.Catalog'}</h5>
          </div>
          <div class="product-infos-details-line-right">
            {if isset($manufacturer_image_url)}
              <a href="{$product_brand_url}">
                <img src="{$manufacturer_image_url}" class="img img-thumbnail manufacturer-logo" alt="{$product_manufacturer->name}" loading="lazy" width="98" height="50">
              </a>
            {else}
              <a href="{$product_brand_url}">{$product_manufacturer->name}</a>
            {/if}
          </div>
        <li>

        {if isset($product.reference_to_display) && $product.reference_to_display neq ''}
          <li class="product-infos-details-line">
            <div class="product-infos-details-line-left">
              <h5 class="product-infos-details-line-title">{l s='Reference' d='Shop.Theme.Catalog'}</h5>
            </div>
            <div class="product-infos-details-line-right">
              <span>{$product.reference_to_display}</span>
            </div>
          <li>
        {/if}
      {/if}
    {/block}

    {block name='product_quantities'}
      {if $product.show_quantities}
        <li class="product-infos-details-line">
          <div class="product-infos-details-line-left">
            <h5 class="product-infos-details-line-title">{l s='In stock' d='Shop.Theme.Catalog'}</h5>
          </div>
          <div class="product-infos-details-line-right">
            <span data-stock="{$product.quantity}" data-allow-oosp="{$product.allow_oosp}">{$product.quantity} {$product.quantity_label}</span>
          </div>
        <li>
      {/if}
    {/block}


    {block name='product_availability_date'}
      {if $product.availability_date}
        <li class="product-infos-details-line">
          <div class="product-infos-details-line-left">
            <h5 class="product-infos-details-line-title">{l s='Availability date:' d='Shop.Theme.Catalog'}</h5>
          </div>
          <div class="product-infos-details-line-right">
            <span>{$product.availability_date}</span>
          </div>
        <li>
      {/if}
    {/block}

    {block name='product_out_of_stock'}
      <li class="product-infos-details-line">
        <div class="product-infos-details-line-left">
          <h5 class="product-infos-details-line-title">{l s='Out of stock' d='Shop.Theme.Catalog'}</h5>
        </div>
        <div class="product-infos-details-line-right">
          {hook h='actionProductOutOfStock' product=$product}
        </div>
      <li>
    {/block}


    {* if product have specific references, a table will be added to product details section *}
    {block name='product_condition'}
      {if $product.condition}
        <li class="product-infos-details-line">
          <div class="product-infos-details-line-left">
            <h5 class="product-infos-details-line-title">{l s='Condition' d='Shop.Theme.Catalog'}</h5>
          </div>
          <div class="product-infos-details-line-right">
            <link href="{$product.condition.schema_url}"/>
            <span>{$product.condition.label}</span>
          </div>
        <li>
      {/if}
    {/block}
  </ul>

  {block name='product_features'}
    {if $product.grouped_features}
      <section class="product-features">
        <h5 class="product-infos-title">{l s='Data sheet' d='Shop.Theme.Catalog'}</h5>
        <dl class="data-sheet">
          {foreach from=$product.grouped_features item=feature}
            <dt class="name">{$feature.name}</dt>
            <dd class="value">{$feature.value|escape:'htmlall'|nl2br nofilter}</dd>
          {/foreach}
        </dl>
      </section>
    {/if}
  {/block}

  {block name='product_specific_references'}
    {if !empty($product.specific_references)}
      <section class="product-features">
        <p class="h6">{l s='Specific References' d='Shop.Theme.Catalog'}</p>
          <dl class="data-sheet">
            {foreach from=$product.specific_references item=reference key=key}
              <dt class="name">{$key}</dt>
              <dd class="value">{$reference}</dd>
            {/foreach}
          </dl>
      </section>
    {/if}
  {/block}
</div>
