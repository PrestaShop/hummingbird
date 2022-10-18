{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$componentName = 'product-miniature'}

{block name='product_miniature_item'}
  <article class="{$componentName} js-{$componentName}{if !empty($productClasses)} {$productClasses}{/if}" data-id-product="{$product.id_product}" data-id-product-attribute="{$product.id_product_attribute}">
    <div class="card">
      <a href="{$product.url}" class="{$componentName}__link">
        {include file='catalog/_partials/product-flags.tpl'}

        {block name='product_miniature_image'}
          <div class="{$componentName}__image-container thumbnail-container">
            {if $product.cover}
              
                {if isset($product.cover.bySize.default_320.sources.avif)}
                  <source 
                    srcset="
                      {$product.cover.bySize.default_120.sources.avif} 120w,
                      {$product.cover.bySize.default_200.sources.avif} 200w,
                      {$product.cover.bySize.default_320.sources.avif} 320w,
                      {$product.cover.bySize.default_720.sources.avif} 720w"
                    sizes="(min-width: 1300px) 720px, (min-width: 768px) 50vw, 100vw" 
                    type="image/avif"
                  >
                {/if}

                {if isset($product.cover.bySize.default_320.sources.webp)}
                  <source 
                    srcset="
                      {$product.cover.bySize.default_120.sources.webp} 120w,
                      {$product.cover.bySize.default_200.sources.webp} 200w,
                      {$product.cover.bySize.default_320.sources.webp} 320w,
                      {$product.cover.bySize.default_720.sources.webp} 720w"
                    sizes="(min-width: 1300px) 320px, (min-width: 768px) 120px, 100vw" 
                    type="image/webp"
                  >
                {/if}

                <img
                  class="{$componentName}__image card-img-top"
                  srcset="
                    {$product.cover.bySize.default_120.url} 120w,
                    {$product.cover.bySize.default_200.url} 200w,
                    {$product.cover.bySize.default_320.url} 320w,
                    {$product.cover.bySize.default_720.url} 720w"
                  sizes="(min-width: 1300px) 320px, (min-width: 768px) 120px, 100vw" 
                  src="{$product.cover.bySize.default_720.sources.jpg}" 
                  width="{$product.cover.bySize.default_720.width}"
                  height="{$product.cover.bySize.default_720.height}"
                  loading="lazy"
                  alt="{if !empty($product.cover.legend)}{$product.cover.legend}{else}{$product.name}{/if}"
                  title="{if !empty($product.cover.legend)}{$product.cover.legend}{else}{$product.name}{/if}"
                  data-full-size-image-url="{$product.cover.bySize.home_default.url}"
              </picture>
            {else}
              <picture>
                {if isset($urls.no_picture_image.bySize.default_320.sources.avif)}
                  <source 
                    srcset="
                      {$urls.no_picture_image.bySize.default_120.sources.avif} 120w,
                      {$urls.no_picture_image.bySize.default_200.sources.avif} 200w,
                      {$urls.no_picture_image.bySize.default_320.sources.avif} 320w,
                      {$urls.no_picture_image.bySize.default_720.sources.avif} 720w"
                    sizes="(min-width: 1300px) 720px, (min-width: 768px) 50vw, 100vw" 
                    type="image/avif"
                  >
                {/if}

                {if isset($urls.no_picture_image.bySize.default_320.sources.webp)}
                  <source 
                    srcset="
                      {$urls.no_picture_image.bySize.default_120.sources.webp} 120w,
                      {$urls.no_picture_image.bySize.default_200.sources.webp} 200w,
                      {$urls.no_picture_image.bySize.default_320.sources.webp} 320w,
                      {$urls.no_picture_image.bySize.default_720.sources.webp} 720w"
                    sizes="(min-width: 1300px) 320px, (min-width: 768px) 120px, 100vw" 
                    type="image/webp"
                  >
                {/if}

                <img
                  class="{$componentName}__image card-img-top"
                  srcset="
                    {$urls.no_picture_image.bySize.default_120.url} 120w,
                    {$urls.no_picture_image.bySize.default_200.url} 200w,
                    {$urls.no_picture_image.bySize.default_320.url} 320w,
                    {$urls.no_picture_image.bySize.default_720.url} 720w"
                  sizes="(min-width: 1300px) 320px, (min-width: 768px) 120px, 100vw" 
                  width="{$urls.no_picture_image.bySize.default_720.width}"
                  height="{$urls.no_picture_image.bySize.default_720.height}"
                  src="{$urls.no_picture_image.bySize.default_720.sources.jpg}" 
                  loading="lazy"
                  alt="{if !empty($product.cover.legend)}{$product.cover.legend}{else}{$product.name}{/if}"
                  title="{if !empty($product.cover.legend)}{$product.cover.legend}{else}{$product.name}{/if}"
                  data-full-size-image-url="{$product.cover.bySize.home_default.url}"
              </picture>
            {/if}

            {block name='quick_view_touch'}
              <button class="{$componentName}__quickview_touch btn js-quickview" data-link-action="quickview">
                  <i class="material-icons">&#xE417;</i>
              </button>
            {/block}
          </div>
        {/block}
      </a>

      {block name='product_miniature_bottom'}
        <div class="{$componentName}__infos card-body">
          {block name='quick_view'}
            <div class="{$componentName}__quickview">
              <button class="{$componentName}__quickview_button btn btn-link js-quickview btn-with-icon" data-link-action="quickview">
                <i class="material-icons">&#xE417;</i>
                {l s='Quick view' d='Shop.Theme.Actions'}
              </button>
            </div>
          {/block}

          <div class="{$componentName}__infos__top">
            {block name='product_name'}
              <a href="{$product.url}"><p class="{$componentName}__title">{$product.name}</p></a>
            {/block}
          </div>

          <div class="{$componentName}__infos__bottom">
            {block name='product_variants'}
              <div class="{$componentName}-variants">
                {if $product.main_variants}
                  {include file='catalog/_partials/variant-links.tpl' variants=$product.main_variants}
                {/if}
              </div>
            {/block}

            <div class="{$componentName}__prices">
              {block name='product_price'}
                {if $product.show_price}
                  {hook h='displayProductPriceBlock' product=$product type="before_price"}

                  <span class="{$componentName}__price" aria-label="{l s='Price' d='Shop.Theme.Catalog'}">
                    {capture name='custom_price'}{hook h='displayProductPriceBlock' product=$product type='custom_price' hook_origin='products_list'}{/capture}
                    {if '' !== $smarty.capture.custom_price}
                      {$smarty.capture.custom_price nofilter}
                    {else}
                      {$product.price}
                    {/if}
                  </span>

                  {hook h='displayProductPriceBlock' product=$product type='unit_price'}

                  {hook h='displayProductPriceBlock' product=$product type='weight'}
                {/if}
              {/block}

              {block name='product_discount_price'}
                {if $product.show_price}
                  <div class="{$componentName}__discount-price">
                    {if $product.has_discount}
                      {hook h='displayProductPriceBlock' product=$product type="old_price"}

                      <span class="{$componentName}__regular-price" aria-label="{l s='Regular price' d='Shop.Theme.Catalog'}">{$product.regular_price}</span>
                    {/if}
                  </div>
                {/if}
              {/block}
            </div>

          </div>
        </div>
      {/block}
    </div>
  </article>
{/block}
