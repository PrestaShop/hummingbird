{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$headerTopName = 'header__top'}
{$headerBottomName = 'header__bottom'}

{block name='header_banner'}
  <div class="header__banner">
    {hook h='displayBanner'}
  </div>
{/block}

{block name='header_nav'}
  <nav class="{$headerTopName}">
    <div class="container-md">
      <div class="{$headerTopName}-desktop hidden-on-mobile row">
        <div class="{$headerTopName}__left col-md-5">
          {hook h='displayNav1'}
        </div>
        <div class="{$headerTopName}__right col-md-7">
          {hook h='displayNav2'}
        </div>
      </div>

      <div class="{$headerTopName}-mobile hidden-on-desktop">
        <div id="_mobile_menu"></div>
        <div id="_mobile_logo" class="logo logo-mobile"></div>

        <div class="search__mobile hide-on-desktop">
          <button class="search__mobile__toggler btn d-xl-none" type="button" data-bs-toggle="offcanvas" data-bs-target="#searchCanvas" aria-controls="searchCanvas">
            <span class="material-icons">search</span>  
          </button>

          <div class="search__offcanvas js-search-offcanvas offcanvas offcanvas-top" data-bs-backdrop="false" data-bs-scroll="true" tabindex="-1" id="searchCanvas" aria-labelledby="offcanvasTopLabel">
            <div class="offcanvas-header">
              <div id="_mobile_search" class="search__container"></div>
              <button type="button" class="btn-close text-reset ms-1" data-bs-dismiss="offcanvas" aria-label="Close">{l s='Cancel' d='Shop.Theme.Global'}</button>
            </div>
          </div>
        </div>

        <div id="_mobile_user_info"></div>
        <div id="_mobile_cart"></div>
      </div>
    </div>
  </nav>
{/block}

{block name='header_bottom'}
  <div class="{$headerBottomName}">
    <div class="container {$headerBottomName}__container">
      <div id="_desktop_logo" class="logo logo-desktop order-1 order-xl-0">
        {if $page.page_name == 'index'}<h1>{/if}
        <a class="navbar-brand" href="{$urls.pages.index}">
          <img class="logo img-fluid" src="{$shop.logo_details.src}" alt="{$shop.name}" loading="lazy" width="{$shop.logo_details.width}" height="{$shop.logo_details.height}">
        </a>
        {if $page.page_name == 'index'}</h1>{/if}
      </div>

      {hook h='displayTop'}
    </div>
  </div>
  {hook h='displayNavFullWidth'}
{/block}
