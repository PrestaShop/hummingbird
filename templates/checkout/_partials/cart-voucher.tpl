{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{if $cart.vouchers.allowed}
  {block name='cart_voucher'}
    <div class="cart-voucher js-cart-voucher">
      {if $cart.vouchers.added}
        <hr />

        {block name='cart_voucher_list'}
          <ul class="cart-voucher__list">
            {foreach from=$cart.vouchers.added item=voucher}
              <li class="cart-voucher__item row">
                <span class="cart-voucher__name col">{$voucher.name}</span>
                <div class="d-flex align-items-center justify-content-end col">
                  <span class="fw-bold">{$voucher.reduction_formatted}</span>
                    {if isset($voucher.code) && $voucher.code !== ''}
                      <a href="{$voucher.delete_url}" class="ms-2" data-link-action="remove-voucher"><i class="material-icons" title="{l s='Remove Voucher' d='Shop.Theme.Checkout'}">&#xE872;</i></a>
                    {/if}
                </div>
              </li>
            {/foreach}
          </ul>
        {/block}
      {/if}
    
      <hr />

      <div class="accordion">
        <div class="accordion-item bg-transparent">
          <button class="accordion-button collapsed px-0 bg-transparent" type="button" data-bs-target="#promo-code" data-bs-toggle="collapse" aria-expanded="false">
            {l s='Promo code' d='Shop.Theme.Checkout'}
          </button>

          <div id="promo-code" class="accordion-collapse collapse">
            <div class="accordion-body px-0">
              {block name='cart_voucher_form'}
                <form action="{$urls.pages.cart}" data-link-action="add-voucher" class="d-flex" method="post">
                  <input type="hidden" name="token" value="{$static_token}">
                  <input type="hidden" name="addDiscount" value="1">
                  <input class="form-control" type="text" name="discount_name" placeholder="{l s='Paste your voucher here' d='Shop.Theme.Checkout'}">
                  <button type="submit" class="btn btn-primary ms-2"><span>{l s='Apply' d='Shop.Theme.Actions'}</span></button>
                </form>
              {/block}

              {block name='cart_voucher_notifications'}
                <div class="alert alert-danger js-error mt-2" role="alert" style="display: none;">
                  <i class="material-icons" aria-hidden="true">&#xE001;</i><span class="ml-1 js-error-text"></span>
                </div>
              {/block}
            </div>
          </div>
        </div>
      </div>

      {if $cart.discounts|count> 0}
        <hr />

        <p class="fw-bold fs-6">
          {l s='Take advantage of our exclusive offers:' d='Shop.Theme.Actions'}
        </p>

        <ul class="js-discount cart-voucher__offers">
          {foreach from=$cart.discounts item=discount}
            <li class="cart-voucher__code">
              <span class="js-code btn btn-link p-0 lh-1">{$discount.code}</span> - {$discount.name}
            </li>
          {/foreach}
        </ul>
      {/if}
    </div>
  {/block}
{/if}
