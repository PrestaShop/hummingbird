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

<div class="input-group flex-nowrap mb-3">
  {if $language.is_rtl}
    <button class="btn js-increment-button" type="button">
      <i class="material-icons">&#xE145;</i>
      <i class="material-icons text-success d-none">&#xE5CA;</i>
      <div class="spinner-border spinner-border-sm align-middle d-none" role="status"></div>
    </button>
  {else}
    <button class="btn js-decrement-button" type="button">
      <i class="material-icons">&#xE15B;</i>
      <i class="material-icons text-danger d-none">&#xE5CD;</i>
      <div class="spinner-border spinner-border-sm align-middle d-none" role="status"></div>
    </button>
  {/if}
  <input
    {foreach $attributes as $key=>$value}
    {$key}="{$value}"
    {/foreach}
    {* If below attributes not defiend then use them as default *}
    class="form-control"
    aria-label="{l s='Quantity' d='Shop.Theme.Actions'}"
    type="text"
    inputmode="numeric"
    pattern="[0-9]*"
    value="1"
    min="1"
  />
  {if $language.is_rtl}
    <button class="btn js-decrement-button" type="button">
      <i class="material-icons">&#xE15B;</i>
      <i class="material-icons text-danger d-none">&#xE5CD;</i>
      <div class="spinner-border spinner-border-sm align-middle d-none" role="status"></div>
    </button>
  {else}
    <button class="btn js-increment-button" type="button">
      <i class="material-icons">&#xE145;</i>
      <i class="material-icons text-success d-none">&#xE5CA;</i>
      <div class="spinner-border spinner-border-sm align-middle d-none" role="status"></div>
    </button>
  {/if}
</div>
