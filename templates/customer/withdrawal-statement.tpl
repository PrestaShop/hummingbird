{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
{extends file='page.tpl'}

{block name='container_class'}container container--limited-md{/block}

{block name='page_title'}
  {l s='Withdrawal statement' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  <section class="withdrawal-contract mb-4" id="withdrawal-contract">
    <h2 class="h4">{l s='Contract you withdraw from' d='Shop.Theme.Customeraccount'}</h2>
    <p>
      {l
        s='Order Reference: %reference% - placed on %date%'
        d='Shop.Theme.Customeraccount'
        sprintf=['%reference%' => $order.details.reference, '%date%' => $order.details.order_date]
      }
    </p>
    <ul>
      {foreach from=$order.products item=product}
        <li>{$product.quantity} x {$product.name}</li>
      {/foreach}
    </ul>
    {if $withdrawal.deadline}
      <p>{l s='Withdrawal period: until %date%.' d='Shop.Theme.Customeraccount' sprintf=['%date%' => $withdrawal.deadline]}</p>
    {/if}
  </section>

  {if $withdrawal.is_eligible}
    <form id="withdrawal-statement-form" action="{$urls.pages.withdrawal}" method="post">
      <input type="hidden" name="token" value="{$static_token}">
      {if $withdrawal.is_guest_lookup}
        <input type="hidden" name="order_reference" value="{$withdrawal.order_reference}">
        <input type="hidden" name="email" value="{$withdrawal.lookup_email}">
      {else}
        <input type="hidden" name="id_order" value="{$order.details.id}">
      {/if}

      <p>{l s='I hereby give notice that I withdraw from my contract of sale of the goods listed above.' d='Shop.Theme.Customeraccount'}</p>

      <div class="mb-3">
        <label class="form-label required" for="withdrawal-firstname">{l s='First name' d='Shop.Forms.Labels'}</label>
        <input id="withdrawal-firstname" class="form-control" name="firstname" type="text" required maxlength="255" value="{$withdrawal.statement.firstname}">
      </div>

      <div class="mb-3">
        <label class="form-label required" for="withdrawal-lastname">{l s='Last name' d='Shop.Forms.Labels'}</label>
        <input id="withdrawal-lastname" class="form-control" name="lastname" type="text" required maxlength="255" value="{$withdrawal.statement.lastname}">
      </div>

      <div class="mb-3">
        <label class="form-label required" for="withdrawal-email">{l s='Email' d='Shop.Forms.Labels'}</label>
        <input id="withdrawal-email" class="form-control" name="withdrawal_email" type="email" required value="{$withdrawal.statement.email}" aria-describedby="withdrawal-email-help">
        <div class="form-text" id="withdrawal-email-help">{l s='The acknowledgement of receipt of your withdrawal will be sent to this email.' d='Shop.Theme.Customeraccount'}</div>
      </div>

      <div class="mb-3">
        <label class="form-label" for="withdrawal-message">{l s='Message' d='Shop.Forms.Labels'}</label>
        <textarea id="withdrawal-message" class="form-control" name="message" rows="3" maxlength="{$withdrawal.message_max_length}" aria-describedby="withdrawal-message-help">{$withdrawal.statement.message}</textarea>
        <div class="form-text" id="withdrawal-message-help">{l s='Optional. You do not have to give a reason.' d='Shop.Theme.Customeraccount'}</div>
      </div>

      <footer class="buttons-wrapper buttons-wrapper--end">
        <button class="btn btn-primary" type="submit" name="submitWithdrawal" value="1">
          {l s='Confirm withdrawal' d='Shop.Theme.Customeraccount'}
        </button>
      </footer>
    </form>
  {/if}
{/block}
