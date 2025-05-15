{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<div class="product-line row">
  {assign var=product_line_alert_id value=10|mt_rand:100000}
  <div id="js-product-line-alert--{$product_line_alert_id}"></div>
  <div class="product-line__image col-4 col-sm-2">
    <a class="product-line__title product-line__item" href="{$product.url}"
      data-id_customization="{$product.id_customization|intval}">
      {if $product.default_image}
        <picture>
          {if isset($product.default_image.bySize.default_xs.sources.avif)}
            <source 
              srcset="
                {$product.default_image.bySize.default_xs.sources.avif},
                {$product.default_image.bySize.default_m.sources.avif} 2x"
              type="image/avif"
            >
          {/if}

          {if isset($product.default_image.bySize.default_xs.sources.webp)}
            <source 
              srcset="
                {$product.default_image.bySize.default_xs.sources.webp},
                {$product.default_image.bySize.default_m.sources.webp} 2x"
              type="image/webp"
            >
          {/if}

          <img
            class="img-fluid"
            srcset="
              {$product.default_image.bySize.default_xs.url},
              {$product.default_image.bySize.default_m.url} 2x"
            width="{$product.default_image.bySize.default_xs.width}"
            height="{$product.default_image.bySize.default_xs.height}"
            loading="lazy"
            alt="{$product.name|escape:'quotes'}"
            title="{$product.name|escape:'quotes'}"
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
    </a>
  </div>

  <div class="product-line__content col-8 col-sm-4 col-md-6">
    <a class="product-line__title product-line__item" href="{$product.url}"
      data-id_customization="{$product.id_customization|intval}">
      {$product.name}
    </a>

    {if is_array($product.customizations) && $product.customizations|count}
      {include file='catalog/_partials/product-customization-modal.tpl' product=$product}
    {/if}

    {foreach from=$product.attributes key="attribute" item="value"}
      <div class="product-line__info product-line__item {$attribute|lower}">
        <span class="label">{$attribute}:</span>
        <span class="value">{$value}</span>
      </div>
    {/foreach}

    {hook h='displayCartExtraProductInfo' product=$product}

    <div class="product-line__prices product-line__item">
      <div class="product-line__current">
        <span class="price">{$product.price}</span>
        {if $product.unit_price_full}
          <div class="unit-price-cart">{$product.unit_price_full}</div>
        {/if}
      </div>

      {if $product.has_discount}
        <div class="product-line__basic">
          <span class="product-line__regular">{$product.regular_price}</span>

          {if $product.discount_type === 'percentage'}
            <span class="discount badge discount">
              -{$product.discount_percentage_absolute}
            </span>
          {else}
            <span class="discount badge discount">
              -{$product.discount_to_display}
            </span>
          {/if}
        </div>
      {/if}
    </div>
  </div>

  <div class="col-4 d-block d-sm-none"></div>

  <div class="product-line__informations col-8 col-sm-6 col-md-4">
    <div class="row">
      <div class="quantity-button js-quantity-button col-12">
        {if !empty($product.is_gift)}
          <span class="gift-quantity">{$product.quantity}</span>
        {else}
          {include file='components/qty-input.tpl'
            attributes=[
              "class"=>"js-cart-line-product-quantity form-control",
              "name"=>"product-quantity-spin",
              "data-update-url"=>"{$product.update_quantity_url}",
              "data-product-id"=>"{$product.id_product}",
              "data-alert-id"=>"{$product_line_alert_id}",
              "value"=>"{$product.quantity}",
              "min"=>"{$product.minimal_quantity}"
            ]
          }
        {/if}
      </div>

      <div class="col-12">
        {if $product.has_discount}
          <div class="product-line__discount">
            <div class="price">
              <span class="product-line__price">
                <strong>
                  {if !empty($product.is_gift)}
                    <span class="gift">{l s='Gift' d='Shop.Theme.Checkout'}</span>
                  {else}
                    {$product.total}
                  {/if}
                </strong>
              </span>
            </div>
          </div>
        {else}
          {if !empty($product.is_gift)}
            <span class="gift">{l s='Gift' d='Shop.Theme.Checkout'}</span>
          {else}
            {$product.total}
          {/if}
        {/if}

        {hook h='displayProductPriceBlock' product=$product type="unit_price"}
      </div>
    </div>
  </div>

  <div class="col-4 col-sm-2"></div>

  <div class="product-line__actions col-8 col-sm-10">
    {if empty($product.is_gift)}
      <a class="remove-from-cart" rel="nofollow" href="{$product.remove_from_cart_url}"
        data-link-action="delete-from-cart" data-id-product="{$product.id_product|escape:'javascript'}"
        data-id-product-attribute="{$product.id_product_attribute|escape:'javascript'}"
        data-id-customization="{$product.id_customization|escape:'javascript'}"
        data-product-url="{$product.url|escape:'javascript'}"
        data-product-name="{$product.name|escape:'htmlall':'UTF-8'}"
        >
        {l s='Remove' d='Shop.Theme.Checkout'}
      </a>
    {/if}

    {block name='hook_cart_extra_product_actions'}
      {hook h='displayCartExtraProductActions' product=$product}
    {/block}
  </div>
</div>
