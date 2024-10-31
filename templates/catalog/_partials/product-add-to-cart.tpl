{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<div class="product__add-to-cart product-add-to-cart js-product-add-to-cart">
  {if !$configuration.is_catalog}
    <div class="mb-3">
      {block name='product_availability'}
        <div id="product-availability" class="product-availability js-product-availability">
          {if $product.show_availability && $product.availability_message}

            {** First, we prepare the icons and colors we want to use *}
            {if $product.availability == 'in_stock'}
              {assign 'availability_icon' 'E5CA'}
              {assign 'availability_color' 'success'}
            {elseif $product.availability == 'available'}
              {assign 'availability_icon' 'E002'}
              {assign 'availability_color' 'warning'}
            {elseif $product.availability == 'last_remaining_items'}
              {assign 'availability_icon' 'E002'}
              {assign 'availability_color' 'warning'}
            {else}
              {assign 'availability_icon' 'E14B'}
              {assign 'availability_color' 'danger'}
            {/if}

            {** And render the availability message with icon *}
            <div class="alert alert-{$availability_color}" role="alert">
              <div class="d-flex">
                <div class="me-2">
                  <i class="material-icons rtl-no-flip">&#x{$availability_icon};</i>
                </div>
                <div>
                  <div>{$product.availability_message}</div>
                  {if !empty($product.availability_submessage)}
                    <div class="mt-1"><small>{$product.availability_submessage}</small></div>
                  {/if}
                </div>
              </div>
            </div>
          {/if}
        </div>
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
