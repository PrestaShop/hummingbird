{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<div class="modal fade js-product-images-modal" id="product-modal">
  <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-body">
        <div
          id="product-images-modal"
          class="carousel slide js-product-images-modal-carousel"
          data-bs-ride="carousel"
        >
          <div class="carousel-inner">
            {if $product.images|@count > 1}
              <button class="carousel-control-prev" type="button" data-bs-target="#product-images-modal" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
              </button>

              <button class="carousel-control-next" type="button" data-bs-target="#product-images-modal" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
              </button>
            {/if}

            {foreach from=$product.images item=image key=key name=productImages}
              <div class="carousel-item{if $image.id_image == $product.default_image.id_image} active{/if}">
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
              </div>
            {/foreach}
          </div>
        </div>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
