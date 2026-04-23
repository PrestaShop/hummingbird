{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}

{**
 * One Page Checkout - Layout
 *}

<form id="opc-form" class="one-page-checkout" method="POST" action="{$urls.pages.order}" data-ps-action="form-validation">
  {include file='_partials/form-errors.tpl' errors=$errors['']}
  {include file='_partials/form-errors.tpl' errors=$validation_error_messages|default:[]}

  <div class="js-opc-contact-section">
    {include file='checkout/_partials/one-page-checkout/contact-section.tpl'}
  </div>

  <div class="js-opc-addresses-section">
    {include file='checkout/_partials/one-page-checkout/addresses-section.tpl'}
  </div>

  {* ===== Delivery method ===== *}
  {if !$is_virtual_cart}
    {include file='checkout/_partials/one-page-checkout/delivery-section.tpl'
      delivery_options=$delivery_options
      delivery_option=$delivery_option
      id_address_delivery=$cart.id_address_delivery|intval
      hookDisplayBeforeCarrier=$hookDisplayBeforeCarrier|default:null
      hookDisplayAfterCarrier=$hookDisplayAfterCarrier|default:null
      delivery_message=$delivery_message|default:''
      recyclablePackAllowed=$recyclablePackAllowed|default:false
      recyclable=$recyclable|default:false
      gift=$gift|default:[]
    }
  {/if}

</form>

{* Payment section is rendered outside the main form to avoid nested payment forms. *}
{include file='checkout/_partials/one-page-checkout/payment-section.tpl'
  payment_options=$payment_options|default:[]
  is_free=$is_free|default:false
  selected_payment_module=$selected_payment_module|default:''
  selected_payment_selection_key=$selected_payment_selection_key|default:''
}

<div class="one-page-checkout__footer">
  {* ===== Terms & conditions ===== *}
  {if $conditions_to_approve|count}
    {foreach from=$conditions_to_approve item="condition" key="condition_name"}
      <div class="form-check">
        <input id="conditions_to_approve[{$condition_name}]"
               name="conditions_to_approve[{$condition_name}]"
               required
               type="checkbox"
               value="1"
               class="form-check-input"
        >
        <label class="js-terms form-check-label" for="conditions_to_approve[{$condition_name}]">
          {$condition nofilter}
        </label>
      </div>
    {/foreach}
  {/if}

  {hook h='displayCheckoutBeforeConfirmation'}

  {* ===== Pay button ===== *}
  <button class="one-page-checkout__submit btn btn-primary btn-lg w-100" type="button" id="opc-pay-button" disabled>
    {l s='Pay' d='Shop.Theme.Checkout'} <span id="opc-pay-amount">{$cart.totals.total.value}</span>
  </button>

  {hook h='displayPaymentByBinaries'}
</div>
