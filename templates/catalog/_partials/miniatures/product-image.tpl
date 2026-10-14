{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
{block name='product_miniature_image'}
  {$imageTypes = ['default_sm', 'default_md', 'default_lg']}
  <div class="{$componentName}__image-container thumbnail-container">
    <a href="{$product.url}" class="{$componentName}__image-link outline outline--rounded">
      {if $product.cover}
        {$srcset = $product.cover|srcset:$imageTypes}
        <picture>
          {include file='_partials/picture-sources.tpl' srcset=$srcset sizes='(min-width: 992px) 25vw, (min-width: 360px) 50vw, 100vw'}

          <img
            class="{$componentName}__image"
            {if $srcset.url}
              srcset="{$srcset.url}"
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
        {$srcset = $urls.no_picture_image|srcset:$imageTypes}
        <picture>
          {include file='_partials/picture-sources.tpl' srcset=$srcset sizes='(min-width: 992px) 25vw, (min-width: 360px) 50vw, 100vw'}

          <img
            class="{$componentName}__image"
            {if $srcset.url}
              srcset="{$srcset.url}"
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
