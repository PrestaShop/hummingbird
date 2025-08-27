{block name='product_miniature_image'}
  <div class="{$componentName}__image-container thumbnail-container">
    <a href="{$product.url}" class="{$componentName}__image-link outline outline--rounded">
      {if $product.cover}
        <picture>
          {if isset($product.cover.bySize.default_md.sources.avif)}
            <source
              srcset="
                {$product.cover.bySize.default_sm.sources.avif} 216w,
                {$product.cover.bySize.default_md.sources.avif} 261w,
                {$product.cover.bySize.default_lg.sources.avif} 336w"
              sizes="(min-width: 992px) 25vw, (min-width: 360px) 50vw, 100vw"
              type="image/avif"
            >
          {/if}

          {if isset($product.cover.bySize.default_md.sources.webp)}
            <source
              srcset="
                {$product.cover.bySize.default_sm.sources.webp} 216w,
                {$product.cover.bySize.default_md.sources.webp} 261w,
                {$product.cover.bySize.default_lg.sources.webp} 336w"
              sizes="(min-width: 992px) 25vw, (min-width: 360px) 50vw, 100vw"
              type="image/webp"
            >
          {/if}

          <img
            class="{$componentName}__image"
            srcset="
              {$product.cover.bySize.default_sm.url} 216w,
              {$product.cover.bySize.default_md.url} 261w,
              {$product.cover.bySize.default_lg.url} 336w"
            sizes="(min-width: 992px) 25vw, (min-width: 360px) 50vw, 100vw"
            src="{$product.cover.bySize.default_md.url}"
            width="{$product.cover.bySize.default_md.width}"
            height="{$product.cover.bySize.default_md.height}"
            loading="lazy"
            alt="{$product.cover.legend}"
            title="{$product.cover.legend}"
            data-full-size-image-url="{$product.cover.bySize.home_default.url}"
          >
        </picture>
      {else}
        <picture>
          {if isset($urls.no_picture_image.bySize.default_md.sources.avif)}
            <source
              srcset="
                {$urls.no_picture_image.bySize.default_sm.sources.avif} 216w,
                {$urls.no_picture_image.bySize.default_md.sources.avif} 261w,
                {$urls.no_picture_image.bySize.default_lg.sources.avif} 336w"
              sizes="(min-width: 992px) 25vw, (min-width: 360px) 50vw, 100vw"
              type="image/avif"
            >
          {/if}

          {if isset($urls.no_picture_image.bySize.default_md.sources.webp)}
            <source
              srcset="
                {$urls.no_picture_image.bySize.default_sm.sources.webp} 216w,
                {$urls.no_picture_image.bySize.default_md.sources.webp} 261w,
                {$urls.no_picture_image.bySize.default_lg.sources.webp} 336w"
              sizes="(min-width: 992px) 25vw, (min-width: 360px) 50vw, 100vw"
              type="image/webp"
            >
          {/if}

          <img
            class="{$componentName}__image"
            srcset="
              {$urls.no_picture_image.bySize.default_sm.url} 216w,
              {$urls.no_picture_image.bySize.default_md.url} 261w,
              {$urls.no_picture_image.bySize.default_lg.url} 336w"
            sizes="(min-width: 992px) 25vw, (min-width: 360px) 50vw, 100vw"
            width="{$urls.no_picture_image.bySize.default_md.width}"
            height="{$urls.no_picture_image.bySize.default_md.height}"
            src="{$urls.no_picture_image.bySize.default_md.url}"
            loading="lazy"
            alt="{l s='No image available' d='Shop.Theme.Catalog'}"
            title="{l s='No image available' d='Shop.Theme.Catalog'}"
            data-full-size-image-url="{$urls.no_picture_image.bySize.home_default.url}"
          >
        </picture>
      {/if}
    </a>
  </div>
{/block}
