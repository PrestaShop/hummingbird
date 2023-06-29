{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{block name='order_messages_table'}
  {if $order.messages}
    <div class="customer__messages mb-3">
      <h3 class="h3">{l s='Messages' d='Shop.Theme.Customeraccount'}</h3>
      {foreach from=$order.messages item=message}
        <div class="customer__message border rounded p-3 my-2">
          <div class="customer__message__content row">
            <div class="col-sm-4 mb-2 mb-sm-0">
              <p class="fw-bold mb-0">{$message.name}</p>
              <p class="fs-6 mb-0">{$message.message_date}</p>
            </div>
            <div class="col-sm-8">{$message.message nofilter}</div>
          </div> 
        </div>
      {/foreach}
    </div>
  {/if}
{/block}

{block name='order_message_form'}
  <section class="order-message-form box">
    <form action="{$urls.pages.order_detail}" method="post">
      <header>
        <h3 class="h3">{l s='Add a message' d='Shop.Theme.Customeraccount'}</h3>
        <p>
          {l s='If you would like to add a comment about your order, please write it in the field below.' d='Shop.Theme.Customeraccount'}
        </p>
      </header>

      <section class="form-fields">
        <label class="col-md-3 form-label">{l s='Product' d='Shop.Forms.Labels'}</label>
        <select name="id_product" class="form-select my-2">
          <option value="0">{l s='-- please choose --' d='Shop.Forms.Labels'}</option>
          {foreach from=$order.products item=product}
            <option value="{$product.id_product}">{$product.name}</option>
          {/foreach}
        </select>
        <textarea rows="3" name="msgText" class="form-control"></textarea>
      </section>

      <footer class="form-footer text-end">
        <input type="hidden" name="id_order" value="{$order.details.id}">
        <button type="submit" name="submitMessage" class="btn btn-primary mt-4 form-control-submit">
          {l s='Send' d='Shop.Theme.Actions'}
        </button>
      </footer>
    </form>
  </section>
{/block}
