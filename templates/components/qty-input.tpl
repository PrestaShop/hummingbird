{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}

{*
  Quantity selector
  - quantity_context: product | quickview | listing | cart (behaviour on change, see src/js/components/quantity-selector).
    Required: without it, the JS reports the selector in the console and applies no change.
  - attributes: extra input attributes (id, class, name, value, min)
  - quantity_max: optional upper bound (e.g. the stock when out of stock orders are disabled)
*}
{if !isset($quantity_context)}{assign var="quantity_context" value=""}{/if}
{if !isset($attributes)}{assign var="attributes" value=[]}{/if}
{* {l} output is not escaped: the product name is escaped before it goes into the attributes *}
{assign var="quantity_product_name" value=$product.name|escape:'html':'UTF-8'}

{assign var="id_product_attribute" value=0}
{if isset($product.id_product_attribute)}{assign var="id_product_attribute" value=$product.id_product_attribute|intval}{/if}
{assign var="id_customization" value=0}
{if isset($product.id_customization)}{assign var="id_customization" value=$product.id_customization|intval}{/if}

{if isset($attributes.id)}
  {assign var="input_id" value=$attributes.id}
{elseif $quantity_context == 'listing'}
  {* The same product can be listed several times on a page (carousels, cross-selling…) *}
  {counter name="quantity_selector" assign="quantity_selector_index"}
  {assign var="input_id" value="quantity_{$product.id_product|intval}_{$id_product_attribute}_{$quantity_selector_index}"}
{else}
  {assign var="input_id" value="quantity_{$product.id_product|intval}_{$id_product_attribute}_{$id_customization}"}
{/if}

{assign var="current_value" value=1}
{if isset($attributes.value)}{assign var="current_value" value=$attributes.value|intval}{/if}
{assign var="min_value" value=1}
{if isset($attributes.min)}{assign var="min_value" value=$attributes.min|intval}{/if}
{assign var="max_value" value=0}
{if isset($quantity_max)}{assign var="max_value" value=$quantity_max|intval}{/if}

{if $quantity_context == 'cart'}
  {assign var="quantity_data" value=[
    'updateUrl' => $product.update_quantity_url,
    'idProduct' => $product.id_product|intval,
    'idProductAttribute' => $id_product_attribute,
    'idCustomization' => $id_customization
  ]}
{/if}

{* The spinner and the live region stay outside the input group, which only rounds its first and last children *}
<div
  class="quantity-selector"
  data-ps-component="quantity-selector"
  data-ps-context="{$quantity_context|escape:'html':'UTF-8'}"
  data-ps-state="idle"
  {if $quantity_context == 'cart'}data-ps-data="{$quantity_data|json_encode|escape:'html':'UTF-8'}"{/if}
>
  {* The group keeps the same button placement in RTL: decrement on the left, increment on the right *}
  <div class="quantity-selector__group input-group" dir="ltr">
    <button
      type="button"
      class="quantity-selector__button btn btn-square-icon"
      id="{$input_id|escape:'html':'UTF-8'}_decrement"
      data-ps-action="quantity-decrement"
      aria-controls="{$input_id|escape:'html':'UTF-8'}"
      aria-disabled="{if $current_value <= $min_value}true{else}false{/if}"
      aria-label="{l s='Decrease quantity of %product_name%' sprintf=['%product_name%' => $quantity_product_name] d='Shop.Theme.Actions'}"
    >
      <i class="material-icons" aria-hidden="true">&#xE15B;</i>
    </button>

    <input
      {foreach $attributes as $key => $value}
        {if $key != 'class'}{$key}="{$value|escape:'html':'UTF-8'}"{/if}
      {/foreach}
      {if !isset($attributes.id)}id="{$input_id|escape:'html':'UTF-8'}"{/if}
      class="quantity-selector__input form-control{if isset($attributes.class)} {$attributes.class|escape:'html':'UTF-8'}{/if}"
      type="number"
      inputmode="numeric"
      step="1"
      {if !isset($attributes.name)}name="qty"{/if}
      {if !isset($attributes.value)}value="1"{/if}
      {if !isset($attributes.min)}min="1"{/if}
      {if $max_value > 0}max="{$max_value}"{/if}
      data-ps-ref="quantity-input"
      aria-label="{l s='Change quantity of %product_name%' sprintf=['%product_name%' => $quantity_product_name] d='Shop.Theme.Actions'}"
    >

    <button
      type="button"
      class="quantity-selector__button btn btn-square-icon"
      id="{$input_id|escape:'html':'UTF-8'}_increment"
      data-ps-action="quantity-increment"
      aria-controls="{$input_id|escape:'html':'UTF-8'}"
      aria-disabled="{if $max_value > 0 && $current_value >= $max_value}true{else}false{/if}"
      aria-label="{l s='Increase quantity of %product_name%' sprintf=['%product_name%' => $quantity_product_name] d='Shop.Theme.Actions'}"
    >
      <i class="material-icons" aria-hidden="true">&#xE145;</i>
    </button>
  </div>

  <span class="quantity-selector__spinner spinner-border spinner-border-sm" aria-hidden="true"></span>
  <span
    class="visually-hidden"
    data-ps-ref="quantity-status"
    {if $quantity_context == 'cart'}data-ps-data="{l s='Quantity of %product_name% updated to %quantity%.' sprintf=['%product_name%' => $quantity_product_name] d='Shop.Theme.Actions'}"{/if}
    role="status"
    aria-live="polite"
  ></span>
</div>
