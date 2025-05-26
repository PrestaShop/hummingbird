{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file='customer/page.tpl'}

{block name='page_title'}
  {l s='Credit slips' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  <p>{l s='Credit slips you have received after canceled orders.' d='Shop.Theme.Customeraccount'}</p>

  {if $credit_slips}
    <div class="grid-table">
      <div class="grid-table__inner grid-table__inner--4">
        <header class="grid-table__header">
          <div class="grid-table__cell">{l s='Order' d='Shop.Theme.Customeraccount'}</div>
          <div class="grid-table__cell">{l s='Credit slip' d='Shop.Theme.Customeraccount'}</div>
          <div class="grid-table__cell">{l s='Date issued' d='Shop.Theme.Customeraccount'}</div>
          <div class="grid-table__cell">{l s='View credit slip' d='Shop.Theme.Customeraccount'}</div>
        </header>

        {foreach from=$credit_slips item=slip}
          <div class="grid-table__row">
            <div class="grid-table__cell" aria-label="{l s='Order' d='Shop.Theme.Customeraccount'}">
              <a href="{$slip.order_url_details}" data-link-action="view-order-details">{$slip.order_reference}</a>
            </div>
            <div class="grid-table__cell" aria-label="{l s='Credit slip' d='Shop.Theme.Customeraccount'}">
              {$slip.credit_slip_number}
            </div>
            <div class="grid-table__cell" aria-label="{l s='Date issued' d='Shop.Theme.Customeraccount'}">
              <small class="text-secondary">{$slip.credit_slip_date}</small>
            </div>
            <div class="grid-table__cell" aria-label="{l s='View credit slip' d='Shop.Theme.Customeraccount'}">
              <a href="{$slip.url}"><i class="material-icons" aria-hidden="true">&#xE415;</i></a>
            </div>
          </div>
        {/foreach}
      </div>
    </div>
  {else}
    <div class="alert alert-info" role="alert" data-alert="info">
      {l s='You have not received any credit slips.' d='Shop.Notifications.Warning'}
    </div>
  {/if}
{/block}
