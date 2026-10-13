{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
{block name='pack_miniature_item'}
  {$imageTypes = ['default_xs' => '1x', 'default_md' => '2x']}
  <article class="product-pack__item">
    <a href="{$product.url}"
      class="product-pack__link"
      aria-labelledby="pack-product-{$product.id_product}"
    >
      <span class="product-pack__image-wrapper">
        {if !empty($product.default_image)}
          {$avifSrcset = $product.default_image|srcset:$imageTypes:'avif'}
          {$webpSrcset = $product.default_image|srcset:$imageTypes:'webp'}
          {$imgSrcset = $product.default_image|srcset:$imageTypes}
          <picture>
            {if $avifSrcset}
              <source
                srcset="{$avifSrcset}"
                type="image/avif"
              >
            {/if}

            {if $webpSrcset}
              <source
                srcset="{$webpSrcset}"
                type="image/webp"
              >
            {/if}

            <img
              class="product-pack__image img-fluid"
              {if $imgSrcset}
                srcset="{$imgSrcset}"
              {/if}
              src="{$product.default_image.bySize.default_xs.url}"
              loading="lazy"
              width="{$product.default_image.bySize.default_xs.width}"
              height="{$product.default_image.bySize.default_xs.height}"
              alt="{$product.default_image.legend}"
              title="{$product.default_image.legend}"
            >
          </picture>
        {else}
          {$avifSrcset = $urls.no_picture_image|srcset:$imageTypes:'avif'}
          {$webpSrcset = $urls.no_picture_image|srcset:$imageTypes:'webp'}
          {$imgSrcset = $urls.no_picture_image|srcset:$imageTypes}
          <picture>
            {if $avifSrcset}
              <source
                srcset="{$avifSrcset}"
                type="image/avif"
              >
            {/if}

            {if $webpSrcset}
              <source
                srcset="{$webpSrcset}"
                type="image/webp"
              >
            {/if}

            <img
              class="product-pack__image img-fluid"
              {if $imgSrcset}
                srcset="{$imgSrcset}"
              {/if}
              src="{$urls.no_picture_image.bySize.default_xs.url}"
              width="{$urls.no_picture_image.bySize.default_xs.width}"
              height="{$urls.no_picture_image.bySize.default_xs.height}"
              loading="lazy"
            >
          </picture>
        {/if}
      </span>

      <span class="product-pack__name">
        {$product.name}
      </span>

      {if $showPackProductsPrice}
        <span class="product-pack__price">
          {$product.price}
        </span>
      {/if}

      <span class="product-pack__quantity">
        x{$product.pack_quantity}
      </span>

      <span id="pack-product-{$product.id_product}" class="visually-hidden">
        {l s='View product %product_name%, part of the pack.' sprintf=['%product_name%' => $product.name] d='Shop.Theme.Catalog'} {l s='Quantity inside the pack: %quantity%.' sprintf=['%quantity%' => $product.pack_quantity] d='Shop.Theme.Catalog'} {if $showPackProductsPrice}{l s='Price: %price%.' sprintf=['%price%' => $product.price] d='Shop.Theme.Catalog'}{/if}
      </span>
    </a>
  </article>
{/block}
