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

<div id="_desktop_user_info">
  <div class="user-info">
    {if $customer.is_logged}
      <div class="dropdown">
        <button class="dropdown-toggle btn btn-link btn-with-icon" type="button" id="userMenuButton" data-bs-display="static" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <i class="material-icons">&#xE7FD;</i>
          <span class="user-info__name">{$customerName|truncate:22:"..":true}</span>
        </button>

        <div class="dropdown-menu" aria-labelledby="userMenuButton">
          <a class="dropdown-item" href="{$urls.pages.my_account}">
            <i class="material-icons me-2">&#xF02E;</i>
            {l s='Your account' d='Shop.Theme.Customeraccount'}
          </a>
          <div class="dropdown-divider"></div>
          <a href="{$urls.pages.identity}" title="{l s='Information' d='Shop.Theme.Customeraccount'}" class="dropdown-item" rel="nofollow">
            <i class="material-icons me-2">&#xE853;</i>
            {l s='Information' d='Shop.Theme.Customeraccount'}
          </a>
          {if $customer.addresses|count}
            <a href="{$urls.pages.addresses}" title="{l s='Addresses' d='Shop.Theme.Customeraccount'}" class="dropdown-item" rel="nofollow">
              <i class="material-icons me-2">&#xE56A;</i>
              {l s='Addresses' d='Shop.Theme.Customeraccount'}
            </a>
          {else}
            <a href="{$urls.pages.address}" title="{l s='Add first address' d='Shop.Theme.Customeraccount'}" class="dropdown-item" rel="nofollow">
              <i class="material-icons me-2">&#xE567;</i>
              {l s='Add first address' d='Shop.Theme.Customeraccount'}
            </a>
          {/if}
          {if !$configuration.is_catalog}
            <a href="{$urls.pages.history}" title="{l s='Orders' d='Shop.Theme.Customeraccount'}" class="dropdown-item" rel="nofollow">
              <i class="material-icons me-2">&#xE916;</i>
              {l s='Orders' d='Shop.Theme.Customeraccount'}
            </a>
          {/if}
          {if !$configuration.is_catalog}
            <a href="{$urls.pages.order_slip}" title="{l s='Credit slips' d='Shop.Theme.Customeraccount'}" class="dropdown-item" rel="nofollow">
              <i class="material-icons me-2">&#xE8B0;</i>
              {l s='Credit slips' d='Shop.Theme.Customeraccount'}
            </a>
          {/if}
          {if $configuration.voucher_enabled && !$configuration.is_catalog}
            <a href="{$urls.pages.discount}" title="{l s='Vouchers' d='Shop.Theme.Customeraccount'}" class="dropdown-item" rel="nofollow">
            <i class="material-icons me-2">&#xE54E;</i>
            {l s='Vouchers' d='Shop.Theme.Customeraccount'}
            </a>
          {/if}
          {if $configuration.return_enabled && !$configuration.is_catalog}
            <a href="{$urls.pages.order_follow}" title="{l s='Merchandise returns' d='Shop.Theme.Customeraccount'}" class="dropdown-item" rel="nofollow">
              <i class="material-icons me-2">&#xE860;</i>
              {l s='Merchandise returns' d='Shop.Theme.Customeraccount'}
            </a>
          {/if}
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="{$logout_url}">
            <i class="material-icons me-2">&#xE879;</i>
            {l s='Sign out' d='Shop.Theme.Actions'}
          </a>
        </div>
      </div>
    {else}
      <a href="{$urls.pages.my_account}" title="{l s='Log in to your customer account' d='Shop.Theme.Customeraccount'}" class="btn" rel="nofollow" role="button">
        <i class="material-icons me-2">&#xE7FD;</i>
        <span class="d-none d-md-inline">{l s='Sign in' d='Shop.Theme.Actions'}</span>
      </a>
    {/if}
  </div>
</div>
