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
  {l s='Your addresses' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  <div class="row addresses">
    {foreach $customer.addresses as $address}
      <div class="col-lg-4 col-md-6 mb-3 address__wrapper">
        {block name='customer_address'}
          {include file='customer/_partials/block-address.tpl' address=$address}
        {/block}
      </div>
    {/foreach}
    <div class="col-lg-4 col-md-6 mb-3">
      <a class="addresses__new-address" href="{$urls.pages.address}" data-link-action="add-address">
        <span class="new-address__text">{l s='Add new address' d='Shop.Theme.Actions'}</span>
        <div class="new-address__icon">
          <i class="material-icons">&#xE145;</i>
        </div>
      </a>
    </div>
  </div>

{/block}
