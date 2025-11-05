{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{block name='order_products_table'}
  <div class="grid-table grid-table--collapse mb-0" role="table" aria-label="{l s='Products details' d='Shop.Theme.Customeraccount'}" aria-describedby="order_products_heading">
    <div class="grid-table__inner grid-table__inner--4" role="rowgroup">
      <header class="grid-table__header" role="row">
        <span class="grid-table__cell" role="columnheader">{l s='Product' d='Shop.Theme.Catalog'}</span>
        <span class="grid-table__cell grid-table__cell--center" role="columnheader">{l s='Quantity' d='Shop.Theme.Catalog'}</span>
        <span class="grid-table__cell grid-table__cell--center" role="columnheader">{l s='Unit price' d='Shop.Theme.Catalog'}</span>
        <span class="grid-table__cell grid-table__cell--right" role="columnheader">{l s='Total price' d='Shop.Theme.Catalog'}</span>
      </header>

      {foreach $order->order_shipments['virtual_products'] item=product}
        {include file='./order-detail-product-line-no-return.tpl' product=$product}
      {/foreach}
      {foreach $order->order_shipments['physical_products'] item=shipment}
        {foreach from=$shipment['products'] item=product}
          {include file='./order-detail-product-line-no-return.tpl' product=$product carrier_name=$shipment['carrier']['name']}
        {/foreach}
      {/foreach}
    </div>
  </div>

  <div class="grid-table grid-table--collapse" role="table" aria-label="{l s='Order totals' d='Shop.Theme.Customeraccount'}">
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
{/block}
