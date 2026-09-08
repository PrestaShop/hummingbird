{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
{assign var='emptyImageSizes' value=['default_xs' => '', 'default_md' => '2x']}
{assign var='imageSizes' value=['default_xs' => '', 'default_md' => '2x']}

<div class="product-line">
  <div class="product-line__image">
    <a class="product-line__title product-line__item" href="{$product.url}"
      data-id_customization="{$product.id_customization|intval}">
      {if $product.default_image}
        <picture>
          {capture name='imageSrcsetAvif'}{include file='catalog/_partials/srcset.tpl' image=$product.default_image sizes=$imageSizes srcsetVariant='avif'}{/capture}
          {if $smarty.capture.imageSrcsetAvif|trim}
            <source
              srcset="{$smarty.capture.imageSrcsetAvif|trim nofilter}"
              type="image/avif"
            >
          {/if}

          {capture name='imageSrcsetWebp'}{include file='catalog/_partials/srcset.tpl' image=$product.default_image sizes=$imageSizes srcsetVariant='webp'}{/capture}
          {if $smarty.capture.imageSrcsetWebp|trim}
            <source
              srcset="{$smarty.capture.imageSrcsetWebp|trim nofilter}"
              type="image/webp"
            >
          {/if}

          <img
            class="product-line__img img-fluid"
            {capture name='imageSrcset'}{include file='catalog/_partials/srcset.tpl' image=$product.default_image sizes=$imageSizes}{/capture}
            {if $smarty.capture.imageSrcset|trim}
              srcset="{$smarty.capture.imageSrcset|trim nofilter}"
            {/if}
            width="{$product.default_image.bySize.default_xs.width}"
            height="{$product.default_image.bySize.default_xs.height}"
            loading="lazy"
            alt="{$product.name|escape:'quotes'}"
            title="{$product.name|escape:'quotes'}"
          >
        </picture>
      {else}
        <picture>
          {capture name='emptyImageSrcsetAvif'}{include file='catalog/_partials/srcset.tpl' image=$urls.no_picture_image sizes=$emptyImageSizes srcsetVariant='avif'}{/capture}
          {if $smarty.capture.emptyImageSrcsetAvif|trim}
            <source
              srcset="{$smarty.capture.emptyImageSrcsetAvif|trim nofilter}"
              type="image/avif"
            >
          {/if}

          {capture name='emptyImageSrcsetWebp'}{include file='catalog/_partials/srcset.tpl' image=$urls.no_picture_image sizes=$emptyImageSizes srcsetVariant='webp'}{/capture}
          {if $smarty.capture.emptyImageSrcsetWebp|trim}
            <source
              srcset="{$smarty.capture.emptyImageSrcsetWebp|trim nofilter}"
              type="image/webp"
            >
          {/if}

          <img
            class="product-line__img img-fluid"
            {capture name='emptyImageSrcset'}{include file='catalog/_partials/srcset.tpl' image=$urls.no_picture_image sizes=$emptyImageSizes}{/capture}
            {if $smarty.capture.emptyImageSrcset|trim}
              srcset="{$smarty.capture.emptyImageSrcset|trim nofilter}"
            {/if}
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
            <i class="product-line__item-availability-icon material-icons rtl-no-flip" aria-hidden="true">&#x{$availability_icon};</i>
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
          <span class="product-line__item-unit-price">{$product.unit_price_full}</span>
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

        {capture name='product_price_block'}{hook h='displayProductPriceBlock' product=$product type="unit_price"}{/capture}
        {if $smarty.capture.product_price_block}
          <div class="product-line__item-price-block">
            {$smarty.capture.product_price_block nofilter}
          </div>
        {/if}
      </div>
    </div>

    <div class="product-line__content-right">
      <div class="product-line__quantity-button quantity-button js-quantity-button">
        {if !empty($product.is_gift)}
          <span class="product-line__gift">
            <i class="product-line__gift-icon material-icons" aria-hidden="true">&#xE8B1;</i>{$product.quantity} {l s='Gift(s)' d='Shop.Theme.Checkout'}
          </span>
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

      {if empty($product.is_gift)}
        <div class="product-line__price">{$product.total}</div>
      {/if}
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
