{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<div id="quickview-modal-{$product.id}-{$product.id_product_attribute}" class="modal fade quickview in" tabindex="-1" role="dialog" aria-hidden="true" data-id-product="{$product.id}" data-ps-ref="quickview-modal" aria-labelledby="quickview-modal-{$product.id}-title">
  <div class="quickview__dialog modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable" role="document">
    <div class="quickview__content modal-content">
      <div class="quickview__header modal-header">
        <p class="h2 modal-title visually-hidden" id="quickview-modal-{$product.id}-title">{$product.name} {l s='quick view' d='Shop.Theme.Catalog'}</p>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{l s='Close' d='Shop.Theme.Global'}"></button>

        {* For screen readers *}
        <p class="visually-hidden" aria-live="polite" role="status" data-ps-target="quickview-modal-status" data-ps-data="{l s='%product_name% quick view.' sprintf=['%product_name%' => $product.name] d='Shop.Theme.Checkout'}"></p>
      </div>

      <div class="quickview__body modal-body page-product page-product--quickview">
        <div class="product__left">
          {block name='product_cover_thumbnails'}
            {include file='catalog/_partials/product-cover-thumbnails.tpl'}
          {/block}
        </div>

        <div class="product__right">
          <p class="product__name h2 {if !empty($product_manufacturer->name) && !empty($product_brand_url)}mb-1{/if}">
            {$product.name}
          </p>

          {block name='product_manufacturer'}
            {if !empty($product_manufacturer->name) && !empty($product_brand_url)}
              <div class="product__manufacturer">
                <a href="{$product_brand_url}" aria-label="{l s='Product brand: %brand_name%' sprintf=['%brand_name%' => $product_manufacturer->name] d='Shop.Theme.Catalog'}">
                  {$product_manufacturer->name}
                </a>
              </div>
            {/if}
          {/block}

          {block name='product_prices'}
            {include file='catalog/_partials/product-prices.tpl'}
          {/block}

          {block name='product_description_short'}
            {if $product.description_short}
              <div class="product__description-short">{$product.description_short nofilter}</div>
            {/if}
          {/block}

          {block name='product_customization'}
            {if $product.is_customizable && count($product.customizations.fields)}
              {include file='catalog/_partials/product-customization.tpl' customizations=$product.customizations}
            {/if}
          {/block}

          {block name='product_buy'}
            <div class="product__actions js-product-actions">
              <form action="{$urls.pages.cart}" method="post" id="add-to-cart-or-refresh">
                <input type="hidden" name="token" value="{$static_token}">
                <input type="hidden" name="id_product" value="{$product.id}" id="product_page_product_id">
                <input type="hidden" name="id_customization" value="{$product.id_customization}"
                  id="product_customization_id" class="js-product-customization-id">

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

      <div class="quickview__footer modal-footer">
        {capture name="social_share"}{widget name="ps_sharebuttons"}{/capture}
        {if !empty($smarty.capture.social_share)}
          {$smarty.capture.social_share nofilter}
        {/if}

        <a class="quickview__details-link" href="{$product.url|escape:'htmlall':'UTF-8'}">
          <span>{l s='All details' d='Shop.Theme.Catalog'}</span>
          <i class="material-icons" aria-hidden="true">chevron_right</i>
        </a>
      </div>
    </div>
  </div>
</div>
