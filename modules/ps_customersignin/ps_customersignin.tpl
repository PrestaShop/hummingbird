{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<div id="_desktop_user_info">
  <div class="user-info d-flex align-items-center">
    {if $customer.is_logged}
      <div class="dropdown header-block">
        <a
          href="#"
          class="dropdown-toggle header-block__action-btn"
          role="button"
          id="userMenuButton"
          data-bs-toggle="dropdown"
          aria-haspopup="true"
          aria-expanded="false"
          aria-label="{l s='View my account (%s)' d='Shop.Theme.Customeraccount' sprintf=[$customerName]}">
          <i class="material-icons header-block__icon" aria-hidden="true">&#xE7FD;</i>
          <span class="header-block__title d-lg-inline d-none">{$customerName|truncate:22:"..":true}</span>
        </a>

        <div class="dropdown-menu dropdown-menu-start" aria-labelledby="userMenuButton">
          <a class="dropdown-item" href="{$urls.pages.my_account}">
            <i class="material-icons me-2" aria-hidden="true">&#xF02E;</i>
            {l s='Your account' d='Shop.Theme.Customeraccount'}
          </a>
          <div class="dropdown-divider"></div>
          <a href="{$urls.pages.identity}" title="{l s='Information' d='Shop.Theme.Customeraccount'}" class="dropdown-item" rel="nofollow">
            <i class="material-icons me-2" aria-hidden="true">&#xE853;</i>
            {l s='Information' d='Shop.Theme.Customeraccount'}
          </a>
          {if $customer.addresses|count}
            <a href="{$urls.pages.addresses}" title="{l s='Addresses' d='Shop.Theme.Customeraccount'}" class="dropdown-item" rel="nofollow">
              <i class="material-icons me-2" aria-hidden="true">&#xE56A;</i>
              {l s='Addresses' d='Shop.Theme.Customeraccount'}
            </a>
          {else}
            <a href="{$urls.pages.address}" title="{l s='Add first address' d='Shop.Theme.Customeraccount'}" class="dropdown-item" rel="nofollow">
              <i class="material-icons me-2" aria-hidden="true">&#xE567;</i>
              {l s='Add first address' d='Shop.Theme.Customeraccount'}
            </a>
          {/if}
          {if !$configuration.is_catalog}
            <a href="{$urls.pages.history}" title="{l s='Orders' d='Shop.Theme.Customeraccount'}" class="dropdown-item" rel="nofollow">
              <i class="material-icons me-2" aria-hidden="true">&#xE916;</i>
              {l s='Orders' d='Shop.Theme.Customeraccount'}
            </a>
          {/if}
          {if !$configuration.is_catalog}
            <a href="{$urls.pages.order_slip}" title="{l s='Credit slips' d='Shop.Theme.Customeraccount'}" class="dropdown-item" rel="nofollow">
              <i class="material-icons me-2" aria-hidden="true">&#xE8B0;</i>
              {l s='Credit slips' d='Shop.Theme.Customeraccount'}
            </a>
          {/if}
          {if $configuration.voucher_enabled && !$configuration.is_catalog}
            <a href="{$urls.pages.discount}" title="{l s='Vouchers' d='Shop.Theme.Customeraccount'}" class="dropdown-item" rel="nofollow">
            <i class="material-icons me-2" aria-hidden="true">&#xE54E;</i>
            {l s='Vouchers' d='Shop.Theme.Customeraccount'}
            </a>
          {/if}
          {if $configuration.return_enabled && !$configuration.is_catalog}
            <a href="{$urls.pages.order_follow}" title="{l s='Merchandise returns' d='Shop.Theme.Customeraccount'}" class="dropdown-item" rel="nofollow">
              <i class="material-icons me-2" aria-hidden="true">&#xE860;</i>
              {l s='Merchandise returns' d='Shop.Theme.Customeraccount'}
            </a>
          {/if}
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="{$logout_url}">
            <i class="material-icons me-2" aria-hidden="true">&#xE879;</i>
            {l s='Sign out' d='Shop.Theme.Actions'}
          </a>
        </div>
      </div>
    {else}
      <div class="header-block">
        <a
          href="{$urls.pages.authentication}?back={$urls.current_url|urlencode}"
          title="{l s='Log in to your customer account' d='Shop.Theme.Customeraccount'}"
          class="header-block__action-btn"
          rel="nofollow"
          role="button">
          <i class="material-icons header-block__icon" aria-hidden="true">&#xE7FD;</i>
          <span class="d-none d-md-inline header-block__title">{l s='Sign in' d='Shop.Theme.Actions'}</span>
        </a>
      </div>
    {/if}
  </div>
</div>
