{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<div id="block-myaccount-infos" class="footer__block col-md-6 col-lg-3">
  <p class="footer__block__title d-none d-md-flex">
    <a href="{$urls.pages.my_account}" rel="nofollow">
      {l s='Your account' d='Shop.Theme.Customeraccount'}
    </a>
  </p>

  <div role="button" class="footer__block__toggle d-md-none collapsed" data-bs-target="#footer_account_list" data-bs-toggle="collapse" aria-expanded="false">
    <span class="footer__block__title">{l s='Your account' d='Shop.Theme.Customeraccount'}</span>
    <i class="material-icons" aria-hidden="true">arrow_drop_down</i>
  </div>
  <ul class="footer__block__content footer__block__content-list collapse" id="footer_account_list">
    {if $customer.is_logged}
      <li><a href="{$urls.pages.identity}" title="{l s='Information' d='Shop.Theme.Customeraccount'}" rel="nofollow">{l s='Information' d='Shop.Theme.Customeraccount'}</a></li>
      {if $customer.addresses|count}
        <li><a href="{$urls.pages.addresses}" title="{l s='Addresses' d='Shop.Theme.Customeraccount'}" rel="nofollow">{l s='Addresses' d='Shop.Theme.Customeraccount'}</a></li>
      {else}
        <li><a href="{$urls.pages.address}" title="{l s='Add first address' d='Shop.Theme.Customeraccount'}" rel="nofollow">{l s='Add first address' d='Shop.Theme.Customeraccount'}</a></li>
      {/if}
      {if !$configuration.is_catalog}
        <li><a href="{$urls.pages.history}" title="{l s='Orders' d='Shop.Theme.Customeraccount'}" rel="nofollow">{l s='Orders' d='Shop.Theme.Customeraccount'}</a></li>
      {/if}
      {if !$configuration.is_catalog}
        <li><a href="{$urls.pages.order_slip}" title="{l s='Credit slips' d='Shop.Theme.Customeraccount'}" rel="nofollow">{l s='Credit slips' d='Shop.Theme.Customeraccount'}</a></li>
      {/if}
      {if $configuration.voucher_enabled && !$configuration.is_catalog}
        <li><a href="{$urls.pages.discount}" title="{l s='Vouchers' d='Shop.Theme.Customeraccount'}" rel="nofollow">{l s='Vouchers' d='Shop.Theme.Customeraccount'}</a></li>
      {/if}
      {if $configuration.return_enabled && !$configuration.is_catalog}
        <li><a href="{$urls.pages.order_follow}" title="{l s='Merchandise returns' d='Shop.Theme.Customeraccount'}" rel="nofollow">{l s='Merchandise returns' d='Shop.Theme.Customeraccount'}</a></li>
      {/if}
      {hook h='displayMyAccountBlock'}
      <li><a href="{$urls.actions.logout}" title="{l s='Log me out' d='Shop.Theme.Customeraccount'}" class="logout" rel="nofollow">{l s='Sign out' d='Shop.Theme.Actions'}</a></li>
    {else}
      <li><a href="{$urls.pages.guest_tracking}" title="{l s='Order tracking' d='Shop.Theme.Customeraccount'}" rel="nofollow">{l s='Order tracking' d='Shop.Theme.Customeraccount'}</a></li>
      <li><a href="{$urls.pages.my_account}" title="{l s='Log in to your customer account' d='Shop.Theme.Customeraccount'}" rel="nofollow">{l s='Sign in' d='Shop.Theme.Actions'}</a></li>
      <li><a href="{$urls.pages.register}" title="{l s='Create account' d='Shop.Theme.Customeraccount'}" rel="nofollow">{l s='Create account' d='Shop.Theme.Customeraccount'}</a></li>
      {hook h='displayMyAccountBlock'}
    {/if}
	</ul>
</div>
