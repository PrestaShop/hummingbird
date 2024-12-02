{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$headerTopName = 'header-top'}
{$headerBottomName = 'header-bottom'}

{block name='header_banner'}
  <div class="header__banner">
    {hook h='displayBanner'}
  </div>
{/block}

{block name='header_nav'}
  <nav class="{$headerTopName}">
    <div class="container-md">
      <div class="{$headerTopName}-desktop d-none d-md-flex row">
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
      <div class="row gx-2 align-items-stretch {$headerBottomName}__row">
        <div class="d-flex align-items-center col-auto logo order-xl-1 ms-lg-0 ms-2 me-lg-0 me-auto">
          {if $shop.logo_details}
            {if $page.page_name == 'index'}<h1 class="{$headerBottomName}__h1 mb-0">{/if}
              {renderLogo}
            {if $page.page_name == 'index'}</h1>{/if}
          {/if}
        </div>

        <div class="search__mobile d-md-none d-flex col-auto">

          <div class="header-block d-flex align-items-center">
            <a class="header-block__action-btn" href="#" role="button" data-bs-toggle="offcanvas" data-bs-target="#searchCanvas" aria-controls="searchCanvas" aria-label="{l s='Show search bar' d='Shop.Theme.Global'}">
              <span class="material-icons header-block__icon">search</span>
            </a>
          </div>

          <div class="search__offcanvas js-search-offcanvas offcanvas offcanvas-top h-auto" data-bs-backdrop="false" data-bs-scroll="true" tabindex="-1" id="searchCanvas" aria-labelledby="offcanvasTopLabel">
            <div class="offcanvas-header">
              <div id="_mobile_search" class="search__container"></div>
              <button type="button" class="btn-close text-reset ms-1" data-bs-dismiss="offcanvas" aria-label="Close">{l s='Cancel' d='Shop.Theme.Global'}</button>
            </div>
          </div>
        </div>

        {hook h='displayTop'}

        <div id="_mobile_user_info" class="d-md-none d-flex col-auto">
          {* JUST PLACEHOLDER FOR RESPONSIVE COMPONENT TO LOAD REAL ONE *}
          <div class="header-block">
            <span class="header-block__action-btn">
              <i class="material-icons header-block__icon" aria-hidden="true">&#xE7FD;</i>
              <span class="d-none d-md-inline header-block__title">{l s='Sign in' d='Shop.Theme.Actions'}</span>
            </span>
          </div>
          {* JUST PLACEHOLDER FOR RESPONSIVE COMPONENT TO LOAD REAL ONE *}
        </div>

        <div id="_mobile_cart" class="d-md-none col-auto d-flex">
          {* JUST PLACEHOLDER FOR RESPONSIVE COMPONENT TO LOAD REAL ONE *}
          <div class="header-block d-flex align-items-center">
            <span class="header-block__action-btn">
              <i class="material-icons header-block__icon" aria-hidden="true">shopping_cart</i>
              <span class="header-block__badge">{$cart.products_count}</span>
            </span>
          </div>
          {* JUST PLACEHOLDER FOR RESPONSIVE COMPONENT TO LOAD REAL ONE *}
        </div>
      </div>
    </div>
  </div>

  {hook h='displayNavFullWidth'}
{/block}
