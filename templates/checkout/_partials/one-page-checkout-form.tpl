{**
 * One Page Checkout Form - All sections
 * Rendered via {render ui=$opc_form}, provides $formFields from OnePageCheckoutForm.
 * Contains: contact info, delivery address, billing address, delivery/payment placeholders.
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

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

{* ===== Billing address fields (hidden by default) ===== *}
<section class="one-page-checkout__section" id="opc-billing-section" style="display: none;">
  <h2 class="one-page-checkout__title">{l s='Billing address' d='Shop.Theme.Checkout'}</h2>

  <section class="form-fields">
    {include file='checkout/_partials/one-page-checkout/address-fields.tpl'
      formFields=$formFields
      prefix='invoice_'
    }
  </section>
</section>

{* ===== Delivery method ===== *}
<section class="one-page-checkout__section">
  <h2 class="one-page-checkout__title">{l s='Delivery method' d='Shop.Theme.Checkout'}</h2>

  <div class="one-page-checkout__placeholder" id="opc-delivery-methods">
    <div class="card card-body bg-light">
      {l s='You will see the available delivery methods once you\'ve entered your delivery address.' d='Shop.Theme.Checkout'}
    </div>
  </div>
</section>

{* ===== Payment method ===== *}
<section class="one-page-checkout__section">
  <h2 class="one-page-checkout__title">{l s='Payment method' d='Shop.Theme.Checkout'}</h2>

  <div class="one-page-checkout__placeholder" id="opc-payment-methods">
    <div class="card card-body bg-light">
      {l s='You will see the available payment methods once you\'ve entered your delivery address.' d='Shop.Theme.Checkout'}
    </div>
  </div>
</section>
