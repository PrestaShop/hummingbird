{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends 'customer/page.tpl'}

{block name='page_title'}
  {l s='Your addresses' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  <p>{l s='Manage your addresses for billing and delivery to streamline your future orders.' d='Shop.Theme.Customeraccount'}</p>

  <div class="addresses">
    <div class="addresses__list">
      {foreach $customer.addresses as $address}
        {block name='customer_address'}
          {include file='customer/_partials/block-address.tpl' address=$address}
        {/block}
      {/foreach}

      <a class="address-card address-card--add-address" href="{$urls.pages.address}" data-link-action="add-address">
        <span class="address-card__add-text">{l s='Add new address' d='Shop.Theme.Actions'}</span>

        <span class="address-card__add-icon btn btn-square btn-square-icon btn-primary">
          <i class="material-icons" aria-hidden="true">&#xE145;</i>
        </span>
      </a>
    </div>
  </div>
{/block}
