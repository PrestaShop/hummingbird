{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}

<div
  id="{$modal_id}"
  class="modal fade"
  tabindex="-1"
  role="dialog"
  aria-labelledby="address-modal-title"
  aria-hidden="true"
  data-title-new="{$title_new}"
  data-title-edit="{$title_edit}"
>
  <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable" role="document">
    <div class="modal-content address-form-container">
      <div class="modal-header pb-2">
        <h2 class="mb-0">{$title_new}</h2>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <hr>
      <div class="modal-body">
        <div class="row">
          <input type="hidden" name="id_address" value="">
          <input type="hidden" name="token" value="{$token}">
          <input type="hidden" name="address_type" value="{$address_type}">
          {assign var="_key_alias" value="{$prefix}alias"}
          {assign var="_key_id_country" value="{$prefix}id_country"}
          {assign var="_key_firstname" value="{$prefix}firstname"}
          {assign var="_key_lastname" value="{$prefix}lastname"}
          {assign var="_key_company" value="{$prefix}company"}
          {assign var="_key_vat_number" value="{$prefix}vat_number"}
          {assign var="_key_address1" value="{$prefix}address1"}
          {assign var="_key_address2" value="{$prefix}address2"}
          {assign var="_key_city" value="{$prefix}city"}
          {assign var="_key_postcode" value="{$prefix}postcode"}
          {assign var="_key_id_state" value="{$prefix}id_state"}
          {assign var="_key_phone" value="{$prefix}phone"}

          {if isset($formFields[$_key_id_country])}
            <div class="form-group mb-3">
              <label class="form-label{if $formFields[$_key_id_country].required} required{/if}" for="{$modal_id}-field-id_country">
                {$formFields[$_key_id_country].label}
              </label>
              <select
                class="form-select"
                name="{$formFields[$_key_id_country].name}"
                id="{$modal_id}-field-id_country"
                {if $formFields[$_key_id_country].required}required{/if}
              >
                <option value="">{l s='-- please choose --' d='Shop.Forms.Labels'}</option>
                {foreach from=$formFields[$_key_id_country].availableValues item="label" key="value"}
                  <option value="{$value}" {if (string) $value === (string) $formFields[$_key_id_country].value}selected{/if}>{$label}</option>
                {/foreach}
              </select>
            </div>
          {/if}

          {if isset($formFields[$_key_alias])}{form_field field=$formFields[$_key_alias]}{/if}

          {if isset($formFields[$_key_firstname]) && isset($formFields[$_key_lastname])}
            {include file='_partials/form-fields-row.tpl' fields=[$formFields[$_key_firstname], $formFields[$_key_lastname]]}
          {/if}

          {if isset($formFields[$_key_company])}{form_field field=$formFields[$_key_company]}{/if}

          {if isset($formFields[$_key_vat_number])}{form_field field=$formFields[$_key_vat_number]}{/if}

          {if isset($formFields[$_key_address1])}{form_field field=$formFields[$_key_address1]}{/if}

          {if isset($formFields[$_key_address2])}{form_field field=$formFields[$_key_address2]}{/if}

          <div class="form-fields-row form-fields-row--2 address-country-row">
            {if isset($formFields[$_key_city])}{form_field field=$formFields[$_key_city]}{/if}
            <div class="form-group mb-3 state-field-wrapper" style="{if !isset($formFields[$_key_id_state]) || empty($formFields[$_key_id_state].availableValues)}display: none;{/if}">
              <label class="form-label{if isset($formFields[$_key_id_state]) && $formFields[$_key_id_state].required} required{/if}" for="{$modal_id}-field-id_state">
                {l s='State' d='Shop.Forms.Labels'}
              </label>
              <select
                class="form-select"
                name="{if isset($formFields[$_key_id_state])}{$formFields[$_key_id_state].name}{else}{$prefix}id_state{/if}"
                id="{$modal_id}-field-id_state"
                data-select-placeholder="{l s='-- please choose --' d='Shop.Forms.Labels' js=1}"
              >
                <option value="">{l s='-- please choose --' d='Shop.Forms.Labels'}</option>
                {if isset($formFields[$_key_id_state]) && isset($formFields[$_key_id_state].availableValues)}
                  {foreach from=$formFields[$_key_id_state].availableValues item="label" key="value"}
                    <option value="{$value}" {if $value eq $formFields[$_key_id_state].value}selected{/if}>{$label}</option>
                  {/foreach}
                {/if}
              </select>
            </div>
            {if isset($formFields[$_key_postcode])}{form_field field=$formFields[$_key_postcode]}{/if}
          </div>

          {if isset($formFields[$_key_phone])}{form_field field=$formFields[$_key_phone]}{/if}
        </div>
      </div>
      <div class="modal-footer">
        <button
          id="submit-address-modal"
          type="button"
          class="btn btn-primary"
          data-loading-text="{l s='Saving...' d='Shop.Theme.Checkout'}"
          data-text="{l s='Save' d='Shop.Theme.Actions'}"
        >
          {l s='Save' d='Shop.Theme.Actions'}
        </button>
      </div>
    </div>
  </div>
</div>
