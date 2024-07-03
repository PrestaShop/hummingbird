{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$headerCustomBannerName = 'header-custom-banner'}
{$headerTopName = 'header-top'}
{$headerBottomName = 'header-bottom'}

{block name='header_banner'}
  {hook h='displayBanner'}
{/block}

<div class="{$headerCustomBannerName} d-flex justify-content-end px-2 align-items-center py-xl-2">
  {if $page.page_name === 'index'}
    <h1 class="{$headerCustomBannerName}__title w-50 mb-0 d-none d-xl-inline ms-0 me-auto">
      ACCESSAUTO4X4, LE SPÉCIALISTE DE LA VENTE EN LIGNE D'ACCESSOIRES AUTO, 4X4, PICK-UP ET VÉHICULES UTILITAIRES
    </h1>
  {else}
    <p class="{$headerCustomBannerName}__title w-50 mb-0 d-none d-xl-inline ms-0 me-auto">
      ACCESSAUTO4X4, LE SPÉCIALISTE DE LA VENTE EN LIGNE D'ACCESSOIRES AUTO, 4X4, PICK-UP ET VÉHICULES UTILITAIRES
    </p>
  {/if}

  <nav class="d-flex" aria-label="Menu de navigation secondaire">
    <div class="header-block d-none d-md-inline">
      <a class="header-block__action-btn text-center text-nowrap" href="#">Catalogue d'accessoire</a>
    </div>

    <div class="header-block d-none d-md-inline bg-primary">
      <a class="header-block__action-btn text-white" href="#">Contact</a>
    </div>

    <div class="d-flex align-items-center nowrap">
      {widget name="ps_customersignin"}
    </div>
  </nav>
</div>

{block name='header_bottom'}
<div class="{$headerBottomName}">
  <div class="container-fluid {$headerBottomName}__container align-items-center d-flex flex-column flex-md-row py-md-3">

    {if $shop.logo_details}
      {renderLogo}
    {/if}

    <div class="row gx-2 w-100 {$headerBottomName}__row">

      <div class="d-flex flex-column">
        {widget name="ps_searchbar"}
        <p class="mt-04 text-center text-md-end w-75 mx-auto mt-md-2"><i class="icon-phone text-primary fw-bold"></i>Support
          téléphonique - <span class="text-primary fw-bold">France : (+33).6.66.11.14.81</span><br>Espagne :
          +34.972.505.421</p>
      </div>

      {hook h='displayTop'}

      {*        <div class="search__mobile d-md-none col-auto">*}

      {*          <div class="header-block">*}
      {*            <a class="header-block__action-btn" href="#" role="button" data-bs-toggle="offcanvas"*}
      {*               data-bs-target="#searchCanvas" aria-controls="searchCanvas"*}
      {*               aria-label="{l s='Show search bar' d='Shop.Theme.Global'}">*}
      {*              <i class="icon-search"></i>*}
      {*            </a>*}
      {*          </div>*}

      {*          <div class="search__offcanvas js-search-offcanvas offcanvas offcanvas-top h-auto" data-bs-backdrop="false"*}
      {*               data-bs-scroll="true" tabindex="-1" id="searchCanvas" aria-labelledby="offcanvasTopLabel">*}
      {*            <div class="offcanvas-header">*}
      {*              <div id="_mobile_search" class="search__container"></div>*}
      {*              <button type="button" class="btn-close text-reset ms-1" data-bs-dismiss="offcanvas"*}
      {*                      aria-label="Close">{l s='Fermer' d='Shop.Theme.Global'}</button>*}
      {*            </div>*}
      {*          </div>*}
      {*        </div>*}

      {*        <div id="_mobile_user_info" class="d-md-none col-auto">*}
      {*          *}{* JUST PLACEHOLDER FOR RESPONSIVE COMPONENT TO LOAD REAL ONE *}
      {*          <div class="header-block">*}
      {*            <span class="header-block__action-btn">*}
      {*               <i class="icon-user"></i>*}
      {*              <span class="d-none d-md-inline header-block__title">{l s='Sign in' d='Shop.Theme.Actions'}</span>*}
      {*            </span>*}
      {*          </div>*}
      {*          *}{* JUST PLACEHOLDER FOR RESPONSIVE COMPONENT TO LOAD REAL ONE *}
      {*        </div>*}

      {*              <div id="_mobile_cart" class="d-md-none col-auto ms-auto me-0">*}
      {*                <div class="header-block">*}
      {*                  <span class="header-block__action-btn">*}
      {*                     <i class="icon-basket"></i>*}
      {*                    <span class="header-block__badge">{$cart.products_count}</span>*}
      {*                  </span>*}
      {*                </div>*}
      {*              </div>*}
      {*      </div>*}
    </div>

    {block name='header_nav'}
      <div class="{$headerTopName}">
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
      </div>
    {/block}
  </div>

  {include file='_partials/main_menu.tpl'}

  {hook h='displayNavFullWidth'}

  {/block}
