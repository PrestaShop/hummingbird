{extends file='checkout/_partials/steps/checkout-step.tpl'}

{if $step_is_complete}
{/if}
{block name='step_content'}
  {hook h='displayPersonalInformationTop' customer=$customer}

  {if $customer.is_logged && !$customer.is_guest}
    <div class="step__account">
      <p class="mb-3">
        {* [1][/1] is for a HTML tag. *}
        {l s='Connected as [1]%firstname% %lastname%[/1].'
          d='Shop.Theme.Customeraccount'
          sprintf=[
            '[1]' => "<a href='{$urls.pages.identity}'>",
            '[/1]' => "</a>",
            '%firstname%' => $customer.firstname,
            '%lastname%' => $customer.lastname
          ]
        }
      </p>

      <p class="mb-1">
        {* [1][/1] is for a HTML tag. *}
        {l
          s='Not you? [1]Sign out[/1]'
          d='Shop.Theme.Customeraccount'
          sprintf=[
          '[1]' => "<a class='text-danger' href='{$urls.actions.logout}'>",
          '[/1]' => "</a>"
          ]
        }
      </p>

      {if !isset($empty_cart_on_logout) || $empty_cart_on_logout}
        <p><small class="text-gray">{l s='If you sign out now, your cart will be emptied.' d='Shop.Theme.Checkout'}</small></p>
      {/if}
    </div>

    <div class="mt-4">
      <form method="GET" action="{$urls.pages.order}">
        <button
          class="continue btn btn-primary btn-with-icon w-100 w-md-auto"
          name="controller"
          type="submit"
          value="order"
       > 
          {l s='Continue to Addresses' d='Shop.Theme.Actions'}
          <div class="material-icons rtl-flip" aria-hidden="true">arrow_forward</div>
        </button>
      </form>
    </div>
  {else}
    <ul class="nav nav-tabs my-3" id="myTab" role="tablist">
      <li class="nav-item" role="presentation">
        <button 
          class="nav-link {if !$show_login_form}active{/if}" 
          id="contact-tab"
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
          id="contact-tab"
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

    <div class="tab-content" id="myTabContent">
      <div class="tab-pane fade{if !$show_login_form} show active{/if}" id="checkout-guest-form" aria-labelledby="checkout-guest-form" role="tabpanel" {if $show_login_form}aria-hidden="true"{/if}>
        {render file='checkout/_partials/customer-form.tpl' ui=$register_form guest_allowed=$guest_allowed}
      </div>

      <div class="tab-pane fade{if $show_login_form} show active{/if}" id="checkout-login-form" aria-labelledby="checkout-login-form" role="tabpanel" {if !$show_login_form}aria-hidden="true"{/if}>
        {render file='checkout/_partials/login-form.tpl' ui=$login_form}
      </div>
    </div>
  {/if}
{/block}
