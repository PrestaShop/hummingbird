{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<div id="quickview-modal-{$product.id}-{$product.id_product_attribute}" class="modal fade quickview" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable" role="document">
   <div class="modal-content">
     <div class="modal-header">
       <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{l s='Close' d='Shop.Theme.Global'}"></button>
     </div>
     <div class="modal-body page-product">
      <div class="row">
        <div class="col-sm-6">
          {block name='product_cover_thumbnails'}
            {include file='catalog/_partials/product-cover-thumbnails.tpl'}
          {/block}
        </div>
        <div class="col-sm-6">
          <p class="h3">{$product.name}</p>
          {block name='product_prices'}
            {include file='catalog/_partials/product-prices.tpl'}
          {/block}
          {block name='product_description_short'}
            <div id="product-description-short">{$product.description_short nofilter}</div>
          {/block}
          {block name='product_customization'}
            {if $product.is_customizable && count($product.customizations.fields)}
              {include file='catalog/_partials/product-customization.tpl' customizations=$product.customizations}
            {/if}
          {/block}
          {block name='product_buy'}
            <div class="product-actions js-product-actions">
              <form action="{$urls.pages.cart}" method="post" id="add-to-cart-or-refresh">
                <input type="hidden" name="token" value="{$static_token}">
                <input type="hidden" name="id_product" value="{$product.id}" id="product_page_product_id">
                <input type="hidden" name="id_customization" value="{$product.id_customization}" id="product_customization_id" class="js-product-customization-id">
                {block name='product_variants'}
                  {include file='catalog/_partials/product-variants.tpl'}
                {/block}

                {block name='product_add_to_cart'}
                  {include file='catalog/_partials/product-add-to-cart.tpl'}
                {/block}

                {* Input to refresh product HTML removed, block kept for compatibility with themes *}
                {block name='product_refresh'}{/block}
            </form>
          </div>
        {/block}
        </div>
      </div>
     </div>
     <div class="modal-footer border-1">
        <div class="product-additional-info js-product-additional-info d-flex flex-wrap align-items-center justify-content-between w-100">
          <div class="product-additional-info--start">
            {hook h='displayProductAdditionalInfo' product=$product}
          </div>
          <div class="product-additional-info--end">
            <a href="{$product.url}" class="d-inline-flex align-items-center">{l s='All details' d='Shop.Theme.Catalog'} <div class="material-icons" aria-hidden="true">chevron_right</div></a>
          </div>
        </div>
    </div>
   </div>
 </div>
</div>
