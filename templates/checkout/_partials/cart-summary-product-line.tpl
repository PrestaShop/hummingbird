{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{block name='cart_summary_product_line'}
  <div class="cart-summary__product__image col-md-2">
    <a href="{$product.url}" title="{$product.name}">
      {if $product.default_image}
        <picture>
          {if isset($product.default_image.bySize.default_xs.sources.avif)}
            <source 
              srcset="
                {$product.default_image.bySize.default_xs.sources.avif},
                {$product.default_image.bySize.default_s.sources.avif} 2x"
              type="image/avif"
            >
          {/if}

          {if isset($product.default_image.bySize.default_xs.sources.webp)}
            <source 
              srcset="
                {$product.default_image.bySize.default_xs.sources.webp},
                {$product.default_image.bySize.default_s.sources.webp} 2x"
              type="image/webp"
            >
          {/if}

          <img
            class="img-fluid rounded"
            srcset="
              {$product.default_image.bySize.default_xs.url},
              {$product.default_image.bySize.default_s.url} 2x"
            width="{$product.default_image.bySize.default_xs.width}"
            height="{$product.default_image.bySize.default_xs.height}"
            loading="lazy"
            alt="{$product.name}"
            title="{$product.name}"
          >
        </picture>
      {else}
        <picture>
          {if isset($urls.no_picture_image.bySize.default_xs.sources.avif)}
            <source 
              srcset="
                {$urls.no_picture_image.bySize.default_xs.sources.avif},
                {$urls.no_picture_image.bySize.default_s.sources.avif} 2x"
              type="image/avif"
            >
          {/if}

          {if isset($urls.no_picture_image.bySize.default_xs.sources.webp)}
            <source 
              srcset="
                {$urls.no_picture_image.bySize.default_xs.sources.webp},
                {$urls.no_picture_image.bySize.default_s.sources.webp} 2x"
              type="image/webp"
            >
          {/if}

          <img
            class="img-fluid"
            srcset="
              {$urls.no_picture_image.bySize.default_xs.url},
              {$urls.no_picture_image.bySize.default_s.url} 2x"
            width="{$urls.no_picture_image.bySize.default_xs.width}"
            height="{$urls.no_picture_image.bySize.default_xs.height}"
            loading="lazy"
          >
        </picture>
      {/if}
    </a>
  </div>

  <div class="cart-summary__product__body col-md-7">
    <span class="product-name">
        <a href="{$product.url}" target="_blank" rel="noopener noreferrer nofollow">{$product.name}</a>
    </span>

    {foreach from=$product.attributes key="attribute" item="value"}
      <div class="product-line-info product-line-info-secondary text-muted">
          <span class="label">{$attribute}:</span>
          <span class="value">{$value}</span>
      </div>
    {/foreach}
    <div class="product-line-info product-line-info-secondary text-muted">
        <span class="label">{l s='Quantity' d='Shop.Theme.Checkout'}</span>
        <span class="value">x{$product.quantity}</span>
    </div>
  </div>

  <div class="cart-summary__product__price text-end col-md-3">
    <div class="cart-summary__product__current">
      <span class="price fw-bold">{$product.price}</span>
      {if $product.unit_price_full}
        <div class="unit-price-cart">{$product.unit_price_full}</div>
      {/if}
    </div>

    {if $product.has_discount}
      <div class="cart-summary__product__basic">
        <span class="cart-summary__product__regular text-decoration-line-through">{$product.regular_price}</span>
      </div>
    {/if}

    {hook h='displayProductPriceBlock' product=$product type="unit_price"}
  </div>
{/block}
