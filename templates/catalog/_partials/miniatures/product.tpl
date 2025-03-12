{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$componentName = 'product-miniature'}

{block name='product_miniature_item'}
  <article
    class="{$componentName} js-{$componentName}"
    data-id-product="{$product.id_product}"
    data-id-product-attribute="{$product.id_product_attribute}"
  >
    <div class="{$componentName}__inner">
      {block name='product_miniature_top'}
        <div class="{$componentName}__top">
          {include file='catalog/_partials/product-flags.tpl'}

          {include file='catalog/_partials/miniatures/product-image.tpl'}

          {include file='catalog/_partials/miniatures/product-quickview.tpl'}
        </div>
      {/block}

      {block name='product_miniature_bottom'}
        <div class="{$componentName}__bottom">
          <div class="{$componentName}__infos">
            {block name='product_name'}
              <a class="{$componentName}__title" href="{$product.url}">{$product.name}</a>
            {/block}

            {block name='product_variants'}
              {if $product.main_variants}
                <div class="{$componentName}__variants">
                  {include file='catalog/_partials/variant-links.tpl' variants=$product.main_variants}
                </div>
              {/if}
            {/block}

            {block name='product_reviews'}
              {hook h='displayProductListReviews' product=$product}
            {/block}

            {if $product.show_price}
              <div class="{$componentName}__prices">
                {block name='product_price'}
                  {hook h='displayProductPriceBlock' product=$product type="before_price"}

                  <div class="{$componentName}__price" aria-label="{l s='Price' d='Shop.Theme.Catalog'}">
                    {capture name='custom_price'}{hook h='displayProductPriceBlock' product=$product type='custom_price' hook_origin='products_list'}{/capture}
                    {if '' !== $smarty.capture.custom_price}
                      {$smarty.capture.custom_price nofilter}
                    {else}
                      {$product.price}
                    {/if}
                  </div>

                  {hook h='displayProductPriceBlock' product=$product type='unit_price'}

                  {hook h='displayProductPriceBlock' product=$product type='weight'}
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
            {/if}
          </div>

          <div class="{$componentName}__actions">
            {if $product.add_to_cart_url}
              <form class="{$componentName}__form" action="{$urls.pages.cart}" method="post">
                <input type="hidden" value="{$product.id_product}" name="id_product">
                <input type="hidden" name="token" value="{$static_token}" />

                <div class="quantity-button js-quantity-button">
                  {include file='components/qty-input.tpl'
                    attributes=[
                      "id" => "quantity_wanted_{$product.id_product}",
                      "value" => "{$product.minimal_quantity}",
                      "min" => "{$product.minimal_quantity}"
                    ]
                    marginHelper="mb-0"
                  }
                </div>

                <button data-button-action="add-to-cart" class="product-miniature__add btn btn-primary btn-square-icon">
                  <i class="material-icons" aria-hidden="true">&#xe854;</i>
                  <span class="product-miniature__add-text">{l s='Add to cart' d='Shop.Theme.Actions'}</span>
                </button>
              </form>
            {else}
              <a href="{$product.url}" class="product-miniature__details btn btn-outline-primary">
                {l s='See details' d='Shop.Theme.Actions'}
              </a>
            {/if}
          </div>
        </div>
      {/block}
    </div>
  </article>
{/block}
