{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file='customer/page.tpl'}

{block name='page_title'}
  {l s='Your vouchers' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  <p id="vouchers_description">{l s='View and manage your available vouchers and discount codes for use on your next purchase.' d='Shop.Theme.Customeraccount'}</p>

  {if $cart_rules}
    <div class="grid-table" role="table" aria-label="{l s='Your vouchers' d='Shop.Theme.Customeraccount'}" aria-describedby="vouchers_description">
      <div class="grid-table__inner grid-table__inner--7" role="rowgroup">
        <div class="grid-table__header" role="row">
          <span class="grid-table__cell" role="columnheader">{l s='Code' d='Shop.Theme.Checkout'}</span>
          <span class="grid-table__cell" role="columnheader">{l s='Name' d='Shop.Theme.Checkout'}</span>
          <span class="grid-table__cell" role="columnheader">{l s='Quantity' d='Shop.Theme.Checkout'}</span>
          <span class="grid-table__cell" role="columnheader">{l s='Value' d='Shop.Theme.Checkout'}</span>
          <span class="grid-table__cell" role="columnheader">{l s='Minimum' d='Shop.Theme.Checkout'}</span>
          <span class="grid-table__cell" role="columnheader">{l s='Cumulative' d='Shop.Theme.Checkout'}</span>
          <span class="grid-table__cell" role="columnheader">{l s='Expiration date' d='Shop.Theme.Checkout'}</span>
        </div>

        {foreach from=$cart_rules item=cart_rule}
          <div class="grid-table__row" role="row">
            <span class="grid-table__cell" role="cell" data-ps-label="{l s='Code' d='Shop.Theme.Checkout'}">
              <strong>{$cart_rule.code}</strong>
            </span>

            <span class="grid-table__cell" role="cell" data-ps-label="{l s='Name' d='Shop.Theme.Checkout'}">
              <small class="text-secondary">{$cart_rule.name}</small>
            </span>

            <span class="grid-table__cell" role="cell" data-ps-label="{l s='Quantity' d='Shop.Theme.Checkout'}">{$cart_rule.quantity_for_user}</span>

            <span class="grid-table__cell" role="cell" data-ps-label="{l s='Value' d='Shop.Theme.Checkout'}">
              <strong>{$cart_rule.value}</strong>
            </span>

            <span class="grid-table__cell" role="cell" data-ps-label="{l s='Minimum' d='Shop.Theme.Checkout'}">{$cart_rule.voucher_minimal}</span>

            <span class="grid-table__cell" role="cell" data-ps-label="{l s='Cumulative' d='Shop.Theme.Checkout'}">{$cart_rule.voucher_cumulable}</span>

            <span class="grid-table__cell" role="cell" data-ps-label="{l s='Expiration date' d='Shop.Theme.Checkout'}">
              <small class="text-secondary">{$cart_rule.voucher_date}</small>
            </span>
          </div>
        {/foreach}
      </div>
    </div>
  {else}
    <div class="alert alert-info" role="alert" data-alert="info">
      {l s='You do not have any vouchers.' d='Shop.Notifications.Warning'}
    </div>
  {/if}
{/block}
