{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<section class="product__discounts js-product-discounts">
  {if $product.quantity_discounts}
    {block name='product_discount_table'}
      <table class="table product__discounts__table w-100 mb-3 text-center">
        <thead>
          <tr>
            <th>{l s='Quantity' d='Shop.Theme.Catalog'}</th>
            <th>{$configuration.quantity_discount.label}</th>
            <th>{l s='You Save' d='Shop.Theme.Catalog'}</th>
          </tr>
        </thead>

        <tbody>
          {foreach from=$product.quantity_discounts item='quantity_discount' name='quantity_discounts'}
            <tr data-discount-type="{$quantity_discount.reduction_type}" data-discount="{$quantity_discount.real_value}" data-discount-quantity="{$quantity_discount.quantity}">
              <td>{$quantity_discount.quantity}</td>
              <td>{$quantity_discount.discount}</td>
              <td>{$quantity_discount.save}</td>
            </tr>
          {/foreach}
        </tbody>
      </table>
    {/block}
  {/if}
</section>
