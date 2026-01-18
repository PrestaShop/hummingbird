{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{if !$configuration.is_catalog}
  <div class="product__add-to-cart-container product-add-to-cart js-product-add-to-cart">
    {block name='product_availability'}
      {if $product.show_availability && $product.availability_message}
        <div
          id="product-availability"
          class="product__availability js-product-availability"
        >
          {** First, we prepare the icons and colors we want to use *}
          {if $product.availability == 'in_stock'}
            {assign 'availability_icon' 'E5CA'}
            {assign 'availability_class' 'text-success'}
          {elseif $product.availability == 'available'}
            {assign 'availability_icon' 'E002'}
            {assign 'availability_class' 'text-warning'}
          {elseif $product.availability == 'last_remaining_items'}
            {assign 'availability_icon' 'E002'}
            {assign 'availability_class' 'text-warning'}
          {else}
            {assign 'availability_icon' 'E14B'}
            {assign 'availability_class' 'text-danger'}
          {/if}

          {** And render the availability message with icon *}
          <div class="product__availability-status {$availability_class}" aria-live="off" data-ps-ref="product-availability">
            <i class="product__availability-icon material-icons rtl-no-flip">&#x{$availability_icon};</i>

            <div class="product__availability-messages">
              <span class="visually-hidden">{l s='Product availability:' d='Shop.Theme.Global'}</span>
              <span>{$product.availability_message}</span>

              {if !empty($product.availability_submessage)}
                <small class="d-block">{$product.availability_submessage}</small>
              {/if}
            </div>
          </div>
        </div>
      {/if}

      {block name='product_delivery_times'}
        {if !$product.is_virtual}
          {if $product.additional_delivery_times == 1 && $product.delivery_information}
            <div class="product__delivery-infos">{$product.delivery_information}</div>
          {elseif $product.additional_delivery_times == 2}
            {if $product.quantity > 0 && $product.delivery_in_stock}
              <div class="product__delivery-infos">{$product.delivery_in_stock}</div>
            {* Out of stock message should not be displayed if customer can't order the product. *}
            {elseif $product.quantity <= 0 && $product.add_to_cart_url && $product.delivery_out_stock}
              <div class="product__delivery-infos">{$product.delivery_out_stock}</div>
            {/if}
          {/if}
        {/if}
      {/block}
    {/block}

    {block name='product_quantity'}
      <div class="product__actions-qty-add">
        <div class="product-actions__quantity product__quantity quantity-button js-quantity-button">
          {include file='components/qty-input.tpl'
            attributes=[
              "id" => "quantity_wanted",
              "class" => "form-control js-quantity-wanted",
              "value" => "{$product.quantity_wanted}",
              "min" => "{$product.quantity_required}"
            ]
          }
        </div>

        <div class="product__add-to-cart add">
          <button
            class="product__add-to-cart-button btn btn-primary"
            data-button-action="add-to-cart"
            type="submit"
            {if !$product.add_to_cart_url}
              aria-disabled="true"
              disabled
            {/if}
            data-ps-ref="add-to-cart"
            aria-label="{l s='Add to cart %product_name%' sprintf=['%product_name%' => $product.name] d='Shop.Theme.Actions'}"
            title="{l s='Add to cart %product_name%' sprintf=['%product_name%' => $product.name] d='Shop.Theme.Actions'}"
          >
            <i class="material-icons" aria-hidden="true">&#xE547;</i>
            {l s='Add to cart' d='Shop.Theme.Actions'}
          </button>
        </div>

        {capture name='product_actions'}{hook h='displayProductActions' product=$product}{/capture}
        {if $smarty.capture.product_actions}
          {$smarty.capture.product_actions nofilter}
        {/if}
      </div>
    {/block}

    {block name='product_minimal_quantity'}
      <div
        class="product__minimal-quantity product-minimal-quantity js-product-minimal-quantity"
        {if $product.minimal_quantity <= 1}
          hidden
        {/if}
      >
        {if $product.minimal_quantity > 1}
          <i class="material-icons" aria-hidden="true">&#xE88F;</i>
          {l
            s='The minimum purchase order quantity for the product is %quantity%.'
            d='Shop.Theme.Checkout'
            sprintf=['%quantity%' => $product.minimal_quantity]
          }
        {/if}
      </div>
    {/block}
  </div>
{/if}
