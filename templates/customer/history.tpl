{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends 'customer/page.tpl'}

{block name='page_title'}
  {l s='Order history' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  <p>{l s='Here are the orders you\'ve placed since your account was created.' d='Shop.Theme.Customeraccount'}</p>

  {if $orders}
    <div class="order-history">
      <div class="order-history__inner">
        <div class="order-history__header">
          <div class="order-history__cell">
            <span>{l s='Order reference' d='Shop.Theme.Checkout'}</span>
          </div>
          <div class="order-history__cell">
            <span>{l s='Date' d='Shop.Theme.Checkout'}</span>
          </div>
          <div class="order-history__cell">
            <span>{l s='Total price' d='Shop.Theme.Checkout'}</span>
          </div>
          <div class="order-history__cell">
            <span>{l s='Payment' d='Shop.Theme.Checkout'}</span>
          </div>
          <div class="order-history__cell">
            <span>{l s='Status' d='Shop.Theme.Checkout'}</span>
          </div>
          <div class="order-history__cell">
            <span>{l s='Invoice' d='Shop.Theme.Checkout'}</span>
          </div>
          <div class="order-history__cell"></div>
        </div>

        {foreach from=$orders item=order}
          <div class="order-history__row">
            <div class="order-history__cell order-history__cell--reference" aria-label="{l s='Order reference' d='Shop.Theme.Checkout'}">
              <span>{$order.details.reference}</span>
            </div>
            <div class="order-history__cell order-history__cell--date" aria-label="{l s='Date' d='Shop.Theme.Checkout'}">
              <span>{$order.details.order_date}</span>
            </div>
            <div class="order-history__cell order-history__cell--total" aria-label="{l s='Total price' d='Shop.Theme.Checkout'}">
              <span>{$order.totals.total.value}</span>
            </div>
            <div class="order-history__cell order-history__cell--payment" aria-label="{l s='Payment' d='Shop.Theme.Checkout'}">
              <span>{$order.details.payment}</span>
            </div>
            <div class="order-history__cell order-history__cell--status" aria-label="{l s='Status' d='Shop.Theme.Checkout'}">
              <span
                class="order-history__status order-history__status--{$order.history.current.contrast} badge pill"
                style="background-color:{$order.history.current.color}"
              >
                {$order.history.current.ostate_name}
              </span>
            </div>
            <div class="order-history__cell order-history__cell--invoice" aria-label="{l s='Invoice' d='Shop.Theme.Checkout'}">
              {if $order.details.invoice_url}
                <a href="{$order.details.invoice_url}">
                  <i class="material-icons" aria-label="{l s='Open Invoice' d='Shop.Theme.Actions'}">&#xE415;</i>
                </a>
              {else}
                --
              {/if}
            </div>
            <div class="order-history__cell order-history__cell--actions">
              <a class="btn btn-sm btn-outline-primary" href="{$order.details.details_url}" data-link-action="view-order-details">
                <i class="material-icons">&#xE88E;</i>
                {l s='Details' d='Shop.Theme.Customeraccount'}
              </a>

              {if $order.details.reorder_url}
                <a class="btn btn-sm btn-outline-primary" href="{$order.details.reorder_url}">
                  <i class="material-icons">&#xF1CC;</i>
                  {l s='Reorder' d='Shop.Theme.Actions'}
                </a>
              {/if}
            </div>
          </div>
        {/foreach}
      </div>
    </div>
  {else}
    <div class="alert alert-info" role="alert" data-alert="info">{l s='You have not placed any orders.' d='Shop.Notifications.Warning'}</div>
  {/if}
{/block}
