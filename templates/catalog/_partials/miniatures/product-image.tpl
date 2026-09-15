{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
{block name='product_miniature_image'}
  {assign var='miniatureSizes' value=['default_sm' => '216w', 'default_md' => '261w', 'default_lg' => '336w']}
  <div class="{$componentName}__image-container thumbnail-container">
    <a href="{$product.url}" class="{$componentName}__image-link outline outline--rounded">
      {if $product.cover}
        {capture name='miniatureSrcsetAvif'}{include file='catalog/_partials/srcset.tpl' image=$product.cover sizes=$miniatureSizes srcsetVariant='avif'}{/capture}
        {capture name='miniatureSrcsetWebp'}{include file='catalog/_partials/srcset.tpl' image=$product.cover sizes=$miniatureSizes srcsetVariant='webp'}{/capture}
        {capture name='miniatureSrcset'}{include file='catalog/_partials/srcset.tpl' image=$product.cover sizes=$miniatureSizes}{/capture}
        <picture>
          {if $smarty.capture.miniatureSrcsetAvif|trim}
            <source
              srcset="{$smarty.capture.miniatureSrcsetAvif|trim nofilter}"
              sizes="(min-width: 992px) 25vw, (min-width: 360px) 50vw, 100vw"
              type="image/avif"
            >
          {/if}

          {if $smarty.capture.miniatureSrcsetWebp|trim}
            <source
              srcset="{$smarty.capture.miniatureSrcsetWebp|trim nofilter}"
              sizes="(min-width: 992px) 25vw, (min-width: 360px) 50vw, 100vw"
              type="image/webp"
            >
          {/if}

          <img
            class="{$componentName}__image"
            {if $smarty.capture.miniatureSrcset|trim}
              srcset="{$smarty.capture.miniatureSrcset|trim nofilter}"
              sizes="(min-width: 992px) 25vw, (min-width: 360px) 50vw, 100vw"
            {/if}
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
        {capture name='miniatureEmptySrcsetAvif'}{include file='catalog/_partials/srcset.tpl' image=$urls.no_picture_image sizes=$miniatureSizes srcsetVariant='avif'}{/capture}
        {capture name='miniatureEmptySrcsetWebp'}{include file='catalog/_partials/srcset.tpl' image=$urls.no_picture_image sizes=$miniatureSizes srcsetVariant='webp'}{/capture}
        {capture name='miniatureEmptySrcset'}{include file='catalog/_partials/srcset.tpl' image=$urls.no_picture_image sizes=$miniatureSizes}{/capture}
        <picture>
          {if $smarty.capture.miniatureEmptySrcsetAvif|trim}
            <source
              srcset="{$smarty.capture.miniatureEmptySrcsetAvif|trim nofilter}"
              sizes="(min-width: 992px) 25vw, (min-width: 360px) 50vw, 100vw"
              type="image/avif"
            >
          {/if}

          {if $smarty.capture.miniatureEmptySrcsetWebp|trim}
            <source
              srcset="{$smarty.capture.miniatureEmptySrcsetWebp|trim nofilter}"
              sizes="(min-width: 992px) 25vw, (min-width: 360px) 50vw, 100vw"
              type="image/webp"
            >
          {/if}

          <img
            class="{$componentName}__image"
            {if $smarty.capture.miniatureEmptySrcset|trim}
              srcset="{$smarty.capture.miniatureEmptySrcset|trim nofilter}"
              sizes="(min-width: 992px) 25vw, (min-width: 360px) 50vw, 100vw"
            {/if}
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
