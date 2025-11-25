<section class="order-carriers">
  <h3 class="h3" id="order_carriers_heading">{l s='Shipment tracking details' d='Shop.Theme.Customeraccount'}</h3>

  <div class="grid-table" role="table" aria-label="{l s='Order tracking' d='Shop.Theme.Customeraccount'}" aria-describedby="order_carriers_heading">
    <div class="grid-table__inner grid-table__inner--5" role="rowgroup">
      <div class="grid-table__header" role="row">
        <span class="grid-table__cell" role="columnheader">{l s='Date' d='Shop.Theme.Global'}</span>
        <span class="grid-table__cell" role="columnheader">{l s='Carrier' d='Shop.Theme.Checkout'}</span>
        <span class="grid-table__cell" role="columnheader">{l s='Weight' d='Shop.Theme.Checkout'}</span>
        <span class="grid-table__cell" role="columnheader">{l s='Shipping cost' d='Shop.Theme.Checkout'}</span>
        <span class="grid-table__cell" role="columnheader">{l s='Tracking number' d='Shop.Theme.Checkout'}</span>
      </div>

      {foreach from=$order.shipping item=line}
        <div class="grid-table__row" role="row">
          <span class="grid-table__cell" role="cell" data-ps-label="{l s='Date' d='Shop.Theme.Global'}">
            {$line.shipping_date}
          </span>
          <span class="grid-table__cell" role="cell" data-ps-label="{l s='Carrier' d='Shop.Theme.Checkout'}">
            {$line.carrier_name}
          </span>
          <span class="grid-table__cell" role="cell" data-ps-label="{l s='Weight' d='Shop.Theme.Checkout'}">
            {$line.shipping_weight}
          </span>
          <span class="grid-table__cell" role="cell" data-ps-label="{l s='Shipping cost' d='Shop.Theme.Checkout'}">
            {$line.shipping_cost}
          </span>
          <span class="grid-table__cell" role="cell" data-ps-label="{l s='Tracking number' d='Shop.Theme.Checkout'}">
            {$line.tracking nofilter}
          </span>
        </div>
      {/foreach}
    </div>
  </div>
</section>
