{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$componentName = 'search-filters-modules'}

<div id="search_filters_suppliers">
  <section class="{$componentName} facet">
    {if $display_link_supplier}
      <a href="{$page_link}" class="{$componentName}-title d-block mb-3" title="{l s='Suppliers' d='Shop.Theme.Catalog'}">
        {l s='Suppliers' d='Shop.Theme.Catalog'}
      </a>
    {else}
      <p class="{$componentName}-title">
        {l s='Suppliers' d='Shop.Theme.Catalog'}
      </p>
    {/if}

    <div>
      {if $suppliers}
        {include file="module:ps_supplierlist/views/templates/_partials/$supplier_display_type.tpl" suppliers=$suppliers}
      {else}
        <p>{l s='No supplier' d='Shop.Theme.Catalog'}</p>
      {/if}
    </div>
  </section>
</div>
