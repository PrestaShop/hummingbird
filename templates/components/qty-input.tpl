{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 *}

{assign var="increment_icon" value="E145"}
{assign var="decrement_icon" value="E15B"}
{assign var="submit_icon" value="E5CA"}
{assign var="cancel_icon" value="E5CD"}

{* The spin button placement for RTL should be same as LTR *}
{* To fix mirroring by CSS need to place them in reverse for RTL *}
{if $language.is_rtl}
  {assign var="prepend" value=["button"=>"increment", "icon"=>$increment_icon, "confirm_icon"=>$submit_icon]}
  {assign var="append" value=["button"=>"decrement", "icon"=>$decrement_icon, "confirm_icon"=>$cancel_icon]}
{else}
  {assign var="prepend" value=["button"=>"decrement", "icon"=>$decrement_icon, "confirm_icon"=>$cancel_icon]}
  {assign var="append" value=["button"=>"increment", "icon"=>$increment_icon, "confirm_icon"=>$submit_icon]}
{/if}

<div class="input-group flex-nowrap mb-3">
  <button class="btn {$prepend.button} js-{$prepend.button}-button" type="button">
    <i class="material-icons">&#x{$prepend.icon};</i>
    <i class="material-icons confirmation d-none">&#x{$prepend.confirm_icon};</i>
    <div class="spinner-border spinner-border-sm align-middle d-none" role="status"></div>
  </button>
  <input
    {foreach $attributes as $key=>$value}
      {$key}="{$value}"
    {/foreach}
    {* The default attributes, will be used if not defined *}
      class="form-control"
      name="qty"
      aria-label="{l s='Quantity' d='Shop.Theme.Actions'}"
      type="text"
      inputmode="numeric"
      pattern="[0-9]*"
      value="1"
      min="1"
    {* End of default attributes *}
  />
  <button class="btn {$append.button} js-{$append.button}-button" type="button">
    <i class="material-icons">&#x{$append.icon};</i>
    <i class="material-icons confirmation d-none">&#x{$append.confirm_icon};</i>
    <div class="spinner-border spinner-border-sm align-middle d-none" role="status"></div>
  </button>
</div>
