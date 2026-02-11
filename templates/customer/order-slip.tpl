{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file='customer/page.tpl'}

{block name='page_title'}
  {l s='Credit slips' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  <p id="order_credit_slips_description">{l s='Credit slips you have received after canceled orders.' d='Shop.Theme.Customeraccount'}</p>

  {if $credit_slips}
    <div class="grid-table" role="table" aria-label="{l s='Credit slips' d='Shop.Theme.Customeraccount'}" aria-describedby="order_credit_slips_description">
      <div class="grid-table__inner grid-table__inner--4" role="rowgroup">
        <div class="grid-table__header" role="row">
          <span class="grid-table__cell" role="columnheader">{l s='Order' d='Shop.Theme.Customeraccount'}</span>
          <span class="grid-table__cell" role="columnheader">{l s='Credit slip' d='Shop.Theme.Customeraccount'}</span>
          <span class="grid-table__cell" role="columnheader">{l s='Date issued' d='Shop.Theme.Customeraccount'}</span>
          <span class="grid-table__cell" role="columnheader">{l s='Credit slip' d='Shop.Theme.Customeraccount'}</span>
        </div>

        {foreach from=$credit_slips item=slip}
          <div class="grid-table__row" role="row">
            <span class="grid-table__cell" role="cell" data-ps-label="{l s='Order' d='Shop.Theme.Customeraccount'}">
              <a href="{$slip.order_url_details}" data-link-action="view-order-details">
                <span class="visually-hidden">{l s='View order reference' d='Shop.Theme.Customeraccount'} </span>
                {$slip.order_reference}
              </a>
            </span>
            <span class="grid-table__cell" role="cell" data-ps-label="{l s='Credit slip' d='Shop.Theme.Customeraccount'}">
              {$slip.credit_slip_number}
            </span>
            <span class="grid-table__cell" role="cell" data-ps-label="{l s='Date issued' d='Shop.Theme.Customeraccount'}">
              <small class="text-secondary">{$slip.credit_slip_date}</small>
            </span>
            <span class="grid-table__cell" role="cell" data-ps-label="{l s='Credit slip' d='Shop.Theme.Customeraccount'}">
              <a href="{$slip.url}" aria-label="{l s='View credit slip' d='Shop.Theme.Customeraccount'}"><i class="material-icons" aria-hidden="true">&#xE415;</i></a>
            </span>
          </div>
        {/foreach}
      </div>
    </div>
  {else}
    <div class="alert alert-info" role="alert">
      {l s='You have not received any credit slips.' d='Shop.Notifications.Warning'}
    </div>
  {/if}
{/block}
