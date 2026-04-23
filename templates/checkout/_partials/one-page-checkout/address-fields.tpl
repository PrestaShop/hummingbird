{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}

{**
 * One Page Checkout - Address fields partial
 *}

{assign var="_prefix_len" value=$prefix|strlen}
{assign var="_key_firstname" value="{$prefix}firstname"}
{assign var="_key_lastname" value="{$prefix}lastname"}
{assign var="_key_city" value="{$prefix}city"}
{assign var="_key_postcode" value="{$prefix}postcode"}
{assign var="_key_id_state" value="{$prefix}id_state"}

{assign var="_has_name_row" value=isset($formFields[$_key_firstname]) && isset($formFields[$_key_lastname])}
{assign var="_has_city_row" value=isset($formFields[$_key_city]) && isset($formFields[$_key_postcode])}
{assign var="_has_state" value=isset($formFields[$_key_id_state])}

{foreach from=$formFields item="field"}
  {if $prefix && strpos($field.name, $prefix) !== 0}{continue}{/if}
  {if !$prefix && strpos($field.name, 'invoice_') === 0}{continue}{/if}

  {if $prefix}
    {assign var="_base" value=$field.name|substr:$_prefix_len}
  {else}
    {assign var="_base" value=$field.name}
  {/if}

  {if $_base === 'alias'}
    {form_field field=$field}

  {elseif $_base === 'firstname' && $_has_name_row}
    {include file='_partials/form-fields-row.tpl'
      fields=[$formFields[$_key_firstname], $formFields[$_key_lastname]]
    }

  {elseif $_base === 'lastname' && $_has_name_row}
  {elseif $_base === 'city' && $_has_city_row}
    {if $_has_state}
      {include file='_partials/form-fields-row.tpl'
        fields=[$formFields[$_key_city], $formFields[$_key_id_state], $formFields[$_key_postcode]]
      }
    {else}
      {include file='_partials/form-fields-row.tpl'
        fields=[$formFields[$_key_city], $formFields[$_key_postcode]]
      }
    {/if}

  {elseif $_base === 'postcode' && $_has_city_row}
  {elseif $_base === 'id_state' && $_has_city_row}
  {elseif $_base === 'id_country'}
    <div class="form-group mb-3">
      <label class="form-label{if $field.required} required{/if}" for="field-{$field.name}">
        {$field.label}
      </label>
      <select
        class="form-select"
        name="{$field.name}"
        id="field-{$field.name}"
        {if $field.required}required{/if}
      >
        <option value="">{l s='-- please choose --' d='Shop.Forms.Labels'}</option>
        {foreach from=$field.availableValues item="label" key="value"}
          <option value="{$value}" {if (string) $value === (string) $field.value}selected{/if}>{$label}</option>
        {/foreach}
      </select>
      {include file='_partials/form-errors.tpl' errors=$field.errors|default:[]}
    </div>

  {else}
    {form_field field=$field}
  {/if}
{/foreach}
