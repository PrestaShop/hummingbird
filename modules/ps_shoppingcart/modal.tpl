{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<div id="blockcart-modal" class="blockcart-modal modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-fullscreen-sm-down" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <p class="h4 modal-title mb-0" id="myModalLabel">
          <i class="material-icons me-1" aria-hidden="true">&#xE5CA;</i>
          {l s='Product successfully added to your shopping cart' d='Shop.Theme.Checkout'}
        </p>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{l s='Close' d='Shop.Theme.Global'}"></button>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-md-7 blockcart-modal__product">
            <div class="row">
              <div class="col-sm-4 col-md-5">
                <img
                  {if $product.default_image}
                    src="{$product.default_image.medium.url}"
                    data-full-size-image-url="{$product.default_image.large.url}"
                    title="{$product.default_image.legend}"
                    alt="{$product.default_image.legend}"
                  {else}
                    src="{$urls.no_picture_image.bySize.medium_default.url}"
                  {/if}
                  loading="lazy"
                  class="img-fluid product-image"
                />
              </div>
              <div class="col-sm-8 col-md-7">
                <p class="h6 product-name">{$product.name}</p>
                <p class="product-price">{$product.price}</p>
                {hook h='displayProductPriceBlock' product=$product type="unit_price"}
                {foreach from=$product.attributes item="property_value" key="property"}
                  <div class="blockcart-modal__property {$property|lower}{if !$property_value@last} mb-1{else} mb-2{/if}">
                    {l s='%label%:' sprintf=['%label%' => $property] d='Shop.Theme.Global'}&nbsp;<strong>{$property_value}</strong>
                  </div>
                {/foreach}
                <div class="product-quantity">{l s='Quantity:' d='Shop.Theme.Checkout'}&nbsp;<strong>{$product.cart_quantity}</strong></div>
              </div>
            </div>
          </div>
          <div class="col-md-5">
            <div class="blockcart-modal__summery">
              {if $cart.products_count> 1}
                <p>
                  {l s='There are %products_count% items in your cart.' sprintf=['%products_count%' => $cart.products_count] d='Shop.Theme.Checkout'}
                </p>
              {else}
                <p>
                  {l s='There is %products_count% item in your cart.' sprintf=['%products_count%' =>$cart.products_count] d='Shop.Theme.Checkout'}
                </p>
              {/if}
              <div class="mb-3">
                <div class="blockcart-modal__total product-subtotal">
                  <span class="label">{l s='Subtotal:' d='Shop.Theme.Checkout'}</span>
                  <span class="subtotals value">{$cart.subtotals.products.value}</span>
                </div>
                {if $cart.subtotals.shipping.value}
                  <div class="blockcart-modal__total product-shipping">
                    <span class="label">{l s='Shipping:' d='Shop.Theme.Checkout'}</span>
                    <span class="shipping value">{$cart.subtotals.shipping.value} {hook h='displayCheckoutSubtotalDetails' subtotal=$cart.subtotals.shipping}</span>
                  </div>
                {/if}
              </div>
              {if !$configuration.display_prices_tax_incl && $configuration.taxes_enabled}
                <div class="blockcart-modal__total product-total">
                  <span class="label">{$cart.totals.total.label}{if $configuration.display_taxes_label}&nbsp;{$cart.labels.tax_short}{/if}</span>
                  <span class="value">{$cart.totals.total.value}</span>
                </div>
                <div class="blockcart-modal__total product-total">
                  <span class="label">{$cart.totals.total_including_tax.label}</span>
                  <span class="value">{$cart.totals.total_including_tax.value}</span>
                </div>
              {else}
                <div class="blockcart-modal__total product-total">
                  <span class="label">{$cart.totals.total.label}&nbsp;{if $configuration.taxes_enabled && $configuration.display_taxes_label}{$cart.labels.tax_short}{/if}</span>
                  <span class="value">{$cart.totals.total.value}</span>
                </div>
              {/if}
              {if $cart.subtotals.tax}
                <div class="blockcart-modal__total product-tax">
                  <span>{l s='%label%:' sprintf=['%label%' => $cart.subtotals.tax.label] d='Shop.Theme.Global'}</span>
                  <span class="value">{$cart.subtotals.tax.value}</span>
                </div>
              {/if}
              <div class="cart-content-extra">
                {hook h='displayCartModalContent' product=$product}
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="modal-footer border-1">
        <div class="cart-footer-actions d-flex flex-wrap align-items-center justify-content-between w-100">
          <button type="button" class="btn btn-outline-primary btn-with-icon w-md-auto w-100 mb-md-0 mb-3" data-bs-dismiss="modal">
            <i class="material-icons rtl-flip" aria-hidden="true">&#xE5CB;</i>
            {l s='Continue shopping' d='Shop.Theme.Actions'}
          </button>
          <a href="{$cart_url}" class="btn btn-primary w-md-auto w-100">{l s='Proceed to checkout' d='Shop.Theme.Actions'}</a>
        </div>    
        <div class="cart-footer-extra d-flex flex-wrap w-100 m-0">
          {hook h='displayCartModalFooter' product=$product}
        </div>
      </div>
    </div>
  </div>
</div>
