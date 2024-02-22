{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file='customer/page.tpl'}

{block name='page_title'}
  {l s='Your vouchers' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  {if $cart_rules}
    <div class="table-wrapper">
      <table class="table table-striped d-none d-xl-table">
        <thead class="thead-default">
          <tr>
            <th>{l s='Code' d='Shop.Theme.Checkout'}</th>
            <th>{l s='Description' d='Shop.Theme.Checkout'}</th>
            <th>{l s='Quantity' d='Shop.Theme.Checkout'}</th>
            <th>{l s='Value' d='Shop.Theme.Checkout'}</th>
            <th>{l s='Minimum' d='Shop.Theme.Checkout'}</th>
            <th>{l s='Cumulative' d='Shop.Theme.Checkout'}</th>
            <th>{l s='Expiration date' d='Shop.Theme.Checkout'}</th>
          </tr>
        </thead>

        <tbody>
          {foreach from=$cart_rules item=cart_rule}
            <tr>
              <th scope="row">{$cart_rule.code}</th>
              <td>{$cart_rule.name}</td>
              <td class="text-xs-end">{$cart_rule.quantity_for_user}</td>
              <td>{$cart_rule.value}</td>
              <td>{$cart_rule.voucher_minimal}</td>
              <td>{$cart_rule.voucher_cumulable}</td>
              <td>{$cart_rule.voucher_date}</td>
            </tr>
          {/foreach}
        </tbody>
      </table>
    </div>

    <div class="cart-rules row d-flex d-xl-none">
      {foreach from=$cart_rules item=cart_rule}
        <div class="cart-rule table-wrapper col-lg-6">
          <ul>
            <li class="d-flex align-items-center justify-content-between border-bottom py-3">
              <strong>{l s='Code' d='Shop.Theme.Checkout'}</strong>
              {$cart_rule.code}
            </li>

            <li class="d-flex align-items-center justify-content-between border-bottom py-3">
              <strong>{l s='Description' d='Shop.Theme.Checkout'}</strong>
              {$cart_rule.name}
            </li>

            <li class="d-flex align-items-center justify-content-between border-bottom py-3">
              <strong>{l s='Quantity' d='Shop.Theme.Checkout'}</strong>
              {$cart_rule.quantity_for_user}
            </li>

            <li class="d-flex align-items-center justify-content-between border-bottom py-3">
              <strong>{l s='Value' d='Shop.Theme.Checkout'}</strong>
              {$cart_rule.value}
            </li>

            <li class="d-flex align-items-center justify-content-between border-bottom py-3">
              <strong>{l s='Minimum' d='Shop.Theme.Checkout'}</strong>
              {$cart_rule.voucher_minimal}
            </li>

            <li class="d-flex align-items-center justify-content-between border-bottom py-3">
              <strong>{l s='Cumulative' d='Shop.Theme.Checkout'}</strong>
              {$cart_rule.voucher_cumulable}
            </li>

            <li class="d-flex align-items-center justify-content-between py-3">
              <strong>{l s='Expiration date' d='Shop.Theme.Checkout'}</strong>
              {$cart_rule.voucher_date}
            </li>
          </ul>
        </div>
      {/foreach}
    </div>
  {else}
    <div class="alert alert-info" role="alert" data-alert="info">{l s='You do not have any vouchers.' d='Shop.Notifications.Warning'}</div>
  {/if}
{/block}
