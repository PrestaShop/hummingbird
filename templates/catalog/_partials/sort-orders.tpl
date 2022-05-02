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

<p class="d-none d-md-block sort-by m-0 me-3"><i class="material-icons">sort</i><span class="align-middle">{l s='Sort by:' d='Shop.Theme.Global'}</span></p>
<div class="products-sort-order flex-grow-1 flex-grow-md-0 dropdown me-2 me-md-0">
  <button
    class="btn py-2 pe-3 select-title"
    rel="nofollow"
    data-bs-toggle="dropdown"
    aria-haspopup="true"
    aria-expanded="false">
    {if $listing.sort_selected}{$listing.sort_selected}{else}{l s='Select' d='Shop.Theme.Actions'}{/if}
    <i class="material-icons ms-2">expand_more</i>
  </button>
  <div class="dropdown-menu dropdown-menu-start">
    {foreach from=$listing.sort_orders item=sort_order}
      <a
        rel="nofollow"
        href="{$sort_order.url}"
        class="dropdown-item select-list {['current' => $sort_order.current, 'js-search-link' => true]|classnames}"
     >
        {$sort_order.label}
      </a>
    {/foreach}
  </div>
</div>
