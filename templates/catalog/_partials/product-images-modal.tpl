{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<div class="product-images-modal modal fade js-product-images-modal" id="product-modal" tabindex="-1" aria-labelledby="product-modal-images-title" data-ps-ref="product-images-modal">
  <div class="modal-dialog modal-xl modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <p class="h2 modal-title visually-hidden" id="product-modal-images-title">{$product.name} {l s='images' d='Shop.Theme.Catalog'}</p>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="product-images-modal__body modal-body">
        <div
          id="product-images-modal-{$product.id}"
          class="product-images-modal__carousel carousel slide js-product-images-modal-carousel"
          data-ps-ref="product-images-modal-carousel"
        >
          <div class="carousel-inner">
            {foreach from=$product.images item=image key=key name=productImages}
              <div class="carousel-item{if $image.id_image == $product.default_image.id_image} active{/if}">
                <picture>
                  {if isset($image.bySize.default_md.sources.avif)}
                    <source 
                      srcset="
                        {$image.bySize.default_md.sources.avif} 320w,
                        {$image.bySize.product_main.sources.avif} 720w,
                        {$image.bySize.product_main_2x.sources.avif} 1440w"
                      sizes="(min-width: 1200px) 1440px, (min-width: 768px) 720px, 100vw" 
                      type="image/avif"
                    >
                  {/if}

                  {if isset($image.bySize.default_md.sources.webp)}
                    <source 
                      srcset="
                        {$image.bySize.default_md.sources.webp} 320w,
                        {$image.bySize.product_main.sources.webp} 720w,
                        {$image.bySize.product_main_2x.sources.webp} 1440w"
                      sizes="(min-width: 1200px) 1440px, (min-width: 768px) 720px, 100vw" 
                      type="image/webp"
                    >
                  {/if}

                  <img
                    class="img-fluid"
                    srcset="
                      {$image.bySize.default_md.url} 320w,
                      {$image.bySize.product_main.url} 720w,
                      {$image.bySize.product_main_2x.url} 1440w"
                    sizes="(min-width: 1200px) 1440px, (min-width: 768px) 720px, 100vw" 
                    src="{$image.bySize.product_main.url}" 
                    width="{$image.bySize.product_main_2x.width}"
                    height="{$image.bySize.product_main_2x.height}"
                    loading="{if $smarty.foreach.productImages.first}eager{else}lazy{/if}"
                    alt="{$image.legend}"
                    title="{$image.legend}"
                    data-full-size-image-url="{$image.bySize.home_default.url}"
                  >
                </picture>
              </div>
            {/foreach}
          </div>

          {if $product.images|@count > 1}
            <button class="carousel-control-prev outline outline--rounded" type="button" data-bs-target="#product-images-modal-{$product.id}" data-bs-slide="prev">
              <span class="carousel-control-prev-icon" aria-hidden="true"></span>
              <span class="visually-hidden">{l s='Previous image' d='Shop.Theme.Global'}</span>
            </button>

            <button class="carousel-control-next outline outline--rounded" type="button" data-bs-target="#product-images-modal-{$product.id}" data-bs-slide="next">
              <span class="carousel-control-next-icon" aria-hidden="true"></span>
              <span class="visually-hidden">{l s='Next image' d='Shop.Theme.Global'}</span>
            </button>
          {/if}
        </div>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
