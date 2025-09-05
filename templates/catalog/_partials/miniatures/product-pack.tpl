{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{block name='pack_miniature_item'}
  <article class="product-pack__item">
    <a href="{$product.url}"
      class="product-pack__link"
      aria-labelledby="pack-product-{$product.id_product}"
    >
      <span class="product-pack__image-wrapper">
        {if !empty($product.default_image)}
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
              class="product-pack__image img-fluid"
              srcset="
                {$product.default_image.bySize.default_xs.url},
                {$product.default_image.bySize.default_md.url} 2x"
              loading="lazy"
              width="{$product.default_image.bySize.default_xs.width}"
              height="{$product.default_image.bySize.default_xs.height}"
              alt="{$product.default_image.legend}"
              title="{$product.default_image.legend}"
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
              class="product-pack__image img-fluid"
              srcset="
                {$urls.no_picture_image.bySize.default_xs.url},
                {$urls.no_picture_image.bySize.default_md.url} 2x"
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
