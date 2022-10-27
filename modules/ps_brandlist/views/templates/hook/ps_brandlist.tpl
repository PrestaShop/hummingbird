{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<div id="search_filters_brands">
  <section class="facet">
    {if $display_link_brand}
      <a href="{$page_link}" class="h6 text-uppercase facet-label" title="{l s='brands' d='shop.theme.catalog'}">
        {l s='Brands' d='Shop.Theme.Catalog'}
      </a>
    {else}
      <p class="h6 text-uppercase facet-label">
        {l s='Brands' d='Shop.Theme.Catalog'}
      </p>
    {/if}

    <div>
      {if $brands}
        {include file="module:ps_brandlist/views/templates/_partials/$brand_display_type.tpl" brands=$brands}
      {else}
        <p>{l s='No brand' d='Shop.Theme.Catalog'}</p>
      {/if}
    </div>
  </section>
</div>
