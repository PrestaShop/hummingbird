{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<div class="product__images js-images-container">
  {if $product.images|@count > 0}
    <div id="product-images" class="carousel slide js-product-carousel"
      data-bs-ride="carousel" data-bs-interval="false">

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
          {foreach from=$product.images item=image key=key}
            <div class="carousel-item{if $image.id_image == $product.default_image.id_image} active{/if}">
              <picture>
                {if isset($image.bySize.default_320.sources.avif)}
                  <source 
                    srcset="
                      {$image.bySize.default_320.sources.avif} 320w,
                      {$image.bySize.default_720.sources.avif} 720w,
                      {$image.bySize.default_1440.sources.avif} 1440w"
                    sizes="(min-width: 1300px) 720px, (min-width: 768px) 50vw, 100vw" 
                    type="image/avif"
                  >
                {/if}

                {if isset($image.bySize.default_320.sources.webp)}
                  <source 
                    srcset="
                      {$image.bySize.default_320.sources.webp} 320w,
                      {$image.bySize.default_720.sources.webp} 720w,
                      {$image.bySize.default_1440.sources.webp} 1440w"
                    sizes="(min-width: 1300px) 720px, (min-width: 768px) 50vw, 100vw" 
                    type="image/webp"
                  >
                {/if}

                <img
                  class="img-fluid"
                  srcset="
                    {$image.bySize.default_320.url} 320w,
                    {$image.bySize.default_720.url} 720w,
                    {$image.bySize.default_1440.url} 1440w"
                  sizes="(min-width: 1300px) 720px, (min-width: 768px) 50vw, 100vw" 
                  src="{$image.bySize.default_720.sources.jpg}" 
                  loading="lazy"
                  alt="{if !empty($image)}{$image.legend}{else}{$product.name}{/if}"
                  title="{if !empty($image.legend)}{$image.legend}{else}{$product.name}{/if}"
                  data-full-size-image-url="{$image.bySize.home_default.url}"
              </picture>
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
                {if isset($image.bySize.default_120.sources.avif)}
                  <source 
                    srcset="
                      {$image.bySize.default_120.sources.avif} 120w,
                      {$image.bySize.default_200.sources.avif} 2x"
                    type="image/avif"
                  >
                {/if}

                {if isset($image.bySize.default_120.sources.webp)}
                  <source 
                    srcset="
                      {$image.bySize.default_120.sources.webp} 120w,
                      {$image.bySize.default_200.sources.webp} 2x"
                    type="image/webp"
                  >
                {/if}

                <img
                  class="img-fluid js-thumb{if $image.id_image == $product.default_image.id_image} js-thumb-selected{/if}"
                  srcset="
                    {$image.bySize.default_120.url} 120w,
                    {$image.bySize.default_200.url} 2x"
                  loading="lazy"
                  alt="{if !empty($image)}{$image.legend}{else}{$product.name}{/if}"
                  title="{if !empty($image.legend)}{$image.legend}{else}{$product.name}{/if}"
                >
              </picture>
            </li>
          {/foreach}
        </ul>
      </div>
    {/block}

    {hook h='displayAfterProductThumbs' product=$product}
  {else}
      <img 
        class="img-fluid" 
        src="{$urls.no_picture_image.bySize.large_default.url}" 
        width="{$urls.no_picture_image.bySize.large_default.width}"
        height="{$urls.no_picture_image.bySize.large_default.height}"
        loading="lazy"
      >
  {/if}
</div>
