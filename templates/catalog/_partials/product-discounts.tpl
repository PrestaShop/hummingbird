{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<section class="product__discounts js-product-discounts">
  {if $product.quantity_discounts}
    <p class="h6 product__discounts__title">{l s='Volume discounts' d='Shop.Theme.Catalog'}</p>
    {block name='product_discount_table'}
      <div class="table-wrapper border border-secondary py-2 px-0 px-md-3 mb-3">
        <table class="table product__discounts__table w-100 mb-0">
          <thead>
          <tr>
            <th class="text-center">{l s='Quantity' d='Shop.Theme.Catalog'}</th>
            <th class="text-center">{$configuration.quantity_discount.label}</th>
            <th class="text-center">{l s='You Save' d='Shop.Theme.Catalog'}</th>
          </tr>
          </thead>
          <tbody>
          {foreach from=$product.quantity_discounts item='quantity_discount' name='quantity_discounts'}
            <tr data-discount-type="{$quantity_discount.reduction_type}" data-discount="{$quantity_discount.real_value}" data-discount-quantity="{$quantity_discount.quantity}">
              <td class="text-center">{$quantity_discount.quantity}</td>
              <td class="text-center">{$quantity_discount.discount}</td>
              <td class="text-center">{$quantity_discount.save}</td>
            </tr>
          {/foreach}
          </tbody>
        </table>
      </div>
    {/block}
  {/if}
</section>
