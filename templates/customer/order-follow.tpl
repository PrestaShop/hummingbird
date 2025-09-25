{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file='customer/page.tpl'}

{block name='page_title'}
  {l s='Merchandise returns' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  <p id="order_merchandise_returns_description">{l s='Here is a list of pending merchandise returns.' d='Shop.Theme.Customeraccount'}</p>

  {if $ordersReturn && count($ordersReturn)}
    <div class="grid-table" role="table" aria-label="{l s='Merchandise returns' d='Shop.Theme.Customeraccount'}" aria-describedby="order_merchandise_returns_description">
      <div class="grid-table__inner grid-table__inner--5" role="rowgroup">
        <div class="grid-table__header" role="row">
          <span class="grid-table__cell" role="columnheader">{l s='Order' d='Shop.Theme.Customeraccount'}</span>
          <span class="grid-table__cell" role="columnheader">{l s='Return' d='Shop.Theme.Customeraccount'}</span>
          <span class="grid-table__cell" role="columnheader">{l s='Package status' d='Shop.Theme.Customeraccount'}</span>
          <span class="grid-table__cell" role="columnheader">{l s='Date issued' d='Shop.Theme.Customeraccount'}</span>
          <span class="grid-table__cell" role="columnheader">{l s='Returns details' d='Shop.Theme.Customeraccount'}</span>
        </div>

        {foreach from=$ordersReturn item=return}
          <div class="grid-table__row" role="row">
            <span class="grid-table__cell" role="cell" data-ps-label="{l s='Order' d='Shop.Theme.Customeraccount'}">
              <a href="{$return.details_url}">
                <span class="visually-hidden">{l s='View order reference' d='Shop.Theme.Customeraccount'} </span>
                {$return.reference}
              </a>
            </span>
            <span class="grid-table__cell" role="cell" data-ps-label="{l s='Return' d='Shop.Theme.Customeraccount'}">
              <a href="{$return.return_url}">
                <span class="visually-hidden">{l s='View return number' d='Shop.Theme.Customeraccount'} </span>
                {$return.return_number}
              </a>
            </span>
            <span class="grid-table__cell" role="cell" data-ps-label="{l s='Package status' d='Shop.Theme.Customeraccount'}">
              {$return.state_name}
            </span>
            <span class="grid-table__cell" role="cell" data-ps-label="{l s='Date issued' d='Shop.Theme.Customeraccount'}">
              <small class="text-secondary">
                {$return.return_date}
              </small>
            </span>
            <span class="grid-table__cell" role="cell" data-ps-label="{l s='Returns details' d='Shop.Theme.Customeraccount'}">
              {if $return.print_url}
                <a href="{$return.print_url}" aria-label="{l s='View returns details' d='Shop.Theme.Customeraccount'}">
                  <i class="material-icons" aria-hidden="true">&#xE415;</i>
                </a>
              {else}
                --
              {/if}
            </span>
          </div>
        {/foreach}
      </div>
    </div>
  {else}
    <div class="alert alert-info" role="alert" data-alert="info" tabindex="0">
      {l s='You have no merchandise return authorizations.' d='Shop.Notifications.Error'}
    </div>
  {/if}
{/block}
