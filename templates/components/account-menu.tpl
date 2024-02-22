{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$componentName = 'account-menu'}

{block name='account_menu'}
  <div class="{$componentName} d-none d-md-flex">
    <p class="{$componentName}__title mb-4 h4">{l s='My Account' d='Shop.Theme.Customeraccount'}</p>

    <a class="{$componentName}__line{if $urls.current_url === $urls.pages.identity} active{/if}" id="identity__link" href="{$urls.pages.identity}">
      <span class="link-item">
      <i class="material-icons" aria-hidden="true">&#xE853;</i>
        {l s='Information' d='Shop.Theme.Customeraccount'}
      </span>
    </a>

    {if $customer.addresses|count}
      <a class="{$componentName}__line{if $urls.current_url === $urls.pages.addresses} active{/if}" id="addresses__link" href="{$urls.pages.addresses}">
        <span class="link-item">
          <i class="material-icons" aria-hidden="true">&#xE56A;</i>
          {l s='Addresses' d='Shop.Theme.Customeraccount'}
        </span>
      </a>
    {else}
      <a class="{$componentName}__line{if $urls.current_url === $urls.pages.address} active{/if}" id="address__link" href="{$urls.pages.address}">
        <span class="link-item">
          <i class="material-icons" aria-hidden="true">&#xE567;</i>
          {l s='Add first address' d='Shop.Theme.Customeraccount'}
        </span>
      </a>
    {/if}

    {if !$configuration.is_catalog}
      <a class="{$componentName}__line{if $urls.current_url === $urls.pages.history} active{/if}" id="history__link" href="{$urls.pages.history}">
        <span class="link-item">
          <i class="material-icons" aria-hidden="true">&#xE916;</i>
          {l s='Order history and details' d='Shop.Theme.Customeraccount'}
        </span>
      </a>
    {/if}

    {if !$configuration.is_catalog}
      <a class="{$componentName}__line{if $urls.current_url === $urls.pages.order_slip} active{/if}" id="order-slips__link" href="{$urls.pages.order_slip}">
        <span class="link-item">
          <i class="material-icons" aria-hidden="true">&#xE8B0;</i>
          {l s='Credit slips' d='Shop.Theme.Customeraccount'}
        </span>
      </a>
    {/if}

    {if $configuration.voucher_enabled && !$configuration.is_catalog}
      <a class="{$componentName}__line{if $urls.current_url === $urls.pages.discount} active{/if}" id="discounts__link" href="{$urls.pages.discount}">
        <span class="link-item">
          <i class="material-icons" aria-hidden="true">&#xE54E;</i>
          {l s='Vouchers' d='Shop.Theme.Customeraccount'}
        </span>
      </a>
    {/if}

    {if $configuration.return_enabled && !$configuration.is_catalog}
      <a class="{$componentName}__line{if $urls.current_url === $urls.pages.order_follow} active{/if}" id="returns__link" href="{$urls.pages.order_follow}">
        <span class="link-item">
          <i class="material-icons" aria-hidden="true">&#xE860;</i>
          {l s='Merchandise returns' d='Shop.Theme.Customeraccount'}
        </span>
      </a>
    {/if}

    {block name='display_customer_account'}
      {hook h='displayCustomerAccount'}
    {/block}

    <a class="{$componentName}__line{if $urls.current_url === $urls.pages.order_follow} active{/if} {$componentName}--signout" id="returns__link" href="{$urls.actions.logout}">
      <span class="link-item">
        <i class="material-icons" aria-hidden="true">exit_to_app</i>
        {l s='Sign out' d='Shop.Theme.Actions'}
      </span>
    </a>
  </div>
{/block}
