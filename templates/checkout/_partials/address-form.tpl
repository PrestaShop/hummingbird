{extends file='customer/_partials/address-form.tpl'}

{block name='form_field'}
  {if $field.name eq "alias" and $customer.is_guest}
    {* we don't ask for alias here if customer is not registered *}
  {else}
    {$smarty.block.parent}
  {/if}
{/block}

{block name='address_form_url'}
    <form
      method="POST"
      action="{url entity='order' params=['id_address' => $id_address]}"
      data-id-address="{$id_address}"
      data-refresh-url="{url entity='order' params=['ajax' => 1, 'action' => 'addressForm', 'id_address' => $id_address]}"
   >
{/block}

{block name='form_fields' append}
  <input type="hidden" name="saveAddress" value="{$type}">

  {if $type === "delivery"}
    <div class="mb-3 form-check">
      <input class="form-check-input" name="use_same_address" id="use_same_address" type="checkbox" value="1" {if $use_same_address} checked {/if}>
      <label class="form-check-label" for="use_same_address">{l s='Use this address for invoice too' d='Shop.Theme.Checkout'}</label>
    </div>
  {/if}
{/block}

{block name='form_buttons'}
  {if !$form_has_continue_button}
    <div class="buttons-wrapper buttons-wrapper--split buttons-wrapper--no-fw-mobile buttons-wrapper--invert-mobile mt-3">
      <a class="js-cancel-address btn btn-basic" href="{url entity='order' params=['cancelAddress' => {$type}]}">{l s='Cancel' d='Shop.Theme.Actions'}</a>
      <button type="submit" class="btn btn-primary">{l s='Save' d='Shop.Theme.Actions'}</button>
    </div>
  {else}
    <div class="buttons-wrapper {if $customer.addresses|count == 0}buttons-wrapper--end{else}buttons-wrapper--split buttons-wrapper--no-fw-mobile buttons-wrapper--invert-mobile{/if} mt-3">
      {if $customer.addresses|count> 0}
        <a class="js-cancel-address btn btn-basic" href="{url entity='order' params=['cancelAddress' => {$type}]}">{l s='Cancel' d='Shop.Theme.Actions'}</a>
      {/if}

      <button type="submit" class="btn btn-primary" name="confirm-addresses" value="1">
        {l s='Continue' d='Shop.Theme.Actions'}
        <i class="material-icons rtl-flip" aria-hidden="true">&#xE5C8;</i>
      </button>
    </div>
  {/if}
{/block}
