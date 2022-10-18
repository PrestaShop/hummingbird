{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{block name='cart_summary_product_line'}
  <div class="cart-summary__product__image col-md-2">
    <a href="{$product.url}" title="{$product.name}">
      {if $product.default_image}
        <picture>
          {if isset($product.default_image.bySize.default_80.sources.avif)}
            <source 
              srcset="
                {$product.default_image.bySize.default_80.sources.avif} 80w,
                {$product.default_image.bySize.default_160.sources.avif} 2x"
              type="image/avif"
            >
          {/if}

          {if isset($product.default_image.bySize.default_80.sources.webp)}
            <source 
              srcset="
                {$product.default_image.bySize.default_80.sources.webp} 80w,
                {$product.default_image.bySize.default_160.sources.webp} 2x"
              type="image/webp"
            >
          {/if}

          <img
            class="img-fluid rounded"
            srcset="
              {$product.default_image.bySize.default_80.url} 80w,
              {$product.default_image.bySize.default_160.url} 2x"
            loading="lazy"
            alt="{$product.name}"
            title="{$product.name}"
        </picture>
      {else}
        <img src="{$urls.no_picture_image.bySize.small_default.url}" class="img-fluid" loading="lazy" />
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

    <div class="cart-summary__product__basic">
      <span class="cart-summary__product__regular text-decoration-line-through">{$product.regular_price}</span>
    </div>

    {hook h='displayProductPriceBlock' product=$product type="unit_price"}
  </div>
{/block}
