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

  {* ===== Terms & conditions ===== *}
  {if $conditions_to_approve|count}
    <section class="one-page-checkout__section">
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
    </section>
  {/if}

  {* ===== Pay button ===== *}
  <div class="one-page-checkout__footer">
    <button class="one-page-checkout__submit btn btn-primary btn-lg w-100" type="submit" id="opc-pay-button" disabled>
      {l s='Pay' d='Shop.Theme.Checkout'} {$cart.totals.total.value}
    </button>
  </div>

</form>
