{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file='customer/page.tpl'}

{block name='page_title'}
  {l s='Order details' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  {block name='order_infos'}
    <section class="order-infos">
      <div class="order-infos__summary">
        <p class="order-infos__reference">
          {l
            s='Order Reference: %reference% - placed on %date%'
            d='Shop.Theme.Customeraccount'
            sprintf=['%reference%' => $order.details.reference, '%date%' => $order.details.order_date]
          }
        </p>

        <p class="order-infos__carrier">
          {l s='Carrier: %carrierName%' d='Shop.Theme.Checkout' sprintf=['%carrierName%' => $order.carrier.name]}
        </p>

        <p class="order-infos__payment">
          {l s='Payment method: %paymentMethod%' d='Shop.Theme.Checkout' sprintf=['%paymentMethod%' => $order.details.payment]}
        </p>

        {if $order.details.recyclable}
          <p class="order-infos__recyclable">
            {l s='You have given permission to receive your order in recycled packaging.' d='Shop.Theme.Customeraccount'}
          </p>
        {/if}

        {if $order.details.gift_message}
          <div class="order-infos__gift-message">
            <p>{l s='You have requested gift wrapping for this order.' d='Shop.Theme.Customeraccount'}</p>
            <p>{l s='Message:' d='Shop.Theme.Customeraccount'} {$order.details.gift_message nofilter}</p>
          </div>
        {/if}

        {if $order.details.invoice_url || $order.details.reorder_url}
          <div class="order-infos__actions buttons-wrapper {if !$order.details.invoice_url && $order.details.reorder_url}buttons-wrapper--end{else}buttons-wrapper--split{/if}">
            {if $order.details.invoice_url}
              <a class="btn btn-link px-0" href="{$order.details.invoice_url}">
                <i class="material-icons">&#xE415;</i>
                {l s='Download your invoice as a PDF file.' d='Shop.Theme.Customeraccount'}
              </a>
            {/if}

            {if $order.details.reorder_url}
              <a href="{$order.details.reorder_url}" class="btn btn-outline-primary">
                {l s='Reorder' d='Shop.Theme.Actions'}
              </a>
            {/if}
          </div>
        {/if}
      </div>
    </section>
  {/block}

  <hr class="order-separator">

  {block name='order_status'}
    <section class="order-status">
      <h2 class="h3">{l s='Follow your order\'s status step-by-step' d='Shop.Theme.Customeraccount'}</h2>

      <div class="order-status__table grid-table grid-table--collapse" data-role="table">
        <div class="grid-table__inner grid-table__inner--2">
          <header class="grid-table__header">
            <div class="grid-table__cell">{l s='Date' d='Shop.Theme.Global'}</div>
            <div class="grid-table__cell">{l s='Status' d='Shop.Theme.Global'}</div>
          </header>

          {foreach from=$order.history item=state}
            <div class="grid-table__row">
              <div class="grid-table__cell" aria-label="{l s='Date' d='Shop.Theme.Global'}">
                {$state.history_date}
              </div>
              <div class="grid-table__cell" aria-label="{l s='Status' d='Shop.Theme.Global'}">
                <span class="order-status__badge order-status__badge--{$state.contrast} badge" style="background-color:{$state.color}">
                  {$state.ostate_name}
                </span>
              </div>
            </div>
          {/foreach}
        </div>
      </div>
    </section>
  {/block}

  <hr class="order-separator">

  {block name='order_carriers'}
    {if $order.shipping}
      <section class="order-carriers">
        <h3 class="h3">{l s='Tracking' d='Shop.Theme.Customeraccount'}</h3>

        <div class="grid-table" data-role="table">
          <div class="grid-table__inner grid-table__inner--5">
            <div class="grid-table__header">
              <div class="grid-table__cell">{l s='Date' d='Shop.Theme.Global'}</div>
              <div class="grid-table__cell">{l s='Carrier' d='Shop.Theme.Checkout'}</div>
              <div class="grid-table__cell">{l s='Weight' d='Shop.Theme.Checkout'}</div>
              <div class="grid-table__cell">{l s='Shipping cost' d='Shop.Theme.Checkout'}</div>
              <div class="grid-table__cell">{l s='Tracking number' d='Shop.Theme.Checkout'}</div>
            </div>

            {foreach from=$order.shipping item=line}
              <div class="grid-table__row">
                <div class="grid-table__cell" aria-label="{l s='Date' d='Shop.Theme.Global'}">
                  {$line.shipping_date}
                </div>
                <div class="grid-table__cell" aria-label="{l s='Carrier' d='Shop.Theme.Checkout'}">
                  {$line.carrier_name}
                </div>
                <div class="grid-table__cell" aria-label="{l s='Weight' d='Shop.Theme.Checkout'}">
                  {$line.shipping_weight}
                </div>
                <div class="grid-table__cell" aria-label="{l s='Shipping cost' d='Shop.Theme.Checkout'}">
                  {$line.shipping_cost}
                </div>
                <div class="grid-table__cell" aria-label="{l s='Tracking number' d='Shop.Theme.Checkout'}">
                  {$line.tracking nofilter}
                </div>
              </div>
            {/foreach}
          </div>
        </div>
      </section>
    {/if}
  {/block}

  <hr class="order-separator">

  {block name='order_addresses'}
    <section class="order-addresses">
      <h3 class="h3">{l s='Addresses' d='Shop.Theme.Customeraccount'}</h3>

      <div class="order-addresses__list">
        {if $order.addresses.delivery}
          <article id="delivery-address" class="address-card">
            <div class="address-card__container">
              <h4 class="address-card__alias">
                {l s='Delivery address: %alias%' d='Shop.Theme.Checkout' sprintf=['%alias%' => $order.addresses.delivery.alias]}
              </h4>

              <address class="address-card__content mb-0">{$order.addresses.delivery.formatted nofilter}</address>
            </div>
          </article>
        {/if}

        <article id="invoice-address" class="address-card">
          <div class="address-card__container">
            <h4 class="address-card__alias">
              {l s='Invoice address: %alias%' d='Shop.Theme.Checkout' sprintf=['%alias%' => $order.addresses.invoice.alias]}
            </h4>

            <address class="address-card__content mb-0">{$order.addresses.invoice.formatted nofilter}</address>
          </div>
        </article>
      </div>
    </section>
  {/block}

  <hr class="order-separator">
  
  {capture name='displayOrderDetail'}{hook h='displayOrderDetail'}{/capture}
  {if $smarty.capture.displayOrderDetail}
    {$smarty.capture.displayOrderDetail nofilter}

    <hr class="order-separator">
  {/if}

  {block name='order_products'}
    <section class="order-products">
      <h3 class="h3">{l s='Products' d='Shop.Theme.Customeraccount'}</h3>

      {block name='order_detail'}
        {if $order.details.is_returnable}
          {include file='customer/_partials/order-detail-return.tpl'}
        {else}
          {include file='customer/_partials/order-detail-no-return.tpl'}
        {/if}
      {/block}
    </section>
  {/block}

  <hr class="order-separator">

  {block name='order_messages'}
    {include file='customer/_partials/order-messages.tpl'}
  {/block}
{/block}
