{extends file='checkout/_partials/steps/checkout-step.tpl'}

{block name='step_content'}
  {hook h='displayPaymentTop'}

  {* used by javascript to correctly handle cart updates when we are on payment step (eg vouchers added) *}
  <div style="display:none" class="js-cart-payment-step-refresh"></div>

  {if !empty($display_transaction_updated_info)}
    <p class="payment-options__updated">
      {l s='Transaction amount has been correctly updated' d='Shop.Theme.Checkout'}
    </p>
  {/if}

  {if $is_free}
    <p class="payment-options__free">{l s='No payment needed for this order' d='Shop.Theme.Checkout'}</p>
  {/if}

  <div class="payment-options__list{if $is_free} d-block d-sm-none{/if}">
    {foreach from=$payment_options item="module_options"}
      {foreach from=$module_options item="option"}
        <div id="{$option.id}-container" class="payment-option">
          {* This is the way an option should be selected when Javascript is enabled *}
          <div class="payment-option__form-check form-check">
            <input
              class="payment-option__input form-check-input ps-shown-by-js {if $option.binary} binary{/if}"
              type="radio"
              name="payment-option"
              data-module-name="{$option.module_name}"
              id="{$option.id}"
              {if ($selected_payment_option == $option.id || $is_free) || ($payment_options|@count === 1 && $module_options|@count === 1)} checked {/if}
            >

            <label class="payment-option__label form-check-label" for="{$option.id}">
              {if $option.logo}
                <img class="img-fluid" src="{$option.logo}" loading="lazy">
              {/if}
              {$option.call_to_action_text}
            </label>
          </div>

          {* This is the way an option should be selected when Javascript is disabled *}
          <form method="GET" class="payment-option__no-js-form ps-hidden-by-js">
            {if $option.id === $selected_payment_option}
              {l s='Selected' d='Shop.Theme.Checkout'}
            {else}
              <button class="ps-hidden-by-js" type="submit" name="select_payment_option" value="{$option.id}">
                {l s='Choose' d='Shop.Theme.Actions'}
              </button>
            {/if}
          </form>

          {if $option.additionalInformation}
            <div
              id="{$option.id}-additional-information"
              class="payment-option__additional-information js-additional-information"
              {if $option.id != $selected_payment_option}style="display: none;"{/if}
            >
              {$option.additionalInformation nofilter}
            </div>
          {/if}
  
          <div
            id="pay-with-{$option.id}-form"
            class="js-payment-option-form"
            {if $option.id != $selected_payment_option}style="display: none;"{/if}
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
            <input  id    = "conditions_to_approve[{$condition_name}]"
                    name  = "conditions_to_approve[{$condition_name}]"
                    required
                    type  = "checkbox"
                    value = "1"
                    class = "ps-shown-by-js form-check-input"
            >

            <label class="js-terms form-check-label" for="conditions_to_approve[{$condition_name}]">
              {$condition nofilter}
            </label>
          </div>
        {/foreach}
    </form>
  {/if}

  {hook h='displayCheckoutBeforeConfirmation'}

  {if $show_final_summary}
    {include file='checkout/_partials/order-final-summary.tpl'}
  {/if}

  {if $show_final_summary}
    <article class="alert alert-danger mb-4 js-alert-payment-conditions" role="alert">
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

  <div class="buttons-wrapper buttons-wrapper--split buttons-wrapper--invert-mobile mt-3">
    <button class="btn btn-outline-primary js-back" type="button" data-step="checkout-delivery-step">
      <div class="material-icons rtl-flip" aria-hidden="true">&#xE5C4;</div>
      {l s='Back to Shipping' d='Shop.Theme.Actions'}
    </button>

    <div id="payment-confirmation" class="js-payment-confirmation">
      <div class="ps-shown-by-js">
        <button type="submit" class="btn btn-primary {if !$selected_payment_option} disabled{/if}">
          {l s='Place Order' d='Shop.Theme.Checkout'}
          <div class="material-icons rtl-flip" aria-hidden="true">&#xE5C8;</div>
        </button>
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
