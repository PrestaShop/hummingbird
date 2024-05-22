{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<div class="product__images js-images-container">
  {if $product.images|@count > 0}
    <div
      id="product-images"
      class="carousel slide js-product-carousel"
      data-bs-ride="carousel"
      >

      <div class="carousel-inner">
        {include file='catalog/_partials/product-flags.tpl'}

        {if $product.images|@count > 1}
          <button class="carousel-control-prev" type="button" data-bs-target="#product-images" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
          </button>

          <button class="carousel-control-next" type="button" data-bs-target="#product-images" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
          </button>
        {/if}

        {block name='product_cover'}
          {foreach from=$product.images item=image key=key name=productImages}
            <div class="carousel-item{if $image.id_image == $product.default_image.id_image} active{/if}"
              data-bs-target="#product-images-modal"
              data-bs-slide-to="{$key}"
              >
              <picture>
                {if isset($image.bySize.default_md.sources.avif)}
                  <source 
                    srcset="
                      {$image.bySize.default_md.sources.avif} 320w,
                      {$image.bySize.product_main.sources.avif} 720w,
                      {$image.bySize.product_main_2x.sources.avif} 1440w"
                    sizes="(min-width: 1300px) 720px, (min-width: 768px) 50vw, 100vw" 
                    type="image/avif"
                  >
                {/if}

                {if isset($image.bySize.default_md.sources.webp)}
                  <source 
                    srcset="
                      {$image.bySize.default_md.sources.webp} 320w,
                      {$image.bySize.product_main.sources.webp} 720w,
                      {$image.bySize.product_main_2x.sources.webp} 1440w"
                    sizes="(min-width: 1300px) 720px, (min-width: 768px) 50vw, 100vw" 
                    type="image/webp"
                  >
                {/if}

                <img
                  class="img-fluid"
                  srcset="
                    {$image.bySize.default_md.url} 320w,
                    {$image.bySize.product_main.url} 720w,
                    {$image.bySize.product_main_2x.url} 1440w"
                  sizes="(min-width: 1300px) 720px, (min-width: 768px) 50vw, 100vw" 
                  src="{$image.bySize.product_main.url}" 
                  width="{$image.bySize.product_main.width}"
                  height="{$image.bySize.product_main.height}"
                  loading="{if $smarty.foreach.productImages.first}eager{else}lazy{/if}"
                  alt="{$image.legend}"
                  title="{$image.legend}"
                  data-full-size-image-url="{$image.bySize.home_default.url}"
                >
              </picture>

              <div class="product__images__modal-opener" data-bs-toggle="modal" data-bs-target="#product-modal">
                <i class="material-icons zoom-in">search</i>
              </div>
            </div>
          {/foreach}
        {/block}
      </div>
    </div>

    {block name='product_images'}
      <div class="thumbnails__container">
        <ul class="thumbnails__list row g-2">
          {foreach from=$product.images item=image key=key}
            <li
              class="thumbnail js-thumb-container{if $image.id_image == $product.default_image.id_image} active{/if} col-3 col-md-2"
              data-bs-target="#product-images"
              data-bs-slide-to="{$key}"
              {if $image.id_image == $product.default_image.id_image}
                aria-current="true"
              {/if}
              aria-label="{l s='Product image %number%' d='Shop.Theme.Catalog' sprintf=['%number%' => $key]}"
          >
              <picture>
                {if isset($image.bySize.default_xs.sources.avif)}
                  <source 
                    srcset="
                      {$image.bySize.default_xs.sources.avif},
                      {$image.bySize.default_m.sources.avif} 2x",
                  type="image/avif"
                  >
                {/if}

                {if isset($image.bySize.default_xs.sources.webp)}
                  <source 
                    srcset="
                      {$image.bySize.default_xs.sources.webp},
                      {$image.bySize.default_m.sources.webp} 2x"
                    type="image/webp"
                  >
                {/if}

                <img
                  class="img-fluid js-thumb{if $image.id_image == $product.default_image.id_image} js-thumb-selected{/if}"
                  srcset="
                    {$image.bySize.default_xs.url},
                    {$image.bySize.default_m.url} 2x"
                  width="{$image.bySize.default_xs.width}"
                  height="{$image.bySize.default_xs.height}"
                  loading="lazy"
                  alt="{$image.legend}"
                  title="{$image.legend}"
                >
              </picture>
            </li>
          {/foreach}
        </ul>
      </div>
    {/block}

    {hook h='displayAfterProductThumbs' product=$product}
  {else}
    <picture>
      {if isset($urls.no_picture_image.bySize.default_md.sources.avif)}
        <source 
          srcset="
            {$urls.no_picture_image.bySize.default_md.sources.avif} 320w,
            {$urls.no_picture_image.bySize.product_main.sources.avif} 720w,
            {$urls.no_picture_image.bySize.product_main_2x.sources.avif} 1440w"
          sizes="(min-width: 1300px) 720px, (min-width: 768px) 50vw, 100vw" 
          type="image/avif"
        >
      {/if}

      {if isset($urls.no_picture_image.bySize.default_md.sources.webp)}
        <source 
          srcset="
            {$urls.no_picture_image.bySize.default_md.sources.webp} 320w,
            {$urls.no_picture_image.bySize.product_main.sources.webp} 720w,
            {$urls.no_picture_image.bySize.product_main_2x.sources.webp} 1440w"
          sizes="(min-width: 1300px) 720px, (min-width: 768px) 50vw, 100vw" 
          type="image/webp"
        >
      {/if}

      <img
        class="img-fluid"
        srcset="
          {$urls.no_picture_image.bySize.default_md.url} 320w,
          {$urls.no_picture_image.bySize.product_main.url} 720w,
          {$urls.no_picture_image.bySize.product_main_2x.url} 1440w"
        sizes="(min-width: 1300px) 720px, (min-width: 768px) 50vw, 100vw" 
        width="{$urls.no_picture_image.bySize.product_main.width}"
        height="{$urls.no_picture_image.bySize.product_main.height}"
        src="{$urls.no_picture_image.bySize.default_md.url}" 
        loading="lazy"
        alt="{l s='No image available' d='Shop.Theme.Catalog'}"
        title="{l s='No image available' d='Shop.Theme.Catalog'}"
      >
    </picture>
  {/if}
</div>

{block name='product_images_modal'}
  {include file='catalog/_partials/product-images-modal.tpl'}
{/block}
