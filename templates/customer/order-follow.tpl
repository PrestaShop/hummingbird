{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file='customer/page.tpl'}

{block name='page_title'}
  {l s='Merchandise returns' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  <p>{l s='Here is a list of pending merchandise returns.' d='Shop.Theme.Customeraccount'}</p>

  {if $ordersReturn && count($ordersReturn)}
    <div class="grid-table">
      <div class="grid-table__inner grid-table__inner--5">
        <header class="grid-table__header">
          <div class="grid-table__cell">{l s='Order' d='Shop.Theme.Customeraccount'}</div>
          <div class="grid-table__cell">{l s='Return' d='Shop.Theme.Customeraccount'}</div>
          <div class="grid-table__cell">{l s='Package status' d='Shop.Theme.Customeraccount'}</div>
          <div class="grid-table__cell">{l s='Date issued' d='Shop.Theme.Customeraccount'}</div>
          <div class="grid-table__cell">{l s='Returns form' d='Shop.Theme.Customeraccount'}</div>
        </header>

        {foreach from=$ordersReturn item=return}
          <div class="grid-table__row">
            <div class="grid-table__cell" aria-label="{l s='Order' d='Shop.Theme.Customeraccount'}">
              <a href="{$return.details_url}">{$return.reference}</a>
            </div>
            <div class="grid-table__cell" aria-label="{l s='Return' d='Shop.Theme.Customeraccount'}">
              <a href="{$return.return_url}">{$return.return_number}</a>
            </div>
            <div class="grid-table__cell" aria-label="{l s='Package status' d='Shop.Theme.Customeraccount'}">
              {$return.state_name}
            </div>
            <div class="grid-table__cell" aria-label="{l s='Date issued' d='Shop.Theme.Customeraccount'}">
              {$return.return_date}
            </div>
            <div class="grid-table__cell" aria-label="{l s='Returns form' d='Shop.Theme.Customeraccount'}">
              {if $return.print_url}
                <a href="{$return.print_url}">
                  <i class="material-icons" aria-hidden="true">&#xE415;</i>
                </a>
              {else}
                --
              {/if}
            </div>
          </div>
        {/foreach}
      </div>
    </div>
  {else}
    <div class="alert alert-info" role="alert" data-alert="info">
      {l s='You have no merchandise return authorizations.' d='Shop.Notifications.Error'}
    </div>
  {/if}
{/block}
