{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}

<section class="ps-supplierlist left-block">
  <p class="left-block__title h3">
    {if $display_link_supplier}
      <a href="{$page_link}">
        {l s='Suppliers' d='Shop.Theme.Catalog'}
      </a>
    {else}
      {l s='Suppliers' d='Shop.Theme.Catalog'}
    {/if}
  </p>

  {if $suppliers}
    {include file="module:ps_supplierlist/views/templates/_partials/$supplier_display_type.tpl" suppliers=$suppliers}
  {else}
    <p class="mb-0">{l s='No supplier' d='Shop.Theme.Catalog'}</p>
  {/if}
</section>
