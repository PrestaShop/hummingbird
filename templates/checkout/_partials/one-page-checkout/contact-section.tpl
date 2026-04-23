{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}

{hook h='displayPersonalInformationTop' customer=$customer}

{$isGuestCheckoutEnabled = $configuration.is_guest_checkout_enabled}

{if !$customer.is_logged}
  <section class="one-page-checkout__section">
    <h2 class="one-page-checkout__title">{l s='Contact information' d='Shop.Theme.Checkout'}</h2>

    <div class="one-page-checkout__links">
      <a class="one-page-checkout__link" href="{$urls.pages.authentication}?back={$urls.pages.order}">
        {l s='Already have an account? Sign in' d='Shop.Theme.Checkout'}
      </a>
      <a class="one-page-checkout__link" href="{$urls.pages.registration}?back={$urls.pages.order}">
        {l s='Create account' d='Shop.Theme.Checkout'}
      </a>
    </div>

    {if $isGuestCheckoutEnabled}
      {if isset($contactFields['email'])}
        <div class="one-page-checkout__field">
          <label class="form-label" for="field-email">{l s='Continue as guest' d='Shop.Theme.Checkout'}</label>
          <input class="form-control" type="email" name="email" id="field-email" value="{$contactFields['email']['value']}" required>
          {include file='_partials/form-errors.tpl' errors=$contactFields['email']['errors']|default:[]}
        </div>
      {/if}

      {if isset($contactFields['optin'])}
        <div class="one-page-checkout__field">
          {form_field field=$contactFields['optin']}
        </div>
      {/if}

      {foreach from=$additionalCustomerFields item="field"}
        <div class="one-page-checkout__field">
          {form_field field=$field}
        </div>
      {/foreach}
    {/if}
  </section>
{else}
  <section class="one-page-checkout__section">
    <h2 class="one-page-checkout__title">{l s='Contact information' d='Shop.Theme.Checkout'}</h2>
    {include file='checkout/_partials/connected-account-info.tpl'}
  </section>
{/if}
