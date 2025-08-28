{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{if !$configuration.is_catalog}
  <div class="product__add-to-cart-container product-add-to-cart js-product-add-to-cart">
    {block name='product_availability'}
      <div
        id="product-availability"
        class="product__availability js-product-availability"
        {if !$product.show_availability || !$product.availability_message}hidden{/if}
      >
        {if $product.show_availability && $product.availability_message}
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
          <div class="product__availability-status {$availability_class}" role="alert" aria-live="polite">
            <i class="product__availability-icon material-icons rtl-no-flip">&#x{$availability_icon};</i>

            <div class="product__availability-messages">
              <span>{$product.availability_message}</span>

              {if !empty($product.availability_submessage)}
                <br>
                <small>{$product.availability_submessage}</small>
              {/if}
            </div>
          </div>

          {block name='product_delivery_times'}
            {if !$product.is_virtual}
              {if $product.additional_delivery_times == 1}
                {if $product.delivery_information}
                  <div class="product__delivery-infos">{$product.delivery_information}</div>
                {/if}
              {elseif $product.additional_delivery_times == 2}
                {if $product.quantity > 0}
                  <div class="product__delivery-infos">{$product.delivery_in_stock}</div>
                {* Out of stock message should not be displayed if customer can't order the product. *}
                {elseif $product.quantity <= 0 && $product.add_to_cart_url}
                  <div class="product__delivery-infos">{$product.delivery_out_stock}</div>
                {/if}
              {/if}
            {/if}
          {/block}
        {/if}
      </div>
    {/block}

    {block name='product_quantity'}
      <div class="product__actions-qty-add">
        <div class="product-actions__quantity product__quantity quantity-button js-quantity-button">
          {include file='components/qty-input.tpl'
            attributes=[
              "id" => "quantity_wanted",
              "class" => "form-control js-quantity-wanted",
              "value" => "{$product.minimal_quantity}",
              "min" => "{$product.minimal_quantity}"
            ]
          }
        </div>

        <div class="product__add-to-cart add">
          <button
            class="product__add-to-cart-button btn btn-primary"
            data-button-action="add-to-cart"
            type="submit"
            {if !$product.add_to_cart_url}
              disabled
            {/if}
            data-ps-ref="add-to-cart"
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
