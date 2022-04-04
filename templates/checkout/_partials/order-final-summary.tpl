{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 *}

<hr />
<section id="order-summary-content" class="order__summary">
  <h4 class="mb-4">{l s='Please check your order before payment' d='Shop.Theme.Checkout'}</h4>

  <div class="order__summary__addresses mb-4">
    <h5 class="mb-3">
      {l s='Addresses' d='Shop.Theme.Checkout'}
    </h5>

    <div class="row">
      <div class="col-12 col-sm-6 mb-2">
        <div class="address card">
          <div class="card-body">
            <div class="address__content col-10">
              <h6 class="address__alias card-title">{l s='Your Delivery Address' d='Shop.Theme.Checkout'}</h6>
              <address class="address__content">{$customer.addresses[$cart.id_address_delivery]['formatted'] nofilter}</address>

              <div class="address__actions">
                <a
                  class="address__edit text-muted ps-0 pb-0"
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
              <h6 class="address__alias card-title">{l s='Your Invoice Address' d='Shop.Theme.Checkout'}</h6>
              <address class="address__content">{$customer.addresses[$cart.id_address_delivery]['formatted'] nofilter}</address>

              <div class="address__actions">
                <a
                  class="address__edit text-muted ps-0 pb-0"
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
    <h5 class="mb-3">
      {l s='Shipping Method' d='Shop.Theme.Checkout'}
    </h5>

    <div class="bg-light rounded-3 p-3 mb-4">
      <div class="delivery-options__item js-delivery-option">
        <div class="row">
          <div class="delivery-option__left col-6 col-sm-4 mb-2 mb-sm-0 order-0">
            <div class="carrier col-10{if $selected_delivery_option.logo} carrier--hasLogo{/if}">
              <div class="row align-items-center">
                {if $selected_delivery_option.logo}
                  <div class="col-md-4 carrier__logo">
                      <img src="{$selected_delivery_option.logo}" class="rounded" alt="{$selected_delivery_option.name}" loading="lazy" />
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
    <h5 class="mb-3">
      {l s='Order items' d='Shop.Theme.Checkout'}
    </h5>

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
