{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

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
              <picture>
                {if isset($image.bySize.default_xl.sources.avif)}
                  <source 
                    srcset="
                      {$image.bySize.default_xl.sources.avif} 400w,
                      {$image.bySize.product_main.sources.avif} 720w"
                    sizes="(min-width: 992px) 50vw, (min-width: 360px) 33vw, 100vw"
                    type="image/avif"
                  >
                {/if}

                {if isset($image.bySize.default_xl.sources.webp)}
                  <source 
                    srcset="
                      {$image.bySize.default_xl.sources.webp} 400w,
                      {$image.bySize.product_main.sources.webp} 720w"
                    sizes="(min-width: 992px) 50vw, (min-width: 360px) 33vw, 100vw"
                    type="image/webp"
                  >
                {/if}

                <img
                  class="img-fluid w-100"
                  srcset="
                    {$image.bySize.default_xl.url} 400w,
                    {$image.bySize.product_main.url} 720w"
                  sizes="(min-width: 992px) 50vw, (min-width: 360px) 33vw, 100vw"
                  src="{$image.bySize.product_main.url}" 
                  width="{$image.bySize.product_main.width}"
                  height="{$image.bySize.product_main.height}"
                  loading="{if $smarty.foreach.productImages.first}eager{else}lazy{/if}"
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
        <button class="product__zoom btn btn-tertiary outline outline--rounded btn-square-icon" data-bs-toggle="modal" data-bs-target="#product-modal" aria-label="{l s='Open zoomed product image gallery' d='Shop.Theme.Global'}">
          <i class="material-icons">&#xE8B6;</i>
        </button>
      {/block}
    </div>

    {block name='product_images'}
      <div class="product__thumbnails">
        <ul class="product__thumbnails-list">
          {foreach from=$product.images item=image key=key name=productThumbnails}
            <button
              class="product__thumbnail focus-ring js-thumb-container{if $image.id_image == $product.default_image.id_image} active{/if}"
              data-bs-target="#product-images-{$product.id}"
              data-bs-slide-to="{$key}"
              {if $image.id_image == $product.default_image.id_image}
                aria-current="true"
              {/if}
              aria-label="{l s='Slide to product image %number%' d='Shop.Theme.Catalog' sprintf=['%number%' => $key + 1]}"
            >
              <picture>
                {if isset($image.bySize.default_xs.sources.avif)}
                  <source 
                    srcset="
                      {$image.bySize.default_xs.sources.avif},
                      {$image.bySize.default_xl.sources.avif} 2x"
                    type="image/avif"
                  >
                {/if}

                {if isset($image.bySize.default_xs.sources.webp)}
                  <source 
                    srcset="
                      {$image.bySize.default_xs.sources.webp},
                      {$image.bySize.default_xl.sources.webp} 2x"
                    type="image/webp"
                  >
                {/if}

                <img
                  class="product__thumbnail-image outline outline--rounded img-fluid js-thumb{if $image.id_image == $product.default_image.id_image} js-thumb-selected{/if}"
                  srcset="
                    {$image.bySize.default_xs.url},
                    {$image.bySize.default_xl.url} 2x"
                  width="{$image.bySize.default_xs.width}"
                  height="{$image.bySize.default_xs.height}"
                  loading="lazy"
                  alt="{$image.legend}"
                  title="{$image.legend}"
                >
              </picture>
            </button>
          {/foreach}
        </ul>
      </div>
    {/block}

    {hook h='displayAfterProductThumbs' product=$product}
  {else}
    <picture>
      {if isset($urls.no_picture_image.bySize.default_xl.sources.avif)}
        <source 
          srcset="
            {$urls.no_picture_image.bySize.default_xl.sources.avif} 400w,
            {$urls.no_picture_image.bySize.product_main.sources.avif} 720w"
          sizes="(min-width: 992px) 50vw, (min-width: 360px) 33vw, 100vw"
          type="image/avif"
        >
      {/if}

      {if isset($urls.no_picture_image.bySize.default_xl.sources.webp)}
        <source 
          srcset="
            {$urls.no_picture_image.bySize.default_xl.sources.webp} 400w,
            {$urls.no_picture_image.bySize.product_main.sources.webp} 720w"
          sizes="(min-width: 992px) 50vw, (min-width: 360px) 33vw, 100vw"
          type="image/webp"
        >
      {/if}

      <img
        class="img-fluid"
        srcset="
          {$urls.no_picture_image.bySize.default_xl.url} 400w,
          {$urls.no_picture_image.bySize.product_main.url} 720w"
        sizes="(min-width: 992px) 50vw, (min-width: 360px) 33vw, 100vw"
        width="{$urls.no_picture_image.bySize.product_main.width}"
        height="{$urls.no_picture_image.bySize.product_main.height}"
        src="{$urls.no_picture_image.bySize.default_xl.url}" 
        loading="lazy"
        alt="{l s='No image available' d='Shop.Theme.Catalog'}"
        title="{l s='No image available' d='Shop.Theme.Catalog'}"
      >
    </picture>
  {/if}

  {block name='product_images_modal'}
    {include file='catalog/_partials/product-images-modal.tpl'}
  {/block}
</div>
