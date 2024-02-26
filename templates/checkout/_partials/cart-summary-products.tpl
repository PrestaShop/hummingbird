{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

 <div class="cart-summary__products js-cart-summary-products">
  <p>{$cart.summary_string}</p>

  <p>
    <a href="#cart-summary-product-list" data-bs-toggle="collapse" class="cart-summary__show js-show-details">
      <span>
        {l s='Show details' d='Shop.Theme.Actions'}
      </span>

      <i class="material-icons" aria-hidden="true">expand_more</i>
    </a>
  </p>

  {block name='cart_summary__list'}
    <div class="collapse" id="cart-summary-product-list">
      <ul class="cart-summary__product__list">
        {foreach from=$cart.products item=product}
          <li class="cart-summary__product row my-2">{include file='checkout/_partials/cart-summary-product-line.tpl' product=$product}</li>
        {/foreach}
      </ul>
    </div>
  {/block}
</div>
