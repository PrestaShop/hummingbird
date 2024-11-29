{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$componentName = 'search-filters-modules'}

<div id="search_filters_brands">
  <section class="{$componentName} facet">
    {if $display_link_brand}
      <a href="{$page_link}" class="{$componentName}-title d-block mb-3" title="{l s='brands' d='Shop.Theme.Catalog'}">
        {l s='Brands' d='Shop.Theme.Catalog'}
      </a>
    {else}
      <p class="{$componentName}-title">
        {l s='Brands' d='Shop.Theme.Catalog'}
      </p>
    {/if}

    <div>
      {if $brands}
        {include file="module:ps_brandlist/views/templates/_partials/$brand_display_type.tpl" brands=$brands}
      {else}
        <p class="mb-0">{l s='No brand' d='Shop.Theme.Catalog'}</p>
      {/if}
    </div>
  </section>
</div>
