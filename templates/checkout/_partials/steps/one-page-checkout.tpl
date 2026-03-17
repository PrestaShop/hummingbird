{**
 * One Page Checkout - Layout
 * Thin wrapper: <form> + {render} + submit button.
 * All sections are rendered inside one-page-checkout-form.tpl via {render ui=$opc_form}.
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<form id="opc-form" class="one-page-checkout" method="POST" action="{$urls.pages.order}" data-ps-action="form-validation">
  <input type="hidden" name="submitOnePageCheckout" value="1">

  <div class="js-opc-address-form">
    {render ui=$opc_form}
  </div>

  {* ===== Delivery method ===== *}
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


  {* ===== Payment method ===== *}
  <section class="one-page-checkout__section">
    <h2 class="one-page-checkout__title">{l s='Payment method' d='Shop.Theme.Checkout'}</h2>

    {hook h='displayPaymentTop'}

    <div class="one-page-checkout__placeholder" id="opc-payment-methods">
      <div class="card card-body bg-light">
        {l s='You will see the available payment methods once you\'ve entered your delivery address.' d='Shop.Theme.Checkout'}
      </div>
    </div>
  </section>

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
    <button class="one-page-checkout__submit btn btn-primary btn-lg w-100" type="submit" id="opc-pay-button" disabled>
      {l s='Pay' d='Shop.Theme.Checkout'} <span id="opc-pay-amount">{$cart.totals.total.value}</span>
    </button>

    {hook h='displayPaymentByBinaries'}
  </div>

</form>
