{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
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
                  <span class="me-2">{$voucher.reduction_formatted}</span>
                    {if isset($voucher.code) && $voucher.code !== ''}
                      <a href="{$voucher.delete_url}" data-link-action="remove-voucher"><i class="material-icons">&#xE872;</i></a>
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
          <button class="accordion-button collapsed px-0 bg-transparent" type="button" data-bs-target="#promo-code" data-bs-toggle="collapse" aria-expanded="{if $cart.discounts|count> 0}true{else}false{/if}">
            {l s='Promo code' d='Shop.Theme.Checkout'}
          </button>

          <div id="promo-code" class="accordion-collapse collapse{if $cart.discounts|count> 0} show{/if}">
            <div class="accordion-body px-0">
              {block name='cart_voucher_form'}
                <form action="{$urls.pages.cart}" data-link-action="add-voucher" class="d-flex" method="post">
                  <input type="hidden" name="token" value="{$static_token}">
                  <input type="hidden" name="addDiscount" value="1">
                  <input class="form-control" type="text" name="discount_name" placeholder="{l s='Promo code' d='Shop.Theme.Checkout'}">
                  <button type="submit" class="btn btn-primary ms-2"><span>{l s='Apply' d='Shop.Theme.Actions'}</span></button>
                </form>
              {/block}

              {block name='cart_voucher_notifications'}
                <div class="alert alert-danger js-error d-none" role="alert">
                  <i class="material-icons">&#xE001;</i><span class="ml-1 js-error-text"></span>
                </div>
              {/block}
            </div>
          </div>
        </div>
      </div>

      {if $cart.discounts|count> 0}
        <p class="block-promo promo-highlighted">
          {l s='Take advantage of our exclusive offers:' d='Shop.Theme.Actions'}
        </p>
        <ul class="js-discount card-block promo-discounts">
          {foreach from=$cart.discounts item=discount}
            <li class="cart-summary-line">
              <span class="label">
                <span class="code">{$discount.code}</span> - {$discount.name}
              </span>
            </li>
          {/foreach}
        </ul>
      {/if}
    </div>
  {/block}
{/if}
