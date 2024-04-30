{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<hr />

<section id="order-summary-content" class="order__summary">
  <p class="h4 mb-4">{l s='Please check your order before payment' d='Shop.Theme.Checkout'}</p>

  <div class="order__summary__addresses mb-4">
    <p class="h5 mb-3">
      {l s='Addresses' d='Shop.Theme.Checkout'}
      <span class="btn step-edit step-to-addresses fs-6 text-gray js-edit-addresses" data-step="checkout-addresses-step"><i class="material-icons edit fs-6" aria-hidden="true">mode_edit</i> {l s='edit' d='Shop.Theme.Actions'}</span>
    </p>

    <div class="row">
      <div class="col-12 col-sm-6 mb-2">
        <div class="address card">
          <div class="card-body">
            <div class="address__content col-10">
              <p class="address__alias h6 card-title">{l s='Your Delivery Address' d='Shop.Theme.Checkout'}</p>

              <address class="address__content">{$customer.addresses[$cart.id_address_delivery]['formatted'] nofilter}</address>

              <div class="address__actions">
                <a
                  class="address__edit ps-0 pb-0"
                  data-link-action="edit-address"
                  href="{url entity='order' params=['id_address' => $customer.addresses[$cart.id_address_delivery]['id'], 'editAddress' => 'editAddress', 'token' => $token]}"
                >
                  {l s='Edit' d='Shop.Theme.Actions'}
                </a>

                <a
                  class="address__delete pb-0"
                  data-link-action="delete-address"
                  href="{url entity='order' params=['id_address' => $customer.addresses[$cart.id_address_delivery]['id'], 'deleteAddress' => 'deleteAddress', 'token' => $token]}"
                >
                  {l s='Delete' d='Shop.Theme.Actions'}
                </a>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="col-12 col-sm-6 mb-2">
        <div class="address card">
          <div class="card-body">
            <div class="address__content col-10">
              <p class="address__alias h6 card-title">{l s='Your Invoice Address' d='Shop.Theme.Checkout'}</p>

              <address class="address__content">{$customer.addresses[$cart.id_address_invoice]['formatted'] nofilter}</address>

              <div class="address__actions">
                <a
                  class="address__edit ps-0 pb-0"
                  data-link-action="edit-address"
                  href="{url entity='order' params=['id_address' => $customer.addresses[$cart.id_address_invoice]['id'], 'editAddress' => 'editAddress', 'token' => $token]}"
                >
                  {l s='Edit' d='Shop.Theme.Actions'}
                </a>

                <a
                  class="address__delete pb-0"
                  data-link-action="delete-address"
                  href="{url entity='order' params=['id_address' => $customer.addresses[$cart.id_address_invoice]['id'], 'deleteAddress' => 'deleteAddress', 'token' => $token]}"
                >
                  {l s='Delete' d='Shop.Theme.Actions'}
                </a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  {if !$cart.is_virtual}
    <p class="h5 mb-3">
      {l s='Shipping Method' d='Shop.Theme.Checkout'}
      <span class="btn step-edit step-to-addresses fs-6 text-gray js-edit-shipping" data-step="checkout-delivery-step"><i class="material-icons edit fs-6" aria-hidden="true">mode_edit</i> {l s='edit' d='Shop.Theme.Actions'}</span>
    </p>

    <div class="bg-light rounded-3 p-3 mb-4">
      <div class="delivery-options__item js-delivery-option">
        <div class="row">
          <div class="delivery-option__left col-6 col-sm-4 mb-2 mb-sm-0 order-0">
            <div class="carrier col-10{if $selected_delivery_option.logo} carrier--hasLogo{/if}">
              <div class="row align-items-center">
                {if $selected_delivery_option.logo}
                  <div class="col-md-4 carrier__logo">
                      <img src="{$selected_delivery_option.logo}" class="rounded img-fluid" alt="{$selected_delivery_option.name}" loading="lazy" />
                  </div>
                {/if}

                <div class="carriere-name-container{if $selected_delivery_option.logo} col-md-8{else}col{/if}">
                  <span class="h6 carrier-name">{$selected_delivery_option.name}</span>
                </div>
              </div>
            </div>
          </div>

          <span class="delivery-option__center col-6 col-sm-4 order-2 order-sm-1 d-flex align-items-center justify-content-center">
            {$selected_delivery_option.delay}
          </span>

          <span class="delivery-option__right col-6 col-sm-4 order-1 order-sm-2 d-flex align-items-center justify-content-end">
            {$selected_delivery_option.price}
          </span>
        </div>
      </div>
    </div>
  {/if}

  {block name='order_confirmation_table'}
    <p class="h5 mb-3">
      {l s='Order items' d='Shop.Theme.Checkout'}
    </p>

    <div class="order__payment__confirmation mb-4">
      {include file='checkout/_partials/order-final-summary-table.tpl'
          products=$cart.products
          products_count=$cart.products_count
          subtotals=$cart.subtotals
          totals=$cart.totals
          labels=$cart.labels
          add_product_link=true
        }
    </div>
  {/block}
</section>
