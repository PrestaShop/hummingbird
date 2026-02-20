{**
 * One Page Checkout - Address fields partial
 *
 * Renders address fields from $formFields filtered by $prefix.
 * Reused for both delivery (prefix='') and billing (prefix='invoice_').
 *
 * @param array  $formFields - All form fields from OnePageCheckoutForm
 * @param string $prefix     - Field name prefix ('' or 'invoice_')
 *}

{* ===== Prefix length for stripping ===== *}
{assign var="_prefix_len" value=$prefix|strlen}

{* ===== Build prefixed key names ===== *}
{assign var="_key_firstname" value="{$prefix}firstname"}
{assign var="_key_lastname" value="{$prefix}lastname"}
{assign var="_key_city" value="{$prefix}city"}
{assign var="_key_postcode" value="{$prefix}postcode"}
{assign var="_key_id_state" value="{$prefix}id_state"}

{* ===== Pre-compute which grouped fields are available ===== *}
{assign var="_has_name_row" value=isset($formFields[$_key_firstname]) && isset($formFields[$_key_lastname])}
{assign var="_has_city_row" value=isset($formFields[$_key_city]) && isset($formFields[$_key_postcode])}
{assign var="_has_state" value=isset($formFields[$_key_id_state])}

{foreach from=$formFields item="field"}
  {* Only render fields matching our prefix *}
  {if $prefix && strpos($field.name, $prefix) !== 0}{continue}{/if}
  {if !$prefix && strpos($field.name, 'invoice_') === 0}{continue}{/if}

  {* Strip prefix to get base field name *}
  {if $prefix}
    {assign var="_base" value=$field.name|substr:$_prefix_len}
  {else}
    {assign var="_base" value=$field.name}
  {/if}

  {* ----- Skip: alias (hidden), email, use_same_address, id_address_invoice ----- *}
  {if $_base === 'alias'}
    <input type="hidden" name="{$field.name}" value="My address">

  {elseif $_base === 'email' || $_base === 'optin' || $_base === 'use_same_address' || $_base === 'id_address_invoice'}
    {* Handled outside this partial *}

  {* ----- Name row: firstname + lastname (2 columns) ----- *}
  {elseif $_base === 'firstname' && $_has_name_row}
    {include file='checkout/_partials/one-page-checkout/field-row.tpl'
      fields=[$formFields[$_key_firstname], $formFields[$_key_lastname]]
    }

  {elseif $_base === 'lastname' && $_has_name_row}
    {* Rendered above with firstname *}

  {* ----- Location row: city + state? + postcode (2 or 3 columns) ----- *}
  {elseif $_base === 'city' && $_has_city_row}
    {if $_has_state}
      {include file='checkout/_partials/one-page-checkout/field-row.tpl'
        fields=[$formFields[$_key_city], $formFields[$_key_id_state], $formFields[$_key_postcode]]
      }
    {else}
      {include file='checkout/_partials/one-page-checkout/field-row.tpl'
        fields=[$formFields[$_key_city], $formFields[$_key_postcode]]
      }
    {/if}

  {elseif $_base === 'postcode' && $_has_city_row}
    {* Rendered above with city *}

  {elseif $_base === 'id_state' && $_has_city_row}
    {* Rendered above with city *}

  {* ----- Default: single-column field ----- *}
  {else}
    {form_field field=$field}

  {/if}
{/foreach}
