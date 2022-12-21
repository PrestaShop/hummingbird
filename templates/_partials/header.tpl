{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$headerTopName = 'header__top'}
{$headerBottomName = 'header-bottom'}

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
    </div>
  </nav>
{/block}

{block name='header_bottom'}
  <div class="{$headerBottomName}">
    <div class="container-md {$headerBottomName}__container">
      <div class="row align-items-center mx-n1 {$headerBottomName}__row">
        <div class="col-auto logo px-1 order-xl-1 me-lg-0 me-auto">
          {if $shop.logo_details}
            {if $page.page_name == 'index'}<h1 class="mb-0">{/if}
              {renderLogo}
            {if $page.page_name == 'index'}</h1>{/if}
          {/if}
        </div>

        <div class="search__mobile hidden-on-desktop col-auto px-1">
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

        {hook h='displayTop'}

        <div id="_mobile_user_info" class="hidden-on-desktop col-auto px-1"></div>
        <div id="_mobile_cart" class="hidden-on-desktop col-auto px-1"></div>
      </div>
    </div>
  </div>
  {hook h='displayNavFullWidth'}
{/block}
