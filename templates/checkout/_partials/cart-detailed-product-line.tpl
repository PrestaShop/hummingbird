{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<div class="product-line">
  <div class="product-line__image">
    <a class="product-line__title product-line__item" href="{$product.url}"
      data-id_customization="{$product.id_customization|intval}">
      {if $product.default_image}
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
            class="product-line__img img-fluid"
            srcset="
              {$product.default_image.bySize.default_xs.url},
              {$product.default_image.bySize.default_md.url} 2x"
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
            class="product-line__img img-fluid"
            srcset="
              {$urls.no_picture_image.bySize.default_xs.url},
              {$urls.no_picture_image.bySize.default_md.url} 2x"
            width="{$urls.no_picture_image.bySize.default_xs.width}"
            height="{$urls.no_picture_image.bySize.default_xs.height}"
            loading="lazy"
          >
        </picture>
      {/if}
    </a>
  </div>

  <div class="product-line__content">
    <div class="product-line__content-left">
      <a class="product-line__title" href="{$product.url}"
        data-id_customization="{$product.id_customization|intval}">
        {$product.name}
      </a>

      {if is_array($product.customizations) && $product.customizations|count}
        {include file='catalog/_partials/product-customization-modal.tpl' product=$product}
      {/if}

      {foreach from=$product.attributes key="attribute" item="value"}
        <div class="product-line__item product-line__item--info {$attribute|lower}">
          <span class="product-line__item-label">{$attribute}:</span>
          <span class="product-line__item-value">{$value}</span>
        </div>
      {/foreach}

      {if !empty($product.availability_message)}
        {if $product.availability == 'in_stock'}
          {assign 'availability_icon' 'E5CA'}
          {assign 'availability_class' 'text-success'}
        {elseif $product.availability == 'available'}
          {assign 'availability_icon' 'E002'}
          {assign 'availability_class' 'text-warning'}
        {elseif $product.availability == 'last_remaining_items'}
          {assign 'availability_icon' 'E002'}
          {assign 'availability_class' 'text-warning'}
        {else}
          {assign 'availability_icon' 'E14B'}
          {assign 'availability_class' 'text-danger'}
        {/if}

        <div class="product-line__item product-line__item--availability">
          <div class="product-line__item-availability-message {$availability_class}">
            <i class="product-line__item-availability-icon material-icons rtl-no-flip">&#x{$availability_icon};</i>
            {$product.availability_message}
          </div>
        </div>
      {/if}

      {if !empty($product.delivery_information)}
        <div class="product-line__item product-line__item--small-info">
          {$product.delivery_information}
        </div>
      {/if}

      {hook h='displayCartExtraProductInfo' product=$product}

      <div class="product-line__item product-line__item--prices">
        <span class="product-line__item-price">{$product.price}</span>
        {if $product.unit_price_full}
          <div class="product-line__item-unit-price">{$product.unit_price_full}</div>
        {/if}

        {if $product.has_discount}
          <span class="product-line__item-regular-price">{$product.regular_price}</span>

          {if $product.discount_type === 'percentage'}
            <span class="product-line__item-discount product-line__item-discount--percentage badge bg-primary">
              -{$product.discount_percentage_absolute}
            </span>
          {else}
            <span class="product-line__item-discount product-line__item-discount--amount badge bg-primary">
              -{$product.discount_to_display}
            </span>
          {/if}
        {/if}
      </div>
    </div>

    <div class="product-line__content-right">
      <div class="product-line__quantity-button quantity-button js-quantity-button">
        {if !empty($product.is_gift)}
          <span class="product-line__gift-quantity">{$product.quantity} {l s='Gift(s)' d='Shop.Theme.Checkout'}</span>
        {else}
          {include file='components/qty-input.tpl'
            attributes=[
              "class"=>"js-cart-line-product-quantity form-control mw-100",
              "name"=>"product-quantity-spin",
              "data-update-url"=>"{$product.update_quantity_url}",
              "data-product-id"=>"{$product.id_product}",
              "value"=>"{$product.quantity}",
              "min"=>"{$product.minimal_quantity}"
            ]
          }
        {/if}
      </div>

      {if $product.has_discount}
        {if !empty($product.is_gift)}
          <div class="product-line__gift">{l s='Gift' d='Shop.Theme.Checkout'}</div>
        {else}
          <div class="product-line__price">{$product.total}</div>
        {/if}
      {else}
        {if !empty($product.is_gift)}
          <div class="product-line__gift">{l s='Gift' d='Shop.Theme.Checkout'}</div>
        {else}
          <div class="product-line__price">{$product.total}</div>
        {/if}
      {/if}

      {hook h='displayProductPriceBlock' product=$product type="unit_price"}
    </div>

    <div class="product-line__actions">
      {if empty($product.is_gift)}
        <a class="js-remove-from-cart"
          rel="nofollow"
          href="{$product.remove_from_cart_url}"
          data-link-action="delete-from-cart" data-id-product="{$product.id_product|escape:'javascript'}"
          data-id-product-attribute="{$product.id_product_attribute|escape:'javascript'}"
          data-id-customization="{$product.id_customization|escape:'javascript'}"
          data-product-url="{$product.url|escape:'javascript'}"
          data-product-name="{$product.name|escape:'htmlall':'UTF-8'}"
          aria-label="{l s='Remove %productName% from cart' sprintf=['%productName%' => $product.name] d='Shop.Theme.Checkout'}"
        >
          {l s='Remove' d='Shop.Theme.Checkout'}
        </a>
      {/if}

      {block name='hook_cart_extra_product_actions'}
        {hook h='displayCartExtraProductActions' product=$product}
      {/block}
    </div>
  </div>
</div>
