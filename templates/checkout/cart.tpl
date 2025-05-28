{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file=$layout}

{block name='content'}
  <div class="cart-grid row">
    <!-- Left Block: cart product informations & shipping -->
    <div class="cart-grid__content col-lg-8">
      {include file='components/page-title-section.tpl' title={l s='Shopping Cart' d='Shop.Theme.Checkout'}}

      <!-- cart products detailed -->
      <div class="cart-grid__products-details js-cart-container">
        <div class="js-cart-update-alert" data-alert="{l s='has been removed from the cart.' d='Shop.Theme.Actions' js=1}"></div>
        
        {block name='cart_overview'}
          {include file='checkout/_partials/cart-detailed.tpl' cart=$cart}
        {/block}

        {block name='continue_shopping'}
          <a class="cart__continue-shopping btn btn-outline-primary" href="{$urls.pages.index}">
            <i class="material-icons rtl-flip" aria-hidden="true">&#xE5C4;</i>
            {l s='Continue shopping' d='Shop.Theme.Actions'}
          </a>
        {/block}

        <!-- shipping informations -->
        {block name='hook_shopping_cart_footer'}
          {hook h='displayShoppingCartFooter'}
        {/block}
      </div>
    </div>


    <!-- Right Block: cart subtotal & cart total -->
    <div class="cart-grid__aside col-lg-4">
      <h2>{l s='Order summary' d='Shop.Theme.Checkout'}</h2>

      {block name='cart_summary'}
        <div class="cart-summary js-cart-summary">
          {block name='hook_shopping_cart'}
            {hook h='displayShoppingCart'}
          {/block}

          {block name='cart_totals'}
            {include file='checkout/_partials/cart-detailed-totals.tpl' cart=$cart}
          {/block}
        </div>
      {/block}

      <hr>

      {block name='hook_reassurance'}
        {hook h='displayReassurance'}
      {/block}
    </div>
  </div>

  <div class="cart-grid__footer row">
    {hook h='displayCrossSellingShoppingCart'}
  </div>
{/block}
