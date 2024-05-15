{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<div class="product__add-to-cart product-add-to-cart js-product-add-to-cart">
  {if !$configuration.is_catalog}
    <div class="mb-3">
      {block name='product_availability'}
        <span id="product-availability" class="product__availability js-product-availability d-flex align-items-center">
          {if $product.show_availability && $product.availability_message}
            {if $product.availability == 'available'}
              <i class="material-icons rtl-no-flip product-available">&#xE5CA;</i>
            {elseif $product.availability == 'last_remaining_items'}
              <i class="material-icons product-last-items me-2">&#xE002;</i>
            {else}
              <i class="material-icons product-unavailable me-2">&#xE14B;</i>
            {/if}

            {$product.availability_message}
          {/if}
        </span>
      {/block}

      {block name='product_delivery_times'}
        {if $product.is_virtual	== 0}
          {if $product.additional_delivery_times == 1}
            {if $product.delivery_information}
              <span class="product__delivery__information">{$product.delivery_information}</span>
            {/if}
          {elseif $product.additional_delivery_times == 2}
            {if $product.quantity> 0}
              <span class="product__delivery__information">{$product.delivery_in_stock}</span>
            {* Out of stock message should not be displayed if customer can't order the product. *}
            {elseif $product.quantity <= 0 && $product.add_to_cart_url}
              <span class="product__delivery__information">{$product.delivery_out_stock}</span>
            {/if}
          {/if}
        {/if}
      {/block}
    </div>

    {block name='product_quantity'}
      <div class="row g-2">
        <div class="product-actions__quantity quantity-button js-quantity-button col-md-auto">
          {include file='components/qty-input.tpl'
            attributes=[
              "id" => "quantity_wanted",
              "class" => "form-control js-quantity-wanted",
              "value" => "{$product.minimal_quantity}",
              "min" => "{$product.minimal_quantity}"
            ]
          }
        </div>

        <div class="product-actions__button add col">
          <button
            class="btn btn-primary btn-with-icon add-to-cart"
            data-button-action="add-to-cart"
            type="submit"
            {if !$product.add_to_cart_url}
              disabled
            {/if}
         >
            <i class="material-icons me-1" aria-hidden="true">&#xE547;</i>
            {l s='Add to cart' d='Shop.Theme.Actions'}
          </button>
        </div>

        {hook h='displayProductActions' product=$product}
      </div>
    {/block}

    {block name='product_minimal_quantity'}
      <p class="product__minimal-quantity product-minimal-quantity js-product-minimal-quantity d-flex align-items-center mt-3 mt-md-0">
        {if $product.minimal_quantity> 1}
          <i class="material-icons me-2" aria-hidden="true">&#xE88F;</i>
          {l
            s='The minimum purchase order quantity for the product is %quantity%.'
            d='Shop.Theme.Checkout'
            sprintf=['%quantity%' => $product.minimal_quantity]
          }
        {/if}
      </p>
    {/block}
  {/if}
</div>
