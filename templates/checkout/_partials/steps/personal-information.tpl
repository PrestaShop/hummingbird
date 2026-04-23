{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
{extends file='checkout/_partials/steps/checkout-step.tpl'}

{$stepName = 'personnal-information'}

{block name='step_content'}
  {hook h='displayPersonalInformationTop' customer=$customer}

  {if $customer.is_logged && !$customer.is_guest}
    {include file='checkout/_partials/connected-account-info.tpl'}
    
    <form id="checkout-continue-form" method="GET" action="{$urls.pages.order}">
      <div class="buttons-wrapper buttons-wrapper--end mt-3">
        <button
          class="btn btn-primary"
          name="controller"
          type="submit"
          value="order"
        >
          {l s='Continue to Addresses' d='Shop.Theme.Actions'}
          <i class="material-icons rtl-flip" aria-hidden="true">&#xE5C8;</i>
        </button>
      </div>
    </form>
  {else}
    <ul class="nav nav-underline" id="personal-information-tabs" role="tablist">
      <li class="nav-item" role="presentation">
        <button 
          class="nav-link {if !$show_login_form}active{/if}" 
          data-bs-toggle="tab"
          data-bs-target="#checkout-guest-form"
          type="button"
          role="tab"
          aria-controls="checkout-guest-form"
          aria-selected="{if !$show_login_form}true{else}false{/if}"
        >
          {if isset($guest_allowed) && $guest_allowed}
            {l s='Order as a guest' d='Shop.Theme.Checkout'}
          {else}
            {l s='New customer' d='Shop.Theme.Checkout'}
          {/if}
        </button>
      </li>

      <li class="nav-item" role="presentation">
        <button 
          class="nav-link {if $show_login_form}active{/if}" 
          data-bs-toggle="tab"
          data-bs-target="#checkout-login-form"
          type="button"
          role="tab"
          aria-controls="checkout-login-form"
          aria-selected="{if $show_login_form}true{else}false{/if}"
        >
          {l s='Sign in' d='Shop.Theme.Actions'}
        </button>
      </li>
    </ul>

    <div class="tab-content" id="personal-information-tabs-content">
      <div class="tab-pane fade{if !$show_login_form} show active{/if}" id="checkout-guest-form" aria-labelledby="checkout-guest-form" role="tabpanel">
        {render file='checkout/_partials/customer-form.tpl' ui=$register_form guest_allowed=$guest_allowed}
      </div>

      <div class="tab-pane fade{if $show_login_form} show active{/if}" id="checkout-login-form" aria-labelledby="checkout-login-form" role="tabpanel">
        {render file='checkout/_partials/login-form.tpl' ui=$login_form}
      </div>
    </div>
  {/if}
{/block}
