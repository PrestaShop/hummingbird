{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
{if isset($withdrawal_button) && $withdrawal_button.is_eligible}
  <section class="order-withdrawal" id="order-withdrawal">
    <form action="{$urls.pages.withdrawal}" method="post">
      {if $withdrawal_button.id_order}
        <input type="hidden" name="id_order" value="{$withdrawal_button.id_order}">
      {else}
        <input type="hidden" name="order_reference" value="{$withdrawal_button.order_reference}">
        <input type="hidden" name="email" value="{$withdrawal_button.email}">
      {/if}

      <p class="mb-2">
        {if $withdrawal_button.deadline}
          {l s='You can withdraw from this order until %date%.' d='Shop.Theme.Customeraccount' sprintf=['%date%' => $withdrawal_button.deadline]}
        {else}
          {l s='You can withdraw from this order.' d='Shop.Theme.Customeraccount'}
        {/if}
      </p>

      <button type="submit" class="btn btn-outline-primary" id="withdrawal-button">
        {l s='Withdraw from contract here' d='Shop.Theme.Customeraccount'}
      </button>
    </form>
  </section>

  <hr class="order-separator">
{/if}
