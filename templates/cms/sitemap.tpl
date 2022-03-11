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
{extends file='page.tpl'}

{block name='page_title'}
  {l s='Sitemap' d='Shop.Theme.Global'}
{/block}

{block name='page_content'}
  <div class="row sitemap">
      <div class="col-md-6 col-lg-3">
        <h2 class="h3">{$our_offers}</h2>
        {include file='cms/_partials/sitemap-nested-list.tpl' links=$links.offers}
        <hr class="d-block d-md-none" />
      </div>
      <div class="col-md-6 col-lg-3">
        <h2 class="h3">{$categories}</h2>
        {include file='cms/_partials/sitemap-nested-list.tpl' links=$links.categories}
        <hr class="d-block d-md-none" />
      </div>
      <div class="col-md-6 col-lg-3">
        <h2 class="h3">{$your_account}</h2>
        {include file='cms/_partials/sitemap-nested-list.tpl' links=$links.user_account}
        <hr class="d-block d-md-none" />
      </div>
      <div class="col-md-6 col-lg-3">
        <h2 class="h3">{$pages}</h2>
        {include file='cms/_partials/sitemap-nested-list.tpl' links=$links.pages}
      </div>
  </div>
{/block}
