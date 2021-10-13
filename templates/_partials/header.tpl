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
{$headerTopName = 'header-top'}
{$headerBottomName = 'header-bottom'}

{block name='header_banner'}
  <div class="header-banner">
    {hook h='displayBanner'}
  </div>
{/block}

{block name='header_nav'}
  <nav class="{$headerTopName}">
    <div class="container">
      <div class="{$headerTopName}-content">
        <div class="{$headerTopName}-desktop hidden-on-mobile">
          <div class="{$headerTopName}-left col-md-5 col-xs-12">
            {hook h='displayNav1'}
          </div>
          <div class="{$headerTopName}-right col-md-7">
              {hook h='displayNav2'}
          </div>
        </div>
        <div class="hidden-on-desktop text-sm-center mobile">
          <div class="float-xs-left" id="menu-icon">
            <i class="material-icons d-inline">&#xE5D2;</i>
          </div>
          <div class="float-xs-right" id="_mobile_cart"></div>
          <div class="float-xs-right" id="_mobile_user_info"></div>
          <div class="top-logo" id="_mobile_logo"></div>
          <div class="clearfix"></div>
        </div>
      </div>
    </div>
  </nav>
{/block}

{block name='header_top'}
  <div class="{$headerBottomName} navbar navbar-expand-lg">
    <div class="container">
      {if $page.page_name == 'index'}
        <a class="navbar-brand" href="{$urls.pages.index}">
          <h1>
              <img class="logo img-responsive" src="{$shop.logo_details.src}" alt="{$shop.name}" loading="lazy" width="{$shop.logo_details.width}" height="{$shop.logo_details.height}">
          </h1>
        </a>
      {else}
        <a class="navbar-brand" href="{$urls.pages.index}">
          <img class="logo img-responsive" src="{$shop.logo_details.src}" alt="{$shop.name}" loading="lazy" width="{$shop.logo_details.width}" height="{$shop.logo_details.height}">
        </a>
      {/if}

      {hook h='displayTop'}

      <div id="mobile_top_menu_wrapper" class="row d-none d-sm-block d-md-none" style="display:none;">
        <div class="js-top-menu mobile" id="_mobile_top_menu"></div>
        <div class="js-top-menu-bottom">
          <div id="_mobile_currency_selector"></div>
          <div id="_mobile_language_selector"></div>
          <div id="_mobile_contact_link"></div>
        </div>
      </div>
    </div>
  </div>
  {hook h='displayNavFullWidth'}
{/block}
