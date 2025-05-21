{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file='customer/page.tpl'}

{$componentName = 'account-menu'}

{block name='page_title'}
  {l s='Welcome' d='Shop.Theme.Customeraccount'} {$customer.firstname} {$customer.lastname}
{/block}

{block name='page_content'}
  <div class="{$componentName} {$componentName}--main">
    <a class="{$componentName}__link" id="identity_main_link" href="{$urls.pages.identity}">
      <i class="{$componentName}__icon material-icons" aria-hidden="true">&#xE853;</i>
      {l s='Information' d='Shop.Theme.Customeraccount'}
    </a>

    {if $customer.addresses|count}
      <a class="{$componentName}__link" id="addresses_main_link" href="{$urls.pages.addresses}">
        <i class="{$componentName}__icon material-icons" aria-hidden="true">&#xF00F;</i>
        {l s='Addresses' d='Shop.Theme.Customeraccount'}
      </a>
    {else}
      <a class="{$componentName}__link" id="address_main_link" href="{$urls.pages.address}">
        <i class="{$componentName}__icon material-icons" aria-hidden="true">&#xE567;</i>
        {l s='Add first address' d='Shop.Theme.Customeraccount'}
      </a>
    {/if}

    {if !$configuration.is_catalog}
      <a class="{$componentName}__link" id="history_main_link" href="{$urls.pages.history}">
        <i class="{$componentName}__icon material-icons" aria-hidden="true">&#xE916;</i>
        {l s='Order history and details' d='Shop.Theme.Customeraccount'}
      </a>
    {/if}

    {if !$configuration.is_catalog}
      <a class="{$componentName}__link" id="order_slips_main_link" href="{$urls.pages.order_slip}">
        <i class="{$componentName}__icon material-icons" aria-hidden="true">&#xE8B0;</i>
        {l s='Credit slips' d='Shop.Theme.Customeraccount'}
      </a>
    {/if}

    {if $configuration.voucher_enabled && !$configuration.is_catalog}
      <a class="{$componentName}__link" id="discounts_main_link" href="{$urls.pages.discount}">
        <i class="{$componentName}__icon material-icons" aria-hidden="true">&#xE54E;</i>
        {l s='Vouchers' d='Shop.Theme.Customeraccount'}
      </a>
    {/if}

    {if $configuration.return_enabled && !$configuration.is_catalog}
      <a class="{$componentName}__link" id="returns_main_link" href="{$urls.pages.order_follow}">
        <i class="{$componentName}__icon material-icons" aria-hidden="true">&#xE860;</i>
        {l s='Merchandise returns' d='Shop.Theme.Customeraccount'}
      </a>
    {/if}

    {block name='display_customer_account'}
      {hook h='displayCustomerAccount'}
    {/block}

    <a class="{$componentName}__link {$componentName}__link--signout" href="{$urls.actions.logout}">
      <i class="{$componentName}__icon material-icons" aria-hidden="true">&#xE879;</i>
      {l s='Sign out' d='Shop.Theme.Actions'}
    </a>
  </div>
{/block}

{block name='account_link'}{/block}
