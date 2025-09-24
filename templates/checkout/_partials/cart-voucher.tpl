{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{if $cart.vouchers.allowed}
  {block name='cart_voucher'}
    <div class="cart-summary__voucher cart-voucher js-cart-voucher" tabindex="-1" data-ps-ref="voucher-container">
      {if $cart.vouchers.added}
        {block name='cart_voucher_list'}
          <ul class="cart-voucher__list" tabindex="-1" data-ps-ref="voucher-list" aria-label="{l s='Added vouchers' d='Shop.Theme.Checkout'}">
            {foreach from=$cart.vouchers.added item=voucher}
              <li class="cart-summary__line">
                <span class="cart-summary__label cart-summary__label--voucher">
                  <i class="material-icons" aria-hidden="true">&#xF05B;</i>
                  {$voucher.name}
                </span>

                <div class="cart-summary__value cart-summary__value--bold cart-voucher__value">
                  {$voucher.reduction_formatted}

                  {if isset($voucher.code) && $voucher.code !== ''}
                    <a class="cart-voucher__remove" href="{$voucher.delete_url}" data-link-action="remove-voucher" data-ps-ref="voucher-remove-button" aria-label="{l s='Remove voucher: %voucherName%' sprintf=['%voucherName%' => $voucher.name] d='Shop.Theme.Checkout'}">
                      <i class="material-icons" aria-hidden="true">&#xE872;</i>
                    </a>
                  {/if}
                </div>
              </li>
            {/foreach}
          </ul>
        {/block}
      {/if}

      <div class="cart-voucher__accordion accordion accordion-flush accordion--small">
        <div class="cart-voucher__accordion-item accordion-item">
          <button class="cart-voucher__accordion-button accordion-button collapsed" type="button" data-bs-target="#promo-code" data-bs-toggle="collapse" data-ps-ref="voucher-accordion-button" aria-expanded="false">
            {l s='Promo code' d='Shop.Theme.Checkout'}
          </button>

          <div id="promo-code" class="cart-voucher__accordion-collapse accordion-collapse collapse js-voucher-accordion">
            <div class="accordion-body">
              {block name='cart_voucher_form'}
                <form class="cart-voucher__form" action="{$urls.pages.cart}" data-link-action="add-voucher" data-ps-ref="voucher-form" method="post">
                  <input type="hidden" name="token" value="{$static_token}">
                  <input type="hidden" name="addDiscount" value="1">
                  <input class="form-control js-voucher-input" type="text" name="discount_name" placeholder="{l s='Paste your voucher here' d='Shop.Theme.Checkout'}" required>
                  <button type="submit" class="btn btn-primary" aria-label="{l s='Apply voucher' d='Shop.Theme.Actions'}">{l s='Apply' d='Shop.Theme.Actions'}</button>
                </form>
              {/block}

              {block name='cart_voucher_notifications'}
                <div class="cart-voucher__error alert alert-danger js-error" role="alert" tabindex="-1" style="display: none;" data-ps-ref="voucher-error">
                  <i class="cart-voucher__error-icon material-icons" aria-hidden="true">&#xE001;</i>
                  <span class="js-error-text"></span>
                </div>
              {/block}
            </div>
          </div>
        </div>
      </div>

      {if $cart.discounts|count> 0}
        <div class="cart-voucher__highlight">
          <p class="h5">
            {l s='Take advantage of our exclusive offers:' d='Shop.Theme.Actions'}
          </p>

          <ul class="cart-voucher__offers js-discount">
            {foreach from=$cart.discounts item=discount}
              <li class="cart-voucher__code">
                <button class="cart-voucher__code-value js-voucher-code" aria-label="{l s='Fill %voucherCode% code into the voucher field' sprintf=['%voucherCode%' => $discount.code] d='Shop.Theme.Checkout'}">{$discount.code}</button> - {$discount.name}
              </li>
            {/foreach}
          </ul>
        </div>
      {/if}
    </div>
  {/block}
{/if}
