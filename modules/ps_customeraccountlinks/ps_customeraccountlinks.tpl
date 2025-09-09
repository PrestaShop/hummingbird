{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<div class="ps-customeraccountlinks footer-block col-md-6 col-lg-3">
  <p class="footer-block__title footer-block__title--toggle">
    <a href="{$urls.pages.my_account}" rel="nofollow">
      {l s='Your account' d='Shop.Theme.Customeraccount'}
    </a>
    <span class="stretched-link collapsed d-md-none" role="button" aria-expanded="true"
      data-bs-target="#footer_customeraccountlinks" data-bs-toggle="collapse">
      <i class="material-icons" aria-hidden="true">&#xE313;</i>
    </span>
  </p>

  <div class="footer-block__content collapse" id="footer_customeraccountlinks">
    <ul class="footer-block__list">
      {if $customer.is_logged}
        <li>
          <a href="{$urls.pages.identity}" title="{l s='Information' d='Shop.Theme.Customeraccount'}" rel="nofollow">
            {l s='Information' d='Shop.Theme.Customeraccount'}
          </a>
        </li>

        {if $customer.addresses|count}
          <li>
            <a href="{$urls.pages.addresses}" title="{l s='Addresses' d='Shop.Theme.Customeraccount'}" rel="nofollow">
              {l s='Addresses' d='Shop.Theme.Customeraccount'}
            </a>
          </li>
        {else}
          <li>
            <a href="{$urls.pages.address}" title="{l s='Add first address' d='Shop.Theme.Customeraccount'}" rel="nofollow">
              {l s='Add first address' d='Shop.Theme.Customeraccount'}
            </a>
          </li>
        {/if}

        {if !$configuration.is_catalog}
          <li>
            <a href="{$urls.pages.history}" title="{l s='Orders' d='Shop.Theme.Customeraccount'}" rel="nofollow">
              {l s='Orders' d='Shop.Theme.Customeraccount'}
            </a>
          </li>
        {/if}

        {if !$configuration.is_catalog}
          <li>
            <a href="{$urls.pages.order_slip}" title="{l s='Credit slips' d='Shop.Theme.Customeraccount'}" rel="nofollow">
              {l s='Credit slips' d='Shop.Theme.Customeraccount'}
            </a>
          </li>
        {/if}

        {if $configuration.voucher_enabled && !$configuration.is_catalog}
          <li>
            <a href="{$urls.pages.discount}" title="{l s='Vouchers' d='Shop.Theme.Customeraccount'}" rel="nofollow">
              {l s='Vouchers' d='Shop.Theme.Customeraccount'}
            </a>
          </li>
        {/if}

        {if $configuration.return_enabled && !$configuration.is_catalog}
          <li>
            <a href="{$urls.pages.order_follow}" title="{l s='Merchandise returns' d='Shop.Theme.Customeraccount'}" rel="nofollow">
              {l s='Merchandise returns' d='Shop.Theme.Customeraccount'}
            </a>
          </li>
        {/if}

        {hook h='displayMyAccountBlock'}

        <li>
          <a class="logout text-danger-dark" href="{$urls.actions.logout}" title="{l s='Log me out' d='Shop.Theme.Customeraccount'}" rel="nofollow">
            {l s='Sign out' d='Shop.Theme.Actions'}
          </a>
        </li>

      {else}
        <li>
          <a href="{$urls.pages.guest_tracking}" title="{l s='Order tracking' d='Shop.Theme.Customeraccount'}" rel="nofollow">
            {l s='Order tracking' d='Shop.Theme.Customeraccount'}
          </a>
        </li>
        <li>
          <a href="{$urls.pages.my_account}"
            title="{l s='Log in to your customer account' d='Shop.Theme.Customeraccount'}" rel="nofollow">
            {l s='Sign in' d='Shop.Theme.Actions'}
          </a>
        </li>
        <li>
          <a href="{$urls.pages.register}" title="{l s='Create account' d='Shop.Theme.Customeraccount'}" rel="nofollow">
            {l s='Create account' d='Shop.Theme.Customeraccount'}
          </a>
        </li>

        {hook h='displayMyAccountBlock'}
      {/if}
    </ul>
  </div>
</div>
