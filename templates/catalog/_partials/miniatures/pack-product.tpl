{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{block name='pack_miniature_item'}
  <article class="product-pack__item rounded mb-2 p-2">
    <a href="{$product.url}" title="{$product.name}" class="row align-items-center">
      <div class="product-pack__image col-2">
        {if !empty($product.default_image)}
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
              class="img-fluid rounded"
              srcset="
                {$product.default_image.bySize.default_xs.url},
                {$product.default_image.bySize.default_m.url} 2x"
              loading="lazy"
              width="{$product.default_image.bySize.default_xs.width}"
              height="{$product.default_image.bySize.default_xs.height}"
              alt="{$product.default_image.legend}"
              title="{$product.default_image.legend}"
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
              class="img-fluid rounded"
              srcset="
                {$urls.no_picture_image.bySize.default_xs.url},
                {$urls.no_picture_image.bySize.default_m.url} 2x"
              width="{$urls.no_picture_image.bySize.default_xs.width}"
              height="{$urls.no_picture_image.bySize.default_xs.height}"
              loading="lazy"
            >
          </picture>
        {/if}
      </div>

      <p class="product-pack__name col-6 my-0">
        {$product.name}
      </p>

      {if $showPackProductsPrice}
        <p class="product-pack__price col text-center">
          <strong>{$product.price}</strong>
        </p>
      {/if}

      <p class="product-pack__quantity col text-center my-0">
        x{$product.pack_quantity}
      </p>
    </a>
  </article>
{/block}
