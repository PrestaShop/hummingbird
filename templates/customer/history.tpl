{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends 'customer/page.tpl'}

{block name='page_title'}
  {l s='Order history' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  <p id="order_history_description">{l s='Here are the orders you\'ve placed since your account was created.' d='Shop.Theme.Customeraccount'}</p>

  {if $orders}
    <div class="order-history" role="table" aria-label="{l s='Order history' d='Shop.Theme.Customeraccount'}" aria-describedby="order_history_description">
      <div class="order-history__inner" role="rowgroup">
        <div class="order-history__header" role="row">
          <span class="order-history__cell" role="columnheader">
            {l s='Order reference' d='Shop.Theme.Checkout'}
          </span>
          <span class="order-history__cell" role="columnheader">
            {l s='Date' d='Shop.Theme.Checkout'}
          </span>
          <span class="order-history__cell" role="columnheader">
            {l s='Total price' d='Shop.Theme.Checkout'}
          </span>
          <span class="order-history__cell" role="columnheader">
            {l s='Payment' d='Shop.Theme.Checkout'}
          </span>
          <span class="order-history__cell" role="columnheader">
            {l s='Status' d='Shop.Theme.Checkout'}
          </span>
          <span class="order-history__cell" role="columnheader">
            {l s='Invoice' d='Shop.Theme.Checkout'}
          </span>
          <span class="order-history__cell" role="columnheader" aria-label="{l s='Actions' d='Shop.Theme.Checkout'}"></span>
        </div>

        {foreach from=$orders item=order}
          <div class="order-history__row" role="row">
            <span class="order-history__cell order-history__cell--reference" role="cell" data-ps-label="{l s='Order reference' d='Shop.Theme.Checkout'}">
              {$order.details.reference}
            </span>
            <span class="order-history__cell order-history__cell--date" role="cell" data-ps-label="{l s='Date' d='Shop.Theme.Checkout'}">
              {$order.details.order_date}
            </span>
            <span class="order-history__cell order-history__cell--total" role="cell" data-ps-label="{l s='Total price' d='Shop.Theme.Checkout'}">
              {$order.totals.total.value}
            </span>
            <span class="order-history__cell order-history__cell--payment" role="cell" data-ps-label="{l s='Payment' d='Shop.Theme.Checkout'}">
              {$order.details.payment}
            </span>
            <span class="order-history__cell order-history__cell--status" role="cell" data-ps-label="{l s='Status' d='Shop.Theme.Checkout'}">
              <span
                class="order-history__status order-history__status--{$order.history.current.contrast} badge pill"
                style="background-color:{$order.history.current.color}"
              >
                {$order.history.current.ostate_name}
              </span>
            </span>
            <span class="order-history__cell order-history__cell--invoice" role="cell" data-ps-label="{l s='Invoice' d='Shop.Theme.Checkout'}">
              {if $order.details.invoice_url}
                <a href="{$order.details.invoice_url}" aria-label="{l s='View invoice' d='Shop.Theme.Actions'}">
                  <i class="material-icons" aria-hidden="true">&#xE415;</i>
                </a>
              {else}
                --
              {/if}
            </span>
            <span class="order-history__cell order-history__cell--actions" role="cell">
              <a class="btn btn-sm btn-outline-primary" href="{$order.details.details_url}" data-link-action="view-order-details">
                <i class="material-icons" aria-hidden="true">&#xE88E;</i>
                {l s='Details' d='Shop.Theme.Customeraccount'}
              </a>

              {if $order.details.reorder_url}
                <a class="btn btn-sm btn-outline-primary" href="{$order.details.reorder_url}">
                  <i class="material-icons" aria-hidden="true">&#xF1CC;</i>
                  {l s='Reorder' d='Shop.Theme.Actions'}
                </a>
              {/if}
            </span>
          </div>
        {/foreach}
      </div>
    </div>
  {else}
    <div class="alert alert-info" role="alert">{l s='You have not placed any orders.' d='Shop.Notifications.Warning'}</div>
  {/if}
{/block}
