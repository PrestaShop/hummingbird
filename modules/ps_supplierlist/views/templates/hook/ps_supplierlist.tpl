{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<div id="search_filters_suppliers">
  <section class="facet">
    {if $display_link_supplier}
      <a href="{$page_link}" class="h6 text-uppercase facet-label" title="{l s='Suppliers' d='Shop.Theme.Catalog'}">
        {l s='Suppliers' d='Shop.Theme.Catalog'}
      </a>
    {else}
      <p class="h6 text-uppercase facet-label">
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
