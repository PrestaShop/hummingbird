{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
{$coverTypes = ['default_xl', 'product_main']}
{$thumbnailTypes = ['default_xs' => '1x', 'default_xl' => '2x']}

<div class="product__images js-images-container">
  {if $product.images|@count > 0}
    <div
      id="product-images-{$product.id}"
      class="product__carousel carousel slide js-product-carousel"
    >
      {include file='catalog/_partials/product-flags.tpl'}

      <div class="carousel-inner">
        {block name='product_cover'}
          {foreach from=$product.images item=image key=key name=productImages}
            <div class="carousel-item{if $image.id_image == $product.default_image.id_image} active{/if}">
              {$srcset = $image|srcset:$coverTypes}
              <picture>
                {include file='_partials/picture-sources.tpl' srcset=$srcset sizes='(min-width: 992px) 50vw, 100vw'}

                <img
                  class="img-fluid w-100"
                  {if $srcset.url}
                    srcset="{$srcset.url}"
                    sizes="(min-width: 992px) 50vw, 100vw"
                  {/if}
                  src="{$image.bySize.product_main.url}" 
                  width="{$image.bySize.product_main.width}"
                  height="{$image.bySize.product_main.height}"
                  {if $smarty.foreach.productImages.first}
                    fetchpriority="high"
                  {else}
                    loading="lazy"
                  {/if}
                  alt="{$image.legend}"
                  title="{$image.legend}"
                  data-full-size-image-url="{$image.bySize.home_default.url}"
                >
              </picture>
            </div>
          {/foreach}
        {/block}
      </div>

      {if $product.images|@count > 1}
        <button class="carousel-control-prev outline outline--rounded" type="button" data-bs-target="#product-images-{$product.id}" data-bs-slide="prev">
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="visually-hidden">{l s='Previous image' d='Shop.Theme.Global'}</span>
        </button>

        <button class="carousel-control-next outline outline--rounded" type="button" data-bs-target="#product-images-{$product.id}" data-bs-slide="next">
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="visually-hidden">{l s='Next image' d='Shop.Theme.Global'}</span>
        </button>
      {/if}

      {block name='product_images_modal_button'}
        <button class="product__zoom btn btn-tertiary outline outline--rounded btn-square-icon" data-bs-toggle="modal" data-bs-target="#product-modal" aria-label="{l s='Open zoomed product image gallery' d='Shop.Theme.Global'}" title="{l s='Open zoomed product image gallery' d='Shop.Theme.Global'}">
          <i class="material-icons" aria-hidden="true">&#xE8B6;</i>
        </button>
      {/block}
    </div>

    {block name='product_images'}
      <div class="product__thumbnails">
        <ul class="product__thumbnails-list">
          {foreach from=$product.images item=image key=key name=productThumbnails}
            <li class="product__thumbnails-item" data-ps-ref="product-thumbnail-item">
              <button
                type="button"
                class="product__thumbnail focus-ring js-thumb-container{if $image.id_image == $product.default_image.id_image} active{/if}"
                data-ps-ref="product-thumbnail"
                data-bs-target="#product-images-{$product.id}"
                data-bs-slide-to="{$key}"
                {if $image.id_image == $product.default_image.id_image}
                  aria-current="true"
                {/if}
                aria-label="{l s='Slide to product image %number%' d='Shop.Theme.Catalog' sprintf=['%number%' => $key + 1]}"
              >
                {$srcset = $image|srcset:$thumbnailTypes}
                <picture>
                  {include file='_partials/picture-sources.tpl' srcset=$srcset}

                  <img
                    class="product__thumbnail-image outline outline--rounded img-fluid js-thumb{if $image.id_image == $product.default_image.id_image} js-thumb-selected{/if}"
                    {if $srcset.url}
                      srcset="{$srcset.url}"
                    {/if}
                    width="{$image.bySize.default_xs.width}"
                    height="{$image.bySize.default_xs.height}"
                    loading="lazy"
                    alt="{$image.legend}"
                    title="{$image.legend}"
                  >
                </picture>
              </button>
            </li>
          {/foreach}
        </ul>
      </div>
    {/block}

    {hook h='displayAfterProductThumbs' product=$product}
  {else}
    <div class="product__no-image">
      {include file='catalog/_partials/product-flags.tpl'}

      {$srcset = $urls.no_picture_image|srcset:$coverTypes}
      <picture>
        {include file='_partials/picture-sources.tpl' srcset=$srcset sizes='(min-width: 992px) 50vw, 100vw'}

        <img
          class="img-fluid"
          {if $srcset.url}
            srcset="{$srcset.url}"
            sizes="(min-width: 992px) 50vw, 100vw"
          {/if}
          width="{$urls.no_picture_image.bySize.product_main.width}"
          height="{$urls.no_picture_image.bySize.product_main.height}"
          src="{$urls.no_picture_image.bySize.default_xl.url}" 
          loading="lazy"
          alt="{l s='No image available' d='Shop.Theme.Catalog'}"
          title="{l s='No image available' d='Shop.Theme.Catalog'}"
        >
      </picture>
    </div>
  {/if}

  {block name='product_images_modal'}
    {include file='catalog/_partials/product-images-modal.tpl'}
  {/block}
</div>
