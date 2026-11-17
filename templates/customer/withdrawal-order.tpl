{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
{extends file='page.tpl'}

{block name='container_class'}container container--limited-md{/block}

{block name='page_title'}
  {l s='Withdraw from a contract' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  <p>{l s='You can withdraw from an order within the withdrawal period, without giving any reason.' d='Shop.Theme.Customeraccount'}</p>

  {if $withdrawal_orders}
    <section class="withdrawal-orders mb-4" id="withdrawal-orders">
      <h2 class="h4">{l s='Your orders' d='Shop.Theme.Customeraccount'}</h2>

      <div class="table-responsive">
        <table class="table">
          <thead>
            <tr>
              <th scope="col">{l s='Order reference' d='Shop.Theme.Checkout'}</th>
              <th scope="col">{l s='Date' d='Shop.Theme.Checkout'}</th>
              <th scope="col">{l s='Withdrawal' d='Shop.Theme.Customeraccount'}</th>
              <th scope="col"><span class="visually-hidden">{l s='Actions' d='Shop.Theme.Actions'}</span></th>
            </tr>
          </thead>
          <tbody>
            {foreach from=$withdrawal_orders item=withdrawal_order}
              <tr>
                <th scope="row">{$withdrawal_order.reference}</th>
                <td>{$withdrawal_order.date}</td>
                <td>{$withdrawal_order.status}</td>
                <td class="text-end">
                  {if $withdrawal_order.is_eligible}
                    <a class="btn btn-sm btn-outline-primary" href="{$withdrawal_order.url}">
                      {l s='Withdraw from contract here' d='Shop.Theme.Customeraccount'}
                    </a>
                  {/if}
                </td>
              </tr>
            {/foreach}
          </tbody>
        </table>
      </div>
    </section>
  {/if}

  <form id="withdrawal-lookup-form" action="{$urls.pages.withdrawal}" method="post">
    <p>
      {if $customer.is_logged}
        {l s='Order not listed, or placed as a guest? Enter its reference and the email used to place it:' d='Shop.Theme.Customeraccount'}
      {else}
        {l s='Enter the reference of the order you want to withdraw from, and the email used to place it:' d='Shop.Theme.Customeraccount'}
      {/if}
    </p>

    <div class="mb-3">
      <label class="form-label required" for="withdrawal-order-reference">{l s='Order Reference' d='Shop.Forms.Labels'}</label>
      <input id="withdrawal-order-reference" class="form-control" name="order_reference" type="text" required value="{if isset($smarty.request.order_reference)}{$smarty.request.order_reference}{/if}">
      <div class="form-text">{l s='For example: QIIXJXNUI or QIIXJXNUI#1' d='Shop.Theme.Customeraccount'}</div>
    </div>

    <div class="mb-3">
      <label class="form-label required" for="withdrawal-lookup-email">{l s='Email' d='Shop.Forms.Labels'}</label>
      <input id="withdrawal-lookup-email" class="form-control" name="email" type="email" required value="{if isset($smarty.request.email)}{$smarty.request.email}{/if}">
    </div>

    <footer class="buttons-wrapper buttons-wrapper--end">
      <button class="btn btn-primary" type="submit">
        {l s='Withdraw from contract here' d='Shop.Theme.Customeraccount'}
      </button>
    </footer>
  </form>
{/block}
