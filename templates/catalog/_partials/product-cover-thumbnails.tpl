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
              <img
                class="img-fluid"
                src="{$image.bySize.large_default.url}"
                {if !empty($image.legend)}
                  alt="{$image.legend}"
                  title="{$image.legend}"
                {else}
                  alt="{$product.name}"
                {/if}
                loading="lazy">
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
              <img
                class="img-fluid js-thumb{if $image.id_image == $product.default_image.id_image} js-thumb-selected{/if}"
                data-image-medium-src="{$image.bySize.medium_default.url}"
                data-image-large-src="{$image.bySize.large_default.url}"
                src="{$image.bySize.home_default.url}"
                {if !empty($image.legend)}
                  alt="{$image.legend}"
                  title="{$image.legend}"
                {else}
                  alt="{$product.name}"
                {/if}
                loading="lazy"
            >
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
