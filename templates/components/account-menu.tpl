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
{$componentName = 'account-menu'}

{block name='account-menu'}
  <div class="{$componentName}">
    <h2 class="{$componentName}-title">{l s='My Account' d='Shop.Theme.Customeraccount'}</h2>
    <a class="{$componentName}-line{if $urls.current_url === $urls.pages.identity} active{/if}" id="identity-link" href="{$urls.pages.identity}">
      <span class="{$componentName}-link">
        <i class="material-icons">&#xE853;</i>
        {l s='Information' d='Shop.Theme.Customeraccount'}
      </span>
    </a>

    {if $customer.addresses|count}
      <a class="{$componentName}-line{if $urls.current_url === $urls.pages.addresses} active{/if}" id="addresses-link" href="{$urls.pages.addresses}">
        <span class="{$componentName}-link">
          <i class="material-icons">&#xE56A;</i>
          {l s='Addresses' d='Shop.Theme.Customeraccount'}
        </span>
      </a>
    {else}
      <a class="{$componentName}-line{if $urls.current_url === $urls.pages.address} active{/if}" id="address-link" href="{$urls.pages.address}">
        <span class="{$componentName}-link">
          <i class="material-icons">&#xE567;</i>
          {l s='Add first address' d='Shop.Theme.Customeraccount'}
        </span>
      </a>
    {/if}

    {if !$configuration.is_catalog}
      <a class="{$componentName}-line{if $urls.current_url === $urls.pages.history} active{/if}" id="history-link" href="{$urls.pages.history}">
        <span class="{$componentName}-link">
          <i class="material-icons">&#xE916;</i>
          {l s='Order history and details' d='Shop.Theme.Customeraccount'}
        </span>
      </a>
    {/if}

    {if !$configuration.is_catalog}
      <a class="{$componentName}-line{if $urls.current_url === $urls.pages.order_slip} active{/if}" id="order-slips-link" href="{$urls.pages.order_slip}">
        <span class="{$componentName}-link">
          <i class="material-icons">&#xE8B0;</i>
          {l s='Credit slips' d='Shop.Theme.Customeraccount'}
        </span>
      </a>
    {/if}

    {if $configuration.voucher_enabled && !$configuration.is_catalog}
      <a class="{$componentName}-line{if $urls.current_url === $urls.pages.discount} active{/if}" id="discounts-link" href="{$urls.pages.discount}">
        <span class="{$componentName}-link">
          <i class="material-icons">&#xE54E;</i>
          {l s='Vouchers' d='Shop.Theme.Customeraccount'}
        </span>
      </a>
    {/if}

    {if $configuration.return_enabled && !$configuration.is_catalog}
      <a class="{$componentName}-line{if $urls.current_url === $urls.pages.order_follow} active{/if}" id="returns-link" href="{$urls.pages.order_follow}">
        <span class="{$componentName}-link">
          <i class="material-icons">&#xE860;</i>
          {l s='Merchandise returns' d='Shop.Theme.Customeraccount'}
        </span>
      </a>
    {/if}

    {block name='display_customer_account'}
      {hook h='displayCustomerAccount'}
    {/block}
  </div>
{/block}
