{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<hr>

<section id="order-summary-content" class="final-summary">
  <p class="h2">{l s='Please check your order before payment' d='Shop.Theme.Checkout'}</p>

  <p class="final-summary__header">
    {l s='Addresses' d='Shop.Theme.Checkout'}

    <button class="btn btn-outline-primary btn-sm js-edit-addresses" data-step="checkout-addresses-step" aria-label="{l s='Edit addresses' d='Shop.Theme.Actions'}">
      <i class="material-icons" aria-hidden="true">&#xE254;</i> {l s='Edit' d='Shop.Theme.Actions'}
    </button>
  </p>

  <div class="address__list">
    <div class="address-card">
      <div class="address-card__container">
        <div class="address-card__header">
          <span class="address-card__alias">
            {l s='Your Delivery Address' d='Shop.Theme.Checkout'}
          </span>
        </div>

        <address class="address-card__content">
          {$customer.addresses[$cart.id_address_delivery]['formatted'] nofilter}
        </address>

        <div class="address-card__actions">
          <a
            class="address-card__edit"
            data-link-action="edit-address"
            href="{url entity='order' params=['id_address' => $customer.addresses[$cart.id_address_delivery]['id'], 'editAddress' => 'editAddress', 'token' => $token]}"
            aria-label="{l s='Edit your delivery address' d='Shop.Theme.Actions'}"
          >
            {l s='Edit' d='Shop.Theme.Actions'}
          </a>

          <a
            class="address-card__delete link-danger"
            data-link-action="delete-address"
            href="{url entity='order' params=['id_address' => $customer.addresses[$cart.id_address_delivery]['id'], 'deleteAddress' => 'deleteAddress', 'token' => $token]}"
            aria-label="{l s='Delete your delivery address' d='Shop.Theme.Actions'}"
          >
            {l s='Delete' d='Shop.Theme.Actions'}
          </a>
        </div>
      </div>
    </div>

    <div class="address-card">
      <div class="address-card__container">
        <div class="address-card__header">
          <span class="address-card__alias">
            {l s='Your Invoice Address' d='Shop.Theme.Checkout'}
          </span>
        </div>

        <address class="address-card__content">
          {$customer.addresses[$cart.id_address_invoice]['formatted'] nofilter}
        </address>

        <div class="address-card__actions">
          <a
            class="address-card__edit"
            data-link-action="edit-address"
            href="{url entity='order' params=['id_address' => $customer.addresses[$cart.id_address_invoice]['id'], 'editAddress' => 'editAddress', 'token' => $token]}"
            aria-label="{l s='Edit your invoice address' d='Shop.Theme.Actions'}"
          >
            {l s='Edit' d='Shop.Theme.Actions'}
          </a>

          <a
            class="address-card__delete link-danger"
            data-link-action="delete-address"
            href="{url entity='order' params=['id_address' => $customer.addresses[$cart.id_address_invoice]['id'], 'deleteAddress' => 'deleteAddress', 'token' => $token]}"
            aria-label="{l s='Delete your invoice address' d='Shop.Theme.Actions'}"
          >
            {l s='Delete' d='Shop.Theme.Actions'}
          </a>
        </div>
      </div>
    </div>
  </div>

  {if !$cart.is_virtual && !($is_multishipment_enabled|default:false)}
    <p class="final-summary__header">
      {l s='Shipping Method' d='Shop.Theme.Checkout'}

      <button class="btn btn-outline-primary btn-sm js-edit-shipping" data-step="checkout-delivery-step" aria-label="{l s='Edit your shipping method' d='Shop.Theme.Actions'}">
        <i class="material-icons" aria-hidden="true">&#xE254;</i> {l s='Edit' d='Shop.Theme.Actions'}
      </button>
    </p>

    <div class="grid-table" role="table" aria-label="{l s='Shipping Method' d='Shop.Theme.Checkout'}">
      <div class="grid-table__inner grid-table__inner--3" role="rowgroup">
        <div class="grid-table__header" role="row">
          <span class="grid-table__cell" role="columnheader">{l s='Delivery Option' d='Shop.Theme.Checkout'}</span>
          <span class="grid-table__cell" role="columnheader">{l s='Price' d='Shop.Theme.Checkout'}</span>
          <span class="grid-table__cell" role="columnheader">{l s='Delivery Information' d='Shop.Theme.Checkout'}</span>
        </div>

        <div class="grid-table__row" role="row">
          <span class="grid-table__cell" role="cell" data-ps-label="{l s='Delivery Option' d='Shop.Theme.Checkout'}">
            <span class="grid-table__cell-group grid-table__cell-group--sm grid-table__cell-group--inline">
              {if $selected_delivery_option.logo}
                <img src="{$selected_delivery_option.logo}" class="rounded img-fluid" width="32" height="auto" alt="{$selected_delivery_option.name}" loading="lazy">
              {/if}

              {$selected_delivery_option.name}
            </span>
          </span>

          <span class="grid-table__cell" role="cell" data-ps-label="{l s='Price' d='Shop.Theme.Checkout'}">
            {$selected_delivery_option.price}
          </span>

          <span class="grid-table__cell" role="cell" data-ps-label="{l s='Delivery Information' d='Shop.Theme.Checkout'}">
            {$selected_delivery_option.delay}
          </span>
        </div>
      </div>
    </div>
  {/if}

  {block name='order_confirmation_table'}
    <p class="final-summary__header">
      {l s='%product_count% order items' sprintf=['%product_count%' => $cart.products_count] d='Shop.Theme.Checkout'}

      <a class="btn btn-outline-primary btn-sm" href="{url entity=cart params=['action' => 'show']}" aria-label="{l s='Edit your cart' d='Shop.Theme.Actions'}">
        <i class="material-icons" aria-hidden="true">&#xE254;</i> {l s='Edit' d='Shop.Theme.Actions'}
      </a>
    </p>

    <div class="final-summary__order-table card border-1 mb-4">
      <div class="card-body">
        {if isset($is_multishipment_enabled) && $is_multishipment_enabled}
          {include file='checkout/_partials/order-final-summary-table-multishipment.tpl'
            products=$products_carrier_mapping
            products_count=$cart.products_count
            subtotals=$cart.subtotals
            totals=$cart.totals
            labels=$cart.labels
            add_product_link=true
          }
        {else}
          {include file='checkout/_partials/order-final-summary-table.tpl'
            products=$cart.products
            products_count=$cart.products_count
            subtotals=$cart.subtotals
            totals=$cart.totals
            labels=$cart.labels
            add_product_link=true
          }
        {/if}
      </div>
    </div>
  {/block}
</section>
