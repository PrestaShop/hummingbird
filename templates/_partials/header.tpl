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
  {if !empty($smarty.capture.header_banner)}
    <div class="{$headerBanner}">
      {$smarty.capture.header_banner nofilter}
    </div>
  {/if}
{/block}

{capture name="header_nav_1"}{hook h='displayNav1'}{/capture}
{capture name="header_nav_2"}{hook h='displayNav2'}{/capture}
{block name='header_nav'}
  {if !empty($smarty.capture.header_nav_1) || !empty($smarty.capture.header_nav_2)}
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
      <div class="{$headerBottom}__row row gx-2 gx-md-4 align-items-stretch">
        <div class="{$headerBottom}__logo d-flex align-items-center col-auto me-auto me-md-0">
          {if $shop.logo_details}
            {if $page.page_name == 'index'}<h1 class="{$headerBottom}__h1 mb-0">{/if}
              {renderLogo}
            {if $page.page_name == 'index'}</h1>{/if}
          {/if}
        </div>

        {hook h='displayTop'}

        <div id="_mobile_ps_customersignin" class="d-md-none d-flex col-auto">
          {* JUST PLACEHOLDER FOR RESPONSIVE COMPONENT TO LOAD REAL ONE *}
          <div class="header-block">
            <a href="{$urls.pages.my_account}" class="header-block__action-btn">
              <i class="material-icons header-block__icon" aria-hidden="true">account_circle</i>
            </a>
          </div>
          {* JUST PLACEHOLDER FOR RESPONSIVE COMPONENT TO LOAD REAL ONE *}
        </div>

        {if !$configuration.is_catalog}
          <div id="_mobile_ps_shoppingcart" class="d-md-none d-flex col-auto">
            {* JUST PLACEHOLDER FOR RESPONSIVE COMPONENT TO LOAD REAL ONE *}
            <div class="header-block">
              <a href="{$urls.pages.cart}" class="header-block__action-btn">
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
  {if !empty($smarty.capture.nav_full_width)}
    <div class="{$headerNavFullWidth}">
      {$smarty.capture.nav_full_width nofilter}
    </div>
  {/if}
{/block}
