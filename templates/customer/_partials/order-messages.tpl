{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{block name='order_messages_table'}
  {if $order.messages}
    <section class="order-messages">
      <h3 class="h3">{l s='Messages' d='Shop.Theme.Customeraccount'}</h3>

      <div class="order-message__list">
      {foreach from=$order.messages item=message}
        <div class="order-message">
          <div class="order-message__infos">
            <p class="order-message__name">{$message.name}</p>
            <p class="order-message__date">{$message.message_date}</p>
          </div>

          <div class="order-message__content">
            {$message.message nofilter}
          </div>
        </div>
      {/foreach}
    </section>

    <hr class="order-separator">
  {/if}
{/block}

{block name='order_message_form'}
  <section class="order-message-form">
    <form action="{$urls.pages.order_detail}" method="post">
      <h3 class="h3">{l s='Add a message' d='Shop.Theme.Customeraccount'}</h3>

      <p>
        {l s='If you would like to add a comment about your order, please write it in the field below.' d='Shop.Theme.Customeraccount'}
      </p>

      <div class="mb-3">
        <label class="form-label">{l s='Product' d='Shop.Forms.Labels'}</label>

        <select name="id_product" class="form-select">
          <option value="0">{l s='-- please choose --' d='Shop.Forms.Labels'}</option>
          {foreach from=$order.products item=product}
            <option value="{$product.id_product}">{$product.name}</option>
          {/foreach}
        </select>
      </div>

      <div class="mb-3">
        <label class="form-label">{l s='Message' d='Shop.Forms.Labels'}</label>
        <textarea rows="3" name="msgText" class="form-control"></textarea>
      </div>

      <div class="buttons-wrapper buttons-wrapper--end mt-3">
        <input type="hidden" name="id_order" value="{$order.details.id}">
        <button type="submit" name="submitMessage" class="btn btn-primary">
          {l s='Send' d='Shop.Theme.Actions'}
        </button>
      </footer>
    </form>
  </section>
{/block}
