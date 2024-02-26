{extends file='checkout/_partials/steps/checkout-step.tpl'}

{block name='step_content'}
  {hook h='displayPaymentTop'}

  {* used by javascript to correctly handle cart updates when we are on payment step (eg vouchers added) *}
  <div style="display:none" class="js-cart-payment-step-refresh"></div>

  {if !empty($display_transaction_updated_info)}
    <p class="payment__updated">
      {l s='Transaction amount has been correctly updated' d='Shop.Theme.Checkout'}
    </p>
  {/if}

  {if $is_free}
    <p>{l s='No payment needed for this order' d='Shop.Theme.Checkout'}</p>
  {/if}

  <div class="payment__list{if $is_free} d-block d-sm-none{/if}">
    {foreach from=$payment_options item="module_options"}
      {foreach from=$module_options item="option"}
        <div id="{$option.id}-container" class="payment__option">
          {* This is the way an option should be selected when Javascript is enabled *}
          <label class="form-check-label mb-3 d-flex align-items-center">
            <input
              class="form-check-input ps-shown-by-js flex-shrink-0 my-0 me-2{if $option.binary} binary{/if}"
              type="radio"
              name="payment-option"
              data-module-name="{$option.module_name}"
              id="{$option.id}"
              {if ($selected_payment_option == $option.id || $is_free) || ($payment_options|@count === 1 && $module_options|@count === 1)} checked {/if}
            />
            
            <span class="d-flex flex-wrap gap-1 align-items-center flex-grow-1">	
              {if $option.logo}
                <img class="flex-shrink-0 me-2" src="{$option.logo}" loading="lazy">
              {/if}
							{$option.call_to_action_text}
						</span>
          </label>

          {* This is the way an option should be selected when Javascript is disabled *}
          <form method="GET" class="ps-hidden-by-js">
            {if $option.id === $selected_payment_option}
              {l s='Selected' d='Shop.Theme.Checkout'}
            {else}
              <button class="ps-hidden-by-js" type="submit" name="select_payment_option" value="{$option.id}">
                {l s='Choose' d='Shop.Theme.Actions'}
              </button>
            {/if}
          </form>
        </div>

        {if $option.additionalInformation}
          <div
            id="{$option.id}-additional-information"
            class="js-additional-information payment__definitions ps-sm-4 mt-2 additional-information{if $option.id != $selected_payment_option} ps-hidden{/if}"
         >
            {$option.additionalInformation nofilter}
          </div>
        {/if}

        <div
          id="pay-with-{$option.id}-form"
          class="js-payment-option-form{if $option.id != $selected_payment_option} ps-hidden{/if}"
       >
          {if $option.form}
            {$option.form nofilter}
          {else}
            <form id="payment-form" method="POST" action="{$option.action nofilter}">
              {foreach from=$option.inputs item=input}
                <input type="{$input.type}" name="{$input.name}" value="{$input.value}">
              {/foreach}
              <button style="display:none" id="pay-with-{$option.id}" type="submit"></button>
            </form>
          {/if}
        </div>
      {/foreach}
    {foreachelse}
      <p class="alert alert-danger">{l s='Unfortunately, there are no payment method available.' d='Shop.Theme.Checkout'}</p>
    {/foreach}
  </div>

  {if $conditions_to_approve|count}
    <p class="ps-hidden-by-js">
      {* At the moment, we're not showing the checkboxes when JS is disabled
         because it makes ensuring they were checked very tricky and overcomplicates
         the template. Might change later.
      *}
      {l s='By confirming the order, you certify that you have read and agree with all of the conditions below:' d='Shop.Theme.Checkout'}
    </p>

    <form id="conditions-to-approve" class="js-conditions-to-approve" method="GET">
        {foreach from=$conditions_to_approve item="condition" key="condition_name"}
          <div class="my-3 form-check">
            <label class="js-terms form-check-label" for="conditions_to_approve[{$condition_name}]">
              {$condition nofilter}
            </label>
            <input  id    = "conditions_to_approve[{$condition_name}]"
                    name  = "conditions_to_approve[{$condition_name}]"
                    required
                    type  = "checkbox"
                    value = "1"
                    class = "ps-shown-by-js form-check-input"
            >
          </div>
        {/foreach}
    </form>
  {/if}

  {hook h='displayCheckoutBeforeConfirmation'}

  {if $show_final_summary}
    {include file='checkout/_partials/order-final-summary.tpl'}
  {/if}

  {if $show_final_summary}
    <article class="alert alert-danger mb-4 js-alert-payment-conditions" role="alert" data-alert="danger">
      {l
        s='Please make sure you\'ve chosen a [1]payment method[/1] and accepted the [2]terms and conditions[/2].'
        sprintf=[
          '[1]' => '<a href="#checkout-payment-step" class="alert-link">',
          '[/1]' => '</a>',
          '[2]' => '<a href="#conditions-to-approve" class="alert-link">',
          '[/2]' => '</a>'
        ]
        d='Shop.Theme.Checkout'
      }
    </article>
  {/if}

  <div class="payment__actions d-block d-md-flex d-flex flex-wrap justify-content-between">
    <button class="btn btn-outline-primary btn-with-icon w-100 w-md-auto mb-3 mb-md-0 js-back" data-step="checkout-delivery-step">
      <div class="material-icons rtl-flip" aria-hidden="true">arrow_backward</div>
      {l s='Back to Shipping method' d='Shop.Theme.Actions'}
    </button>

    <div id="payment-confirmation" class="w-100 w-md-auto js-payment-confirmation">
      <div class="ps-shown-by-js">
        <div class="payment__actions">
          <button type="submit" class="btn btn-primary btn-with-icon w-100{if !$selected_payment_option} disabled{/if}">
            {l s='Place order' d='Shop.Theme.Checkout'}
            <div class="material-icons rtl-flip" aria-hidden="true">arrow_forward</div>
          </button>
        </div>
      </div>

      <div class="ps-hidden-by-js">
        {if $selected_payment_option and $all_conditions_approved}
          <label for="pay-with-{$selected_payment_option}">{l s='Order with an obligation to pay' d='Shop.Theme.Checkout'}</label>
        {/if}
      </div>
    </div>
  </div>

  {hook h='displayPaymentByBinaries'}
{/block}
