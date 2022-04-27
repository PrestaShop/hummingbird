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

{if isset($listing.rendered_facets)}
  <div id="search_filters_wrapper" class="d-none d-md-block">
    <div id="_desktop_faceted">
      {$listing.rendered_facets nofilter}
    </div>
  </div>

  <div class="offcanvas offcanvas-start" tabindex="-1" id="offcanvas-faceted" aria-labelledby="faceted-offcanvas-label">
    <div class="offcanvas-header">
      <h5 class="offcanvas-title" id="faceted-offcanvas-label">{l s='Filter By' d='Shop.Theme.Actions'}</h5>
      <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <div class="offcanvas-body">
      <div id="_mobile_faceted"></div>
    </div>
  </div>
{/if}
