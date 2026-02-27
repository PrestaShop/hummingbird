{**
 * One Page Checkout Form - All sections
 * Rendered via {render ui=$opc_form}, provides $formFields from OnePageCheckoutForm.
 * Contains: contact info, delivery address, billing address.
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{hook h='displayPersonalInformationTop' customer=$customer}

{include file='_partials/form-errors.tpl' errors=$errors['']}

{* ===== Contact information ===== *}
<section class="one-page-checkout__section">
  <h2 class="one-page-checkout__title">{l s='Contact information' d='Shop.Theme.Checkout'}</h2>

  <div class="one-page-checkout__links">
    <a class="one-page-checkout__link" href="{$urls.pages.authentication}?back={$urls.pages.order}">
      {l s='Already have an account? Sign in' d='Shop.Theme.Checkout'}
    </a>
    <a class="one-page-checkout__link" href="{$urls.pages.registration}">
      {l s='Create account' d='Shop.Theme.Checkout'}
    </a>
  </div>

  {if isset($formFields['email'])}
    <div class="one-page-checkout__field">
      <label class="form-label" for="field-email">{l s='Continue as guest' d='Shop.Theme.Checkout'}</label>
      <input class="form-control" type="email" name="email" id="field-email" value="{$formFields['email']['value']}" required>
    </div>
  {/if}

  {if isset($formFields['optin'])}
    <div class="one-page-checkout__field">
      {form_field field=$formFields['optin']}
    </div>
  {/if}
</section>

{* ===== Delivery address fields ===== *}
<section class="one-page-checkout__section">
  <h2 class="one-page-checkout__title">{l s='Delivery address' d='Shop.Theme.Checkout'}</h2>

  <section class="form-fields">
    {include file='checkout/_partials/one-page-checkout/address-fields.tpl'
      formFields=$formFields
      prefix=''
    }

    <input type="hidden" name="saveAddress" value="delivery">

    <div class="form-check">
      <input class="form-check-input js-opc-use-same-address" type="checkbox" id="opc-use-same-address" name="use_same_address" value="1" checked>
      <label class="form-check-label" for="opc-use-same-address">
        {l s='Use this address for invoice too' d='Shop.Theme.Checkout'}
      </label>
    </div>
  </section>
</section>

{* ===== Billing address fields (hidden by default, JS manages visibility) ===== *}
<section class="one-page-checkout__section" id="opc-billing-section" style="display: none;">
  <h2 class="one-page-checkout__title">{l s='Billing address' d='Shop.Theme.Checkout'}</h2>

  <section class="form-fields">
    {include file='checkout/_partials/one-page-checkout/address-fields.tpl'
      formFields=$formFields
      prefix='invoice_'
    }
  </section>
</section>

{capture name="address_selector_bottom"}{hook h='displayAddressSelectorBottom'}{/capture}
{if $smarty.capture.address_selector_bottom}
  {block name='address_selector_bottom'}
    <div class="address-selector-bottom mt-3">
      {$smarty.capture.address_selector_bottom nofilter}
    </div>
  {/block}
{/if}
