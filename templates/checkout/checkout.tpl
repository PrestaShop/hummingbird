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
{extends file=$layout}

{block name='notifications'}
{/block}

{block name='content_columns'}
  {include file="checkout/checkout-steps.tpl"}

  {block name='checkout_notifications'}
    {include file='_partials/notifications.tpl'}
  {/block}

  <div class="container">
    <div class="row">

      <div class="cart-grid-body col-lg-7 order-1 order-lg-0">
          {render file='checkout/checkout-process.tpl' ui=$checkout_process}
        {block name='checkout_process'}
        {/block}
      </div>
      <div class="cart-grid-right col-lg-5 order-0 order-lg-1">
        <div class="accordion">
          <div class="accordion-item bg-transparent">
            <button class="accordion-button collapsed px-0 mb-3 d-flex d-lg-none bg-transparent" type="button" data-bs-target="#js-checkout-summary" data-bs-toggle="collapse" aria-expanded="false">
              {l s='Order summary' d='Shop.Theme.Checkout'}
            </button>

            {block name='cart_summary'}
              {include file='checkout/_partials/cart-summary.tpl' cart=$cart}
            {/block}
          </div>
        </div>

        <hr />

        {hook h='displayReassurance'}
      </div>
    </div>
  </div>
{/block}
