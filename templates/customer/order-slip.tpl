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
  {l s='Credit slips' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  <h6>{l s='Credit slips you have received after canceled orders.' d='Shop.Theme.Customeraccount'}</h6>

  {if $credit_slips}
    <div class="table-wrapper">
      <table class="table d-none d-sm-table">
        <thead class="thead-default">
          <tr>
            <th>{l s='Order' d='Shop.Theme.Customeraccount'}</th>
            <th>{l s='Credit slip' d='Shop.Theme.Customeraccount'}</th>
            <th>{l s='Date issued' d='Shop.Theme.Customeraccount'}</th>
            <th class="text-center">{l s='View credit slip' d='Shop.Theme.Customeraccount'}</th>
          </tr>
        </thead>
        <tbody>
          {foreach from=$credit_slips item=slip}
            <tr>
              <td><a href="{$slip.order_url_details}" data-link-action="view-order-details">{$slip.order_reference}</a></td>
              <td scope="row">{$slip.credit_slip_number}</td>
              <td>{$slip.credit_slip_date}</td>
              <td class="text-center">
                <a href="{$slip.url}"><i class="material-icons">&#xE415;</i></a>
              </td>
            </tr>
          {/foreach}
        </tbody>
      </table>
    </div>

    <div class="credit-slips table-wrapper py-3 d-block d-sm-none">
      {foreach from=$credit_slips item=slip}
        <div class="credit-slip">
          <ul class="m-0">
            <li class="row">
              <p class="col fw-bold">{l s='Order' d='Shop.Theme.Customeraccount'}</p>
              <a href="{$slip.order_url_details}" data-link-action="view-order-details"
                class="col text-end">{$slip.order_reference}</a>
            </li>
            <li class="row">
              <p class="col fw-bold">{l s='Credit slip' d='Shop.Theme.Customeraccount'}</p>
              <p class="col text-end">
                {$slip.credit_slip_number}
              </p>
            </li>
            <li class="row">
              <p class="col fw-bold">{l s='Date issued' d='Shop.Theme.Customeraccount'}</p>
              <p class="col text-end">{$slip.credit_slip_date}</p>
            </li>
            <li class="row">
              <p class="col fw-bold m-0">{l s='View credit slip' d='Shop.Theme.Customeraccount'}</p>
              <a href="{$slip.url}" class="col text-end"><i class="material-icons">picture_as_pdf</i></a>
            </li>
          </ul>
        </div>
      {/foreach}
    </div>
  {else}
    <div class="alert alert-info" role="alert" data-alert="info">
      {l s='You have not received any credit slips.' d='Shop.Notifications.Warning'}</div>
  {/if}
{/block}
