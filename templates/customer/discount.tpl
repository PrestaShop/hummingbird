{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file='customer/page.tpl'}

{block name='page_title'}
  {l s='Your vouchers' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  <p>{l s='View and manage your available vouchers and discount codes for use on your next purchase.' d='Shop.Theme.Customeraccount'}</p>

  {if $cart_rules}
    <div class="grid-table" data-role="table">
      <div class="grid-table__inner grid-table__inner--7">
        <header class="grid-table__header">
          <div class="grid-table__cell">{l s='Code' d='Shop.Theme.Checkout'}</div>
          <div class="grid-table__cell">{l s='Name' d='Shop.Theme.Checkout'}</div>
          <div class="grid-table__cell">{l s='Quantity' d='Shop.Theme.Checkout'}</div>
          <div class="grid-table__cell">{l s='Value' d='Shop.Theme.Checkout'}</div>
          <div class="grid-table__cell">{l s='Minimum' d='Shop.Theme.Checkout'}</div>
          <div class="grid-table__cell">{l s='Cumulative' d='Shop.Theme.Checkout'}</div>
          <div class="grid-table__cell">{l s='Expiration date' d='Shop.Theme.Checkout'}</div>
        </header>

        {foreach from=$cart_rules item=cart_rule}
          <div class="grid-table__row">
            <div class="grid-table__cell" aria-label="{l s='Code' d='Shop.Theme.Checkout'}">
              <strong>{$cart_rule.code}</strong>
            </div>

            <div class="grid-table__cell" aria-label="{l s='Name' d='Shop.Theme.Checkout'}">
              <small class="text-secondary">{$cart_rule.name}</small>
            </div>

            <div class="grid-table__cell" aria-label="{l s='Quantity' d='Shop.Theme.Checkout'}">{$cart_rule.quantity_for_user}</div>

            <div class="grid-table__cell" aria-label="{l s='Value' d='Shop.Theme.Checkout'}">
              <strong>{$cart_rule.value}</strong>
            </div>

            <div class="grid-table__cell" aria-label="{l s='Minimum' d='Shop.Theme.Checkout'}">{$cart_rule.voucher_minimal}</div>

            <div class="grid-table__cell" aria-label="{l s='Cumulative' d='Shop.Theme.Checkout'}">{$cart_rule.voucher_cumulable}</div>

            <div class="grid-table__cell" aria-label="{l s='Expiration date' d='Shop.Theme.Checkout'}">
              <small class="text-secondary">{$cart_rule.voucher_date}</small>
            </div>
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
