{**
 * One Page Checkout - Layout
 * Thin wrapper: <form> + {render} + submit button.
 * All sections are rendered inside one-page-checkout-form.tpl via {render ui=$opc_form}.
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<form class="one-page-checkout" method="POST" action="{$urls.pages.order}" data-ps-action="form-validation">
  <input type="hidden" name="submitOnePageCheckout" value="1">

  <div class="js-opc-address-form">
    {render ui=$opc_form}
  </div>

  {* ===== Delivery method ===== *}
  <section class="one-page-checkout__section">
    <h2 class="one-page-checkout__title">{l s='Delivery method' d='Shop.Theme.Checkout'}</h2>

    <div id="delivery-options__hook">
      {if isset($hookDisplayBeforeCarrier)}
        {$hookDisplayBeforeCarrier nofilter}
      {else}
        {hook h='displayBeforeCarrier'}
      {/if}
    </div>

    <div class="one-page-checkout__placeholder" id="opc-delivery-methods">
      <div class="card card-body bg-light">
        {l s='You will see the available delivery methods once you\'ve entered your delivery address.' d='Shop.Theme.Checkout'}
      </div>
    </div>

    <div class="delivery-options__display-after-carrier" id="hook-display-after-carrier">
      {if isset($hookDisplayAfterCarrier)}
        {$hookDisplayAfterCarrier nofilter}
      {else}
        {hook h='displayAfterCarrier'}
      {/if}
    </div>

    <div class="delivery-options__extra-carrier" id="extra_carrier"></div>
  </section>

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
      {l s='Pay' d='Shop.Theme.Checkout'} {$cart.totals.total.value}
    </button>

    {hook h='displayPaymentByBinaries'}
  </div>

</form>
