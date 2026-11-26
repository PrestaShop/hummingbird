{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
{assign var='emptyImageSizes' value=['default_xs' => '', 'default_md' => '2x']}
{assign var='imageSizes' value=['default_xs' => '', 'default_md' => '2x']}
{block name='pack_miniature_item'}
  <article class="product-pack__item">
    <a href="{$product.url}"
      class="product-pack__link"
      aria-labelledby="pack-product-{$product.id_product}"
    >
      <span class="product-pack__image-wrapper">
        {if !empty($product.default_image)}
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
              class="product-pack__image img-fluid"
              {capture name='imageSrcset'}{include file='catalog/_partials/srcset.tpl' image=$product.default_image sizes=$imageSizes}{/capture}
              {if $smarty.capture.imageSrcset|trim}
                srcset="{$smarty.capture.imageSrcset|trim nofilter}"
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
              class="product-pack__image img-fluid"
              {capture name='emptyImageSrcset'}{include file='catalog/_partials/srcset.tpl' image=$urls.no_picture_image sizes=$emptyImageSizes}{/capture}
              {if $smarty.capture.emptyImageSrcset|trim}
                srcset="{$smarty.capture.emptyImageSrcset|trim nofilter}"
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
