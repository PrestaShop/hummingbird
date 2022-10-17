{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{block name='cart_summary_product_line'}
  <div class="cart-summary__product__image col-md-2">
    <a href="{$product.url}" title="{$product.name}">
      {if $product.default_image}
        <picture>
          <!-- <source 
            srcset="
            {$product.default_image.bySize.home_default.sources.webp} 250w" 
            type="image/webp"> -->

          <img
            class="img-fluid rounded"
            srcset="
              {$product.default_image.default_80.sources.jpg} 80w,
              {$product.default_image.bySize.default_160.sources.jpg} 2x"
            src="{$product.default_image.bySize.default_80.sources.jpg}" 
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
