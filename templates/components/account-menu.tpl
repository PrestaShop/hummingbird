{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$componentName = 'account-menu'}

{block name='account_menu'}
  <aside class="{$componentName} {$componentName}--sidebar">
    <p class="h2 {$componentName}__title">{l s='My Account' d='Shop.Theme.Customeraccount'}</p>

    <nav class="{$componentName}__nav" aria-label="{l s='My account navigation sidebar' d='Shop.Theme.Customeraccount'}">
      <a 
        class="{$componentName}__link{if $urls.current_url === $urls.pages.identity} {$componentName}__link--active{/if}"
        id="identity_link"
        href="{$urls.pages.identity}"
        {if $urls.current_url === $urls.pages.identity}aria-current="page"{/if}
      >
        <i class="{$componentName}__icon material-icons" aria-hidden="true">&#xE853;</i>
        {l s='Information' d='Shop.Theme.Customeraccount'}
      </a>

      {if $customer.addresses|count}
        <a 
          class="{$componentName}__link{if $urls.current_url === $urls.pages.addresses} {$componentName}__link--active{/if}"
          id="addresses_link"
          href="{$urls.pages.addresses}"
          {if $urls.current_url === $urls.pages.addresses}aria-current="page"{/if}
        >
          <i class="{$componentName}__icon material-icons" aria-hidden="true">&#xF00F;</i>
          {l s='Addresses' d='Shop.Theme.Customeraccount'}
        </a>
      {else}
        <a
          class="{$componentName}__link{if $urls.current_url === $urls.pages.address} {$componentName}__link--active{/if}"
          id="address_link"
          href="{$urls.pages.address}"
          {if $urls.current_url === $urls.pages.address}aria-current="page"{/if}
        >
          <i class="{$componentName}__icon material-icons" aria-hidden="true">&#xEF3A;</i>
          {l s='Add first address' d='Shop.Theme.Customeraccount'}
        </a>
      {/if}

      {if !$configuration.is_catalog}
        <a 
          class="{$componentName}__link{if $urls.current_url === $urls.pages.history} {$componentName}__link--active{/if}"
          id="history_link"
          href="{$urls.pages.history}"
          {if $urls.current_url === $urls.pages.history}aria-current="page"{/if}
        >
          <i class="{$componentName}__icon material-icons" aria-hidden="true">&#xE916;</i>
          {l s='Order history and details' d='Shop.Theme.Customeraccount'}
        </a>
      {/if}

      {if !$configuration.is_catalog}
        <a 
          class="{$componentName}__link{if $urls.current_url === $urls.pages.order_slip} {$componentName}__link--active{/if}"
          id="order-slips_link"
          href="{$urls.pages.order_slip}"
          {if $urls.current_url === $urls.pages.order_slip}aria-current="page"{/if}
        >
          <i class="{$componentName}__icon material-icons" aria-hidden="true">&#xE8B0;</i>
          {l s='Credit slips' d='Shop.Theme.Customeraccount'}
        </a>
      {/if}

      {if $configuration.voucher_enabled && !$configuration.is_catalog}
        <a 
          class="{$componentName}__link{if $urls.current_url === $urls.pages.discount} {$componentName}__link--active{/if}"
          id="discounts_link"
          href="{$urls.pages.discount}"
          {if $urls.current_url === $urls.pages.discount}aria-current="page"{/if}
        >
          <i class="{$componentName}__icon material-icons" aria-hidden="true">&#xE54E;</i>
          {l s='Vouchers' d='Shop.Theme.Customeraccount'}
        </a>
      {/if}

      {if $configuration.return_enabled && !$configuration.is_catalog}
        <a 
          class="{$componentName}__link{if $urls.current_url === $urls.pages.order_follow} {$componentName}__link--active{/if}"
          id="returns_link"
          href="{$urls.pages.order_follow}"
          {if $urls.current_url === $urls.pages.order_follow}aria-current="page"{/if}
        >
          <i class="{$componentName}__icon material-icons" aria-hidden="true">&#xE860;</i>
          {l s='Merchandise returns' d='Shop.Theme.Customeraccount'}
        </a>
      {/if}

      {block name='display_customer_account'}
        {hook h='displayCustomerAccount'}
      {/block}

      <a class="{$componentName}__link {$componentName}__link--signout" id="signout_link" href="{$urls.actions.logout}">
        <i class="{$componentName}__icon material-icons" aria-hidden="true">&#xE879;</i>
        {l s='Sign out' d='Shop.Theme.Actions'}
      </a>
    </nav>
  </aside>
{/block}
