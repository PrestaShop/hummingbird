{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

 <div class="cart-summary__products js-cart-summary-products">
  <div class="cart-summary__products-number">{$cart.summary_string}</div>

  <hr class="mb-2">

  <div class="cart-summary__products-accordion accordion accordion-flush accordion--small">
    <div class="accordion-header">
      <button class="accordion-button collapsed" type="button" data-bs-target="#cart-summary-product-list" data-bs-toggle="collapse" aria-expanded="false">
        {l s='Show details' d='Shop.Theme.Actions'}
      </button>
    </div>

    {block name='cart_summary__list'}
      <div class="accordion-collapse collapse" id="cart-summary-product-list">
        <div class="cart-summary__products-list">
          {foreach from=$cart.products item=product}
            <div class="cart-summary__product">
              {include file='checkout/_partials/cart-summary-product-line.tpl' product=$product}
            </div>
          {/foreach}
        </div>
      </div>
    {/block}
  </div>

  <hr class="mt-2">
</div>
