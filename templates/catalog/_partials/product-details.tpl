<div
  class="js-product-details"
  data-product="{$product.embedded_attributes|json_encode}"
>
  <div class="accordion-item" id="product_details">
    <h2 class="accordion-header" id="product_details_heading">
      <button class="accordion-button {if $product.description}collapsed{/if}" type="button" data-bs-toggle="collapse" data-bs-target="#product_details_collapse" aria-expanded="{if !$product.description}true{else}false{/if}"
        aria-controls="product_details_collapse">
        {l s='Product Details' d='Shop.Theme.Catalog'}
      </button>
    </h2>

    <div id="product_details_collapse" class="accordion-collapse collapse {if !$product.description}show{/if}" aria-labelledby="product_details_heading">
      <div class="accordion-body">
        <ul class="details__list">
          {block name='product_manufacturer'}
            {if isset($product_manufacturer->id)}
              <li class="details__item">
                <div class="details__left">
                  <span class="details__title">{l s='Brand' d='Shop.Theme.Catalog'}</span>
                </div>

                <div class="details__right">
                  {if isset($manufacturer_image_url)}
                    <a href="{$product_brand_url}">
                      <img src="{$manufacturer_image_url}" 
                        class="img-fluid details__manufacturer-logo" 
                        alt="{$product_manufacturer->name}" 
                        loading="lazy" 
                        width="98" 
                        height="50"
                        aria-label="{l s='Brand: %brand_name%' sprintf=['%brand_name%' => $product_manufacturer->name] d='Shop.Theme.Catalog'}"
                      >
                    </a>
                  {else}
                    <a href="{$product_brand_url}">{$product_manufacturer->name}</a>
                  {/if}
                </div>
              </li>
            {/if}
          {/block}

          {block name='product_reference'}
            {if !empty($product.reference_to_display)}
              <li class="details__item">
                <div class="details__left">
                  <span class="details__title">{l s='Reference' d='Shop.Theme.Catalog'}</span>
                </div>

                <div class="details__right">
                  <span>{$product.reference_to_display}</span>
                </div>
              </li>
            {/if}
          {/block}

          {block name='product_quantities'}
            {if $product.show_quantities}
              <li class="details__item">
                <div class="details__left">
                  <span class="details__title">{l s='In stock' d='Shop.Theme.Catalog'}</span>
                </div>

                <div class="details__right">
                  <span data-stock="{$product.quantity}" data-allow-oosp="{$product.allow_oosp}">{$product.quantity} {$product.quantity_label}</span>
                </div>
              </li>
            {/if}
          {/block}

          {block name='product_availability_date'}
            {if $product.availability_date}
              <li class="details__item">
                <div class="details__left">
                  <span class="details__title">{l s='Availability date:' d='Shop.Theme.Catalog'}</span>
                </div>

                <div class="details__right">
                  <span>{$product.availability_date}</span>
                </div>
              </li>
            {/if}
          {/block}

          {* if product have specific references, a table will be added to product details section *}
          {block name='product_condition'}
            {if $product.condition}
              <li class="details__item">
                <div class="details__left">
                  <span class="details__title">{l s='Condition' d='Shop.Theme.Catalog'}</span>
                </div>

                <div class="details__right">
                  <span>{$product.condition.label}</span>
                </div>
              </li>
            {/if}
          {/block}

          {block name='product_specific_references'}
            {if !empty($product.specific_references)}
              {foreach from=$product.specific_references item=reference key=key}
                <li class="details__item">
                  <div class="details__left">
                    <span class="details__title">{$key}</span>
                  </div>

                  <div class="details__right">
                    <span>{$reference}</span>
                  </div>
                </li>
              {/foreach}
            {/if}
          {/block}
        </ul>
      </div>
    </div>
  </div>

  {block name='product_features'}
    {if $product.grouped_features}
      <div class="accordion-item" id="product_features">
        <h2 class="accordion-header" id="product_features_heading">
          <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#product_features_collapse" aria-expanded="false" aria-controls="product_features_collapse">
            {l s='Data sheet' d='Shop.Theme.Catalog'}
          </button>
        </h2>

        <div id="product_features_collapse" class="accordion-collapse collapse" aria-labelledby="product_features_heading">
          <div class="accordion-body">
            <ul class="details__list">
              {foreach from=$product.grouped_features item=feature}
                <li class="details__item">
                  <div class="details__left">
                    <span class="details__title">{$feature.name}</span>
                  </div>

                  <div class="details__right">
                    <span>{$feature.value|escape:'htmlall'|nl2br nofilter}</span>
                  </div>
                </li>
              {/foreach}
            </ul>
          </div>
        </div>
      </div>
    {/if}
  {/block}
</div>
