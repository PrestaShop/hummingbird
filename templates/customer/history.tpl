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
{extends 'customer/page.tpl'}

{block name='page_title'}
  {l s='Order history' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  <p>{l s='Here are the orders you\'ve placed since your account was created.' d='Shop.Theme.Customeraccount'}</p>

  {if $orders}
    <div class="table-wrapper">
      <table class="table table-striped d-none d-xl-table">
        <thead class="thead-default">
          <tr>
            <th>{l s='Order reference' d='Shop.Theme.Checkout'}</th>
            <th>{l s='Date' d='Shop.Theme.Checkout'}</th>
            <th>{l s='Total price' d='Shop.Theme.Checkout'}</th>
            <th class="d-none d-lg-table-cell">{l s='Payment' d='Shop.Theme.Checkout'}</th>
            <th class="d-none d-lg-table-cell">{l s='Status' d='Shop.Theme.Checkout'}</th>
            <th>{l s='Invoice' d='Shop.Theme.Checkout'}</th>
            <th>&nbsp;</th>
          </tr>
        </thead>
        <tbody>
          {foreach from=$orders item=order}
            <tr>
              <th scope="row">{$order.details.reference}</th>
              <td>{$order.details.order_date}</td>
              <td class="text-xs-end">{$order.totals.total.value}</td>
              <td class="d-none d-lg-table-cell">{$order.details.payment}</td>
              <td>
                <span
                  class="badge pill {$order.history.current.contrast}"
                  style="background-color:{$order.history.current.color}"
                >
                  {$order.history.current.ostate_name}
                </span>
              </td>
              <td class="text-sm-center d-none d-lg-table-cell">
                {if $order.details.invoice_url}
                  <a href="{$order.details.invoice_url}"><i class="material-icons">&#xE415;</i></a>
                {else}
                  -
                {/if}
              </td>
              <td class="order__actions text-sm-center">
                <a href="{$order.details.details_url}" data-link-action="view-order-details">{l s='Details' d='Shop.Theme.Customeraccount'}</a>
                {if $order.details.reorder_url}
                  <a href="{$order.details.reorder_url}">{l s='Reorder' d='Shop.Theme.Actions'}</a>
                {/if}
              </td>
            </tr>
          {/foreach}
        </tbody>
      </table>
    </div>

    <div class="orders row d-block d-xl-none">
      {foreach from=$orders item=order}
        <div class="order col col-lg-6">
          <div class="order__reference">
            <p class="order__label">{l s='Order reference' d='Shop.Theme.Checkout'}</p> 
            <p class="order__value">
              <a href="{$order.details.details_url}">
                {$order.details.reference}
              </a>
            </p>
          </div>

          <div class="order__date">
            <p class="order__label">{l s='Date' d='Shop.Theme.Checkout'}</p> 
            <p class="order__value">{$order.details.order_date}</p>
          </div>

          <div class="order__total">
            <p class="order__label">{l s='Total price' d='Shop.Theme.Checkout'}</p> 
            <p class="order__value">{$order.totals.total.value}</p>
          </div>

          <div class="order__payment">
            <p class="order__label">{l s='Payment' d='Shop.Theme.Checkout'}</p> 
            <p class="order__value">{$order.details.payment}</p>
          </div>

          <div class="order__status">
            <p class="order__label">{l s='Status' d='Shop.Theme.Checkout'}</p> 
            <p class="order__value">
              <span
                class="badge {$order.history.current.contrast}"
                style="background-color:{$order.history.current.color}"
              >
                {$order.history.current.ostate_name}
              </span>
            </p>
          </div>

          <div class="order__invoice">
            <p class="order__label">{l s='Invoice' d='Shop.Theme.Checkout'}</p> 
            <p class="order__value">
              {if $order.details.invoice_url}
                <a href="{$order.details.invoice_url}"><i class="material-icons">&#xE415;</i></a>
              {else}
                -
              {/if}
            </p>
          </div>

          <div class="order__actions">
            <a href="{$order.details.details_url}" data-link-action="view-order-details">{l s='Details' d='Shop.Theme.Customeraccount'}</a>
            {if $order.details.reorder_url}
              <a href="{$order.details.reorder_url}">{l s='Reorder' d='Shop.Theme.Actions'}</a>
            {/if}
          </div>
        </div>
      {/foreach}
    </div>
  {else}
    <div class="alert alert-info" role="alert" data-alert="info">{l s='You have not placed any orders.' d='Shop.Notifications.Warning'}</div>
  {/if}
{/block}
