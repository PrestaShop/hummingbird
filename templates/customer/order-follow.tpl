{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file='customer/page.tpl'}

{block name='page_title'}
  {l s='Merchandise returns' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  <h6>{l s='Here is a list of pending merchandise returns' d='Shop.Theme.Customeraccount'}</h6>

  {if $ordersReturn && count($ordersReturn)}
    <table class="table table-striped table-bordered d-none d-sm-block d-md-block">
      <thead class="thead-default">
        <tr>
          <th>{l s='Order' d='Shop.Theme.Customeraccount'}</th>
          <th>{l s='Return' d='Shop.Theme.Customeraccount'}</th>
          <th>{l s='Package status' d='Shop.Theme.Customeraccount'}</th>
          <th>{l s='Date issued' d='Shop.Theme.Customeraccount'}</th>
          <th>{l s='Returns form' d='Shop.Theme.Customeraccount'}</th>
        </tr>
      </thead>
      <tbody>
        {foreach from=$ordersReturn item=return}
          <tr>
            <td><a href="{$return.details_url}">{$return.reference}</a></td>
            <td><a href="{$return.return_url}">{$return.return_number}</a></td>
            <td>{$return.state_name}</td>
            <td>{$return.return_date}</td>
            <td class="text-sm-center">
              {if $return.print_url}
                <a href="{$return.print_url}">{l s='Print out' d='Shop.Theme.Actions'}</a>
              {else}
                -
              {/if}
            </td>
          </tr>
        {/foreach}
      </tbody>
    </table>
    <div class="order-returns d-none d-sm-block d-md-none">
      {foreach from=$ordersReturn item=return}
        <div class="order-return">
          <ul>
            <li>
              <strong>{l s='Order' d='Shop.Theme.Customeraccount'}</strong>
              <a href="{$return.details_url}">{$return.reference}</a>
            </li>
            <li>
              <strong>{l s='Return' d='Shop.Theme.Customeraccount'}</strong>
              <a href="{$return.return_url}">{$return.return_number}</a>
            </li>
            <li>
              <strong>{l s='Package status' d='Shop.Theme.Customeraccount'}</strong>
              {$return.state_name}
            </li>
            <li>
              <strong>{l s='Date issued' d='Shop.Theme.Customeraccount'}</strong>
              {$return.return_date}
            </li>
            {if $return.print_url}
              <li>
                <strong>{l s='Returns form' d='Shop.Theme.Customeraccount'}</strong>
                <a href="{$return.print_url}">{l s='Print out' d='Shop.Theme.Actions'}</a>
              </li>
            {/if}
          </ul>
        </div>
      {/foreach}
    </div>
    {else}
      <div class="alert alert-info" role="alert" data-alert="info">{l s='You have no merchandise return authorizations.' d='Shop.Notifications.Error'}</div>
    {/if}
{/block}
