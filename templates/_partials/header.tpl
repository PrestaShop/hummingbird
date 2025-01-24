{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{$headerBanner = 'header-banner'}
{$headerTop = 'header-top'}
{$headerBottom = 'header-bottom'}
{$headerNavFullWidth = 'header-nav-full-width'}

{capture name="header_banner"}{hook h='displayBanner'}{/capture}
{block name='header_banner'}
  {if isset($smarty.capture.header_banner) && $smarty.capture.header_banner}
    <div class="{$headerBanner}">
      {$smarty.capture.header_banner nofilter}
    </div>
  {/if}
{/block}

{capture name="header_nav_1"}{hook h='displayNav1'}{/capture}
{capture name="header_nav_2"}{hook h='displayNav2'}{/capture}
{block name='header_nav'}
  {if (isset($smarty.capture.header_nav_1) && $smarty.capture.header_nav_1) || (isset($smarty.capture.header_nav_2) && $smarty.capture.header_nav_2)}
    <div class="{$headerTop} d-none d-md-block">
      <div class="container-md">
        <div class="row">
          <div class="{$headerTop}__left col-md-4">
            {$smarty.capture.header_nav_1 nofilter}
          </div>

          <div class="{$headerTop}__right col-md-8">
            {$smarty.capture.header_nav_2 nofilter}
          </div>
        </div>
      </div>
    </div>
  {/if}
{/block}

{block name='header_bottom'}
  <div class="{$headerBottom}">
    <div class="{$headerBottom}__container container-md">
      <div class="{$headerBottom}__row row gx-2 align-items-stretch">
        <div class="{$headerBottom}__logo d-flex align-items-center col-auto me-auto me-md-0">
          {if $shop.logo_details}
            {if $page.page_name == 'index'}<h1 class="{$headerBottom}__h1 mb-0">{/if}
              {renderLogo}
            {if $page.page_name == 'index'}</h1>{/if}
          {/if}
        </div>

        {hook h='displayTop'}

        {* MOBILE SEARCH BAR *}
        <div class="ps-searchbar--mobile d-md-none d-flex col-auto">
          <div class="header-block d-flex align-items-center">
            <a class="header-block__action-btn" href="#" role="button" data-bs-toggle="offcanvas" data-bs-target="#searchCanvas" aria-controls="searchCanvas" aria-label="{l s='Show search bar' d='Shop.Theme.Global'}">
              <span class="material-icons header-block__icon">search</span>
            </a>
          </div>

          <div class="ps-searchbar__offcanvas js-search-offcanvas offcanvas offcanvas-top h-auto" tabindex="-1" id="searchCanvas" aria-labelledby="offcanvasTopLabel">
            <div class="offcanvas-header">
              <div id="_mobile_ps_searchbar" class="ps-searchbar__container"></div>
              <button type="button" class="btn btn-link text-reset" data-bs-dismiss="offcanvas" aria-label="Close">{l s='Cancel' d='Shop.Theme.Global'}</button>
            </div>
          </div>
        </div>

        <div id="_mobile_ps_customersignin" class="d-md-none d-flex col-auto">
          {* JUST PLACEHOLDER FOR RESPONSIVE COMPONENT TO LOAD REAL ONE *}
          <div class="header-block">
            <a href="{$urls.pages.my_account|escape:'htmlall':'UTF-8'}" class="header-block__action-btn">
              <i class="material-icons header-block__icon" aria-hidden="true">account_circle</i>
            </a>
          </div>
          {* JUST PLACEHOLDER FOR RESPONSIVE COMPONENT TO LOAD REAL ONE *}
        </div>

        {if !$configuration.is_catalog}
          <div id="_mobile_ps_shoppingcart" class="d-md-none d-flex col-auto">
            {* JUST PLACEHOLDER FOR RESPONSIVE COMPONENT TO LOAD REAL ONE *}
            <div class="header-block">
              <a href="{$urls.pages.cart|escape:'htmlall':'UTF-8'}" class="header-block__action-btn">
                <i class="material-icons header-block__icon" aria-hidden="true">shopping_cart</i>
                <span class="header-block__badge">{$cart.products_count}</span>
              </a>
            </div>
            {* JUST PLACEHOLDER FOR RESPONSIVE COMPONENT TO LOAD REAL ONE *}
          </div>
        {/if}
      </div>
    </div>
  </div>

  {capture name="nav_full_width"}{hook h='displayNavFullWidth'}{/capture}
  {if isset($smarty.capture.nav_full_width) && $smarty.capture.nav_full_width}
    <div class="{$headerNavFullWidth}">
      {$smarty.capture.nav_full_width nofilter}
    </div>
  {/if}
{/block}
