{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{assign var="increment_icon" value="E145"}
{assign var="decrement_icon" value="E15B"}
{assign var="submit_icon" value="E5CA"}
{assign var="cancel_icon" value="E5CD"}
{assign var="increment_label" value={l s='Increase quantity of %product_name%' sprintf=['%product_name%' => $product.name] d='Shop.Theme.Actions'}}
{assign var="decrement_label" value={l s='Decrease quantity of %product_name%' sprintf=['%product_name%' => $product.name] d='Shop.Theme.Actions'}}
{assign var="quantity_label" value={l s='Change quantity of %product_name%' sprintf=['%product_name%' => $product.name] d='Shop.Theme.Actions'}}

{* The spin button placement for RTL should be same as LTR *}
{* To fix mirroring by CSS need to place them in reverse for RTL *}
{if $language.is_rtl}
  {assign var="prepend" value=["button"=>"increment", "icon"=>$increment_icon, "confirm_icon"=>$submit_icon]}
  {assign var="append" value=["button"=>"decrement", "icon"=>$decrement_icon, "confirm_icon"=>$cancel_icon]}
{else}
  {assign var="prepend" value=["button"=>"decrement", "icon"=>$decrement_icon, "confirm_icon"=>$cancel_icon]}
  {assign var="append" value=["button"=>"increment", "icon"=>$increment_icon, "confirm_icon"=>$submit_icon]}
{/if}

<div class="quantity-button__group input-group">
  <button aria-label="{$decrement_label}" class="btn {$prepend.button} btn-square-icon js-{$prepend.button}-button" type="button" id="decrement_button_{$product.id_product}">
    <i class="material-icons" aria-hidden="true">&#x{$prepend.icon};</i>
    <i class="material-icons confirmation d-none" aria-hidden="true">&#x{$prepend.confirm_icon};</i>
    <div class="spinner-border spinner-border-sm align-middle d-none" role="status"></div>
  </button>

  <input
    {foreach $attributes as $key=>$value}
      {$key}="{$value}"
    {/foreach}
    {if !isset($attributes.id)}id="quantity_input_{$product.id_product}"{/if}
    {if !isset($attributes.class)}class="form-control"{/if}
    {if !isset($attributes.name)}name="qty"{/if}
    {if !isset($attributes['aria-label'])}aria-label="{$quantity_label}"{/if}
    {if !isset($attributes.type)}type="text"{/if}
    {if !isset($attributes.inputmode)}inputmode="numeric"{/if}
    {if !isset($attributes.pattern)}pattern="[0-9]+"{/if}
    {if !isset($attributes.value)}value="1"{/if}
    {if !isset($attributes.min)}min="1"{/if}
  >

  <button aria-label="{$increment_label}" class="btn {$append.button} btn-square-icon js-{$append.button}-button" type="button" id="increment_button_{$product.id_product}">
    <i class="material-icons" aria-hidden="true">&#x{$append.icon};</i>
    <i class="material-icons confirmation d-none" aria-hidden="true">&#x{$append.confirm_icon};</i>
    <div class="spinner-border spinner-border-sm align-middle d-none" role="status"></div>
  </button>
</div>
