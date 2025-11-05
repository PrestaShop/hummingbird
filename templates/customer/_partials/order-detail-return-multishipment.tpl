{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{block name='order_products_table'}
  <form id="order-return-form" class="js-order-return-form" action="{$urls.pages.order_follow}" method="post" data-ps-action="form-validation">
    <div class="grid-table grid-table--collapse mb-0" role="table" data-ps-ref="order-return-products-table" aria-label="{l s='Products details' d='Shop.Theme.Catalog'}" aria-describedby="order_products_heading">
      <div class="grid-table__inner grid-table__inner--6" role="rowgroup">
        <div class="grid-table__header" role="row">
          <span class="grid-table__cell" role="columnheader" aria-label="{l s='Select product to return' d='Shop.Theme.Catalog'}">
            <input class="form-check-input" type="checkbox" data-ps-ref="select-all-products" aria-label="{l s='Select all products' d='Shop.Theme.Catalog'}">
          </span>
          <span class="grid-table__cell" role="columnheader">{l s='Product' d='Shop.Theme.Catalog'}</span>
          <span class="grid-table__cell grid-table__cell--center" role="columnheader">{l s='Quantity' d='Shop.Theme.Catalog'}</span>
          <span class="grid-table__cell grid-table__cell--center" role="columnheader">{l s='Returned' d='Shop.Theme.Catalog'}</span>
          <span class="grid-table__cell grid-table__cell--center" role="columnheader">{l s='Unit price' d='Shop.Theme.Catalog'}</span>
          <span class="grid-table__cell grid-table__cell--right" role="columnheader">{l s='Total price' d='Shop.Theme.Catalog'}</span>
        </div>

        {foreach $order->order_shipments['virtual_products'] item=product}
          {include file='./order-detail-product-line-return.tpl' product=$product}
        {/foreach}
        {foreach $order->order_shipments['physical_products'] item=shipment}
          {foreach from=$shipment['products'] item=product}
            {include file='./order-detail-product-line-return.tpl' product=$product carrier_name=$shipment['carrier']['name']}
          {/foreach}
        {/foreach}
      </div>
    </div>

    <div class="grid-table grid-table--collapse" role="table" aria-label="{l s='Order totals' d='Shop.Theme.Catalog'}">
      <div class="grid-table__inner grid-table__inner--6" role="rowgroup">
        {foreach $order.subtotals as $line}
          {if $line.value}
            <div class="grid-table__row" role="row">
              <span class="grid-table__cell grid-table__cell--label-value" role="cell" data-ps-label="{$line.label}">
                <span class="visually-hidden">{l s='%label%' d='Shop.Theme.Catalog' sprintf=['%label%' => $line.label]}</span>
                {$line.value}
              </span>
            </div>
          {/if}
        {/foreach}

        <div class="grid-table__row" role="row">
          <span class="grid-table__cell grid-table__cell--label-value" role="cell" data-ps-label="{$order.totals.total.label}">
            <span class="visually-hidden">{l s='Total price' d='Shop.Theme.Catalog'}</span>
            {$order.totals.total.value}
          </span>
        </div>
      </div>
    </div>

    <hr class="order-separator">

    <section class="order-merchandise-return">
      <h3 class="h3">{l s='Merchandise return' d='Shop.Theme.Customeraccount'}</h3>

      <label class="form-label required" for="return_notes">{l s='Return notes' d='Shop.Forms.Labels'}</label>

      <textarea
        rows="3"
        name="returnText"
        id="return_notes"
        class="form-control required"
        aria-describedby="order_merchandise_return"
        required
      ></textarea>

      <p class="form-text" id="order_merchandise_return">
        {l s='If you wish to return one or more products, please mark the corresponding boxes and provide an explanation for the return. When complete, click the button below.' d='Shop.Theme.Customeraccount'}
      </p>

      <div class="buttons-wrapper buttons-wrapper--end mt-3">
        <input type="hidden" name="id_order" value="{$order.details.id}">
        <button class="btn btn-primary" type="submit" name="submitReturnMerchandise" data-ps-action="form-validation-submit">
          {l s='Request a return' d='Shop.Theme.Customeraccount'}
        </button>
      </footer>
    </div>
  </form>
{/block}
