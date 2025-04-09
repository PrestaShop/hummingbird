{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<div id="blockcart-modal" class="blockcart-modal modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <p class="blockcart-modal__title h2 modal-title" id="myModalLabel">
          <i class="blockcart-modal__title-icon material-icons" aria-hidden="true">&#xE5CA;</i>
          {l s='Added to your cart' d='Shop.Theme.Checkout'}
        </p>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{l s='Close' d='Shop.Theme.Global'}"></button>
      </div>

      <div class="modal-body">
        <div class="row">
          <div class="blockcart-modal__product col-lg-7">
            <div class="row">
              <div class="col-xs-4 col-lg-5">
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
                  class="blockcart-modal__image img-fluid"
                />
              </div>

              <div class="col-xs-8 col-lg-7">
                <div class="blockcart-modal__name">{$product.name}</div>
                <div class="blockcart-modal__price d-none d-lg-block">{$product.price}</div>
                {hook h='displayProductPriceBlock' product=$product type="unit_price"}
                {foreach from=$product.attributes item="property_value" key="property"}
                  <div class="blockcart-modal__property {$property|lower}">
                    {l s='%label%:' sprintf=['%label%' => $property] d='Shop.Theme.Global'}&nbsp;{$property_value}
                  </div>
                {/foreach}
                <div class="blockcart-modal__quantity d-none d-lg-block">{l s='Quantity:' d='Shop.Theme.Checkout'}&nbsp;{$product.cart_quantity}</div>
                <div class="blockcart-modal__price d-block d-lg-none">{$product.price}</div>
              </div>
            </div>
          </div>

          <div class="blockcart-modal__summary d-none d-lg-block col-lg-5">
            {if $cart.products_count > 1}
              <div class="blockcart-modal__nb-products">
                {l s='There are %products_count% items in your cart.' sprintf=['%products_count%' => $cart.products_count] d='Shop.Theme.Checkout'}
              </div>
            {else}
              <div class="blockcart-modal__nb-products">
                {l s='There is %products_count% item in your cart.' sprintf=['%products_count%' =>$cart.products_count] d='Shop.Theme.Checkout'}
              </div>
            {/if}
            <div class="blockcart-modal__total">
              <span class="label">{l s='Subtotal:' d='Shop.Theme.Checkout'}</span>
              <span class="subtotals value">{$cart.subtotals.products.value}</span>
            </div>
            {if $cart.subtotals.shipping.value}
              <div class="blockcart-modal__total">
                <span class="label">{l s='Shipping:' d='Shop.Theme.Checkout'}</span>
                <span class="shipping value">{$cart.subtotals.shipping.value} {hook h='displayCheckoutSubtotalDetails' subtotal=$cart.subtotals.shipping}</span>
              </div>
            {/if}
            {if !$configuration.display_prices_tax_incl && $configuration.taxes_enabled}
              <div class="blockcart-modal__total blockcart-modal__total--bold">
                <span class="label">{$cart.totals.total.label}{if $configuration.display_taxes_label}&nbsp;{$cart.labels.tax_short}{/if}</span>
                <span class="value">{$cart.totals.total.value}</span>
              </div>
              <div class="blockcart-modal__total blockcart-modal__total--bold">
                <span class="label">{$cart.totals.total_including_tax.label}</span>
                <span class="value">{$cart.totals.total_including_tax.value}</span>
              </div>
            {else}
              <div class="blockcart-modal__total blockcart-modal__total--bold">
                <span class="label">{$cart.totals.total.label}&nbsp;{if $configuration.taxes_enabled && $configuration.display_taxes_label}{$cart.labels.tax_short}{/if}</span>
                <span class="value">{$cart.totals.total.value}</span>
              </div>
            {/if}
            {if $cart.subtotals.tax}
              <div class="blockcart-modal__total blockcart-modal__total--bold">
                <span>{l s='%label%:' sprintf=['%label%' => $cart.subtotals.tax.label] d='Shop.Theme.Global'}</span>
                <span class="value">{$cart.subtotals.tax.value}</span>
              </div>
            {/if}
            <div class="blockcart-modal__extra">
              {hook h='displayCartModalContent' product=$product}
            </div>
          </div>
        </div>
      </div>

      <div class="modal-footer modal-footer--split-buttons modal-footer--revert-order-mobile">
        <button type="button" class="btn btn-outline-primary btn-with-icon" data-bs-dismiss="modal">
          {l s='Continue shopping' d='Shop.Theme.Actions'}
        </button>

        <a href="{$cart_url|escape:'htmlall':'UTF-8'}" class="btn btn-primary">{l s='Proceed to checkout' d='Shop.Theme.Actions'}</a>

        {capture name='cart_modal_footer'}{hook h='displayCartModalFooter' product=$product}{/capture}
        {if $smarty.capture.cart_modal_footer}
          <div class="blockcart-modal__cart-footer-extra">
            {$smarty.capture.cart_modal_footer nofilter}
          </div>
        {/if}
      </div>
    </div>
  </div>
</div>
