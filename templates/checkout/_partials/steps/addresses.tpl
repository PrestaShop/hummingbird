{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file='checkout/_partials/steps/checkout-step.tpl'}

{block name='step_content'}
  <div class="js-address-form">
    <form
      method="POST"
      action="{url entity='order' params=['id_address' => $id_address]}"
      data-refresh-url="{url entity='order' params=['ajax' => 1, 'action' => 'addressForm', 'id_address' => $id_address]}"
   >
      {if $use_same_address}
        <p>
          {if $cart.is_virtual}
            {l s='The selected address will be used as your personal address (for invoice).' d='Shop.Theme.Checkout'}
          {else}
            {l s='The selected address will be used both as your personal address (for invoice) and as your delivery address.' d='Shop.Theme.Checkout'}
          {/if}
        </p>
      {else}
        <p class="h4">{l s='Shipping Address' d='Shop.Theme.Checkout'}</p>
      {/if}

      {if $show_delivery_address_form}
        <div id="delivery-address">
          {render file                      = 'checkout/_partials/address-form.tpl'
            ui                        = $address_form
            use_same_address          = $use_same_address
            type                      = "delivery"
            form_has_continue_button  = $form_has_continue_button
          }
        </div>
      {elseif $customer.addresses|count> 0}
        <div id="delivery-addresses" class="address-selector js-address-selector row">
          {include  file        = 'checkout/_partials/address-selector-block.tpl'
            addresses   = $customer.addresses
            name        = "id_address_delivery"
            selected    = $id_address_delivery
            type        = "delivery"
            interactive = !$show_delivery_address_form and !$show_invoice_address_form
          }
        </div>

        {if isset($delivery_address_error)}
          <p class="alert alert-danger js-address-error" name="alert-delivery" id="id-failure-address-{$delivery_address_error.id_address}">{$delivery_address_error.exception}</p>
        {else}
          <p class="alert alert-danger js-address-error" name="alert-delivery" style="display: none">{l s='Your address is incomplete, please update it.' d='Shop.Notifications.Error'}</p>
        {/if}

        <a href="{$new_address_delivery_url}" class="btn btn-outline-primary btn-with-icon w-100 w-md-auto mb-3">
          <i class="material-icons" aria-hidden="true">&#xE145;</i>
          {l s='Add new address' d='Shop.Theme.Actions'}
        </a>

        {if $use_same_address && !$cart.is_virtual}
          <a data-link-action="different-invoice-address" href="{$use_different_address_url}" class="d-block">
            {l s='Billing address differs from shipping address' d='Shop.Theme.Checkout'}
          </a>
        {/if}
      {/if}

      {if !$use_same_address}
        <p class="h4 mt-4">{l s='Your Invoice Address' d='Shop.Theme.Checkout'}</p>

        {if $show_invoice_address_form}
          <div id="invoice-address">
            {render file                      = 'checkout/_partials/address-form.tpl'
              ui                        = $address_form
              use_same_address          = $use_same_address
              type                      = "invoice"
              form_has_continue_button  = $form_has_continue_button
            }
          </div>
        {else}
          <div id="invoice-addresses" class="row address-selector js-address-selector">
            {include  file        = 'checkout/_partials/address-selector-block.tpl'
              addresses   = $customer.addresses
              name        = "id_address_invoice"
              selected    = $id_address_invoice
              type        = "invoice"
              interactive = !$show_delivery_address_form and !$show_invoice_address_form
            }
          </div>

          {if isset($invoice_address_error)}
            <p class="alert alert-danger js-address-error" name="alert-invoice" id="id-failure-address-{$invoice_address_error.id_address}">{$invoice_address_error.exception}</p>
          {else}
            <p class="alert alert-danger js-address-error" name="alert-invoice" style="display: none">{l s='Your address is incomplete, please update it.' d='Shop.Notifications.Error'}</p>
          {/if}

          <a href="{$new_address_invoice_url}" class="btn btn-outline-primary btn-with-icon w-100 w-md-auto">
            <i class="material-icons" aria-hidden="true">&#xE145;</i>
            {l s='Add new address' d='Shop.Theme.Actions'}
          </a>
        {/if}

      {/if}

      <div class="mt-4 d-flex flex-wrap justify-content-between">
        <button class="btn btn-outline-primary btn-with-icon w-100 w-md-auto mb-3 mb-md-0 js-back" data-step="checkout-personal-information-step">
          <i class="material-icons rtl-flip" aria-hidden="true">arrow_backward</i>
          {l s='Back to Personal Information' d='Shop.Theme.Actions'}
        </button>

        {if !$form_has_continue_button}
            <button type="submit" class="btn btn-primary btn-with-icon w-100 w-md-auto continue" name="confirm-addresses" value="1">
              {l s='Continue to Shipping' d='Shop.Theme.Actions'}
              <div class="material-icons rtl-flip" aria-hidden="true">arrow_forward</div>
            </button>

            <input type="hidden" id="not-valid-addresses" class="js-not-valid-addresses" value="{$not_valid_addresses}">
        {/if}
      </div>
    </form>
  </div>
{/block}
