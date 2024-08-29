{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$componentName = 'product-miniature'}

{block name='product_miniature_item'}
  <article
    class="{$componentName} js-{$componentName}{if !empty($productClasses)} {$productClasses}{/if}"
    data-id-product="{$product.id_product}"
    data-id-product-attribute="{$product.id_product_attribute}"
  >
    <div class="card">
      <a href="{$product.url}" class="{$componentName}__link">
        {include file='catalog/_partials/product-flags.tpl'}

        {block name='product_miniature_image'}
          <div class="{$componentName}__image-container thumbnail-container">
            {if $product.cover}
              <picture>
                {if isset($product.cover.bySize.default_md.sources.avif)}
                  <source
                    srcset="
                      {$product.cover.bySize.default_xs.sources.avif} 120w,
                      {$product.cover.bySize.default_m.sources.avif} 200w,
                      {$product.cover.bySize.default_md.sources.avif} 320w,
                      {$product.cover.bySize.product_main.sources.avif} 720w"
                    sizes="(min-width: 1300px) 720px, (min-width: 768px) 50vw, 50vw"
                    type="image/avif"
                  >
                {/if}

                {if isset($product.cover.bySize.default_md.sources.webp)}
                  <source
                    srcset="
                      {$product.cover.bySize.default_xs.sources.webp} 120w,
                      {$product.cover.bySize.default_m.sources.webp} 200w,
                      {$product.cover.bySize.default_md.sources.webp} 320w,
                      {$product.cover.bySize.product_main.sources.webp} 720w"
                    sizes="(min-width: 1300px) 320px, (min-width: 768px) 120px, 50vw"
                    type="image/webp"
                  >
                {/if}

                <img
                  class="{$componentName}__image card-img-top"
                  srcset="
                    {$product.cover.bySize.default_xs.url} 120w,
                    {$product.cover.bySize.default_m.url} 200w,
                    {$product.cover.bySize.default_md.url} 320w,
                    {$product.cover.bySize.product_main.url} 720w"
                  sizes="(min-width: 1300px) 320px, (min-width: 768px) 120px, 50vw"
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
              <picture>
                {if isset($urls.no_picture_image.bySize.default_md.sources.avif)}
                  <source
                    srcset="
                      {$urls.no_picture_image.bySize.default_xs.sources.avif} 120w,
                      {$urls.no_picture_image.bySize.default_m.sources.avif} 200w,
                      {$urls.no_picture_image.bySize.default_md.sources.avif} 320w,
                      {$urls.no_picture_image.bySize.product_main.sources.avif} 720w"
                    sizes="(min-width: 1300px) 720px, (min-width: 768px) 50vw, 50vw"
                    type="image/avif"
                  >
                {/if}

                {if isset($urls.no_picture_image.bySize.default_md.sources.webp)}
                  <source
                    srcset="
                      {$urls.no_picture_image.bySize.default_xs.sources.webp} 120w,
                      {$urls.no_picture_image.bySize.default_m.sources.webp} 200w,
                      {$urls.no_picture_image.bySize.default_md.sources.webp} 320w,
                      {$urls.no_picture_image.bySize.product_main.sources.webp} 720w"
                    sizes="(min-width: 1300px) 320px, (min-width: 768px) 120px, 50vw"
                    type="image/webp"
                  >
                {/if}

                <img
                  class="{$componentName}__image card-img-top"
                  srcset="
                    {$urls.no_picture_image.bySize.default_xs.url} 120w,
                    {$urls.no_picture_image.bySize.default_m.url} 200w,
                    {$urls.no_picture_image.bySize.default_md.url} 320w,
                    {$urls.no_picture_image.bySize.product_main.url} 720w"
                  sizes="(min-width: 1300px) 320px, (min-width: 768px) 120px, 50vw"
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
                <i class="material-icons" aria-hidden="true">&#xE417;</i>
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
              <div class="{$componentName}__variants">
                {if $product.main_variants}
                  {include file='catalog/_partials/variant-links.tpl' variants=$product.main_variants}
                {/if}
              </div>
            {/block}

            {block name='product_reviews'}
              {hook h='displayProductListReviews' product=$product}
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

            {if $product.add_to_cart_url}
              <form action="{$urls.pages.cart}" method="post" class="d-flex flex-wrap flex-md-nowrap gap-3 align-items-center mt-3">
                <input type="hidden" value="{$product.id_product}" name="id_product">

                <input type="hidden" name="token" value="{$static_token}" />

                <div class="quantity-button js-quantity-button w-100 w-sm-auto">
                  {include file='components/qty-input.tpl'
                    attributes=[
                      "id" => "quantity_wanted_{$product.id_product}",
                      "value" => "{$product.minimal_quantity}",
                      "min" => "{$product.minimal_quantity}"
                    ]
                    marginHelper="mb-0"
                  }
                </div>

                <button data-button-action="add-to-cart" class="btn btn-primary flex-grow-1 flex-md-grow-0">
                  <i class="material-icons" aria-hidden="true">&#xe854;</i>
                  <span class="visually-hidden">{l s='Add to cart' d='Shop.Theme.Actions'}</span>
                </button>
              </form>
            {else}
              <a href="{$product.url}" class="btn btn-outline-primary mt-3">
                {l s='See details' d='Shop.Theme.Actions'}
              </a>
            {/if}
          </div>
        </div>
      {/block}
    </div>
  </article>
{/block}
