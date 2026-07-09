{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
{extends file=$layout}

{block name='content'}
  {block name='supplier_header'}
    {include file='components/page-title-section.tpl' title={l s='Suppliers' d='Shop.Theme.Catalog'}}
  {/block}
 
  {block name='supplier_miniature'}
    {**
     * Determine if at least one supplier has an image.
     * If so, render every miniature with an image slot (real image or placeholder),
     * so the list stays visually consistent. Otherwise, render no image at all.
     *}
    {assign var=displaySupplierImages value=false}
    {if !empty($suppliers)}
      {foreach $suppliers as $supplier}
        {if !empty($supplier.image.bySize.small_default.url)}
          {assign var=displaySupplierImages value=true}
          {break}
        {/if}
      {/foreach}
    {/if}

    <ul class="supplier__list">
      {foreach from=$suppliers item=supplier}
        {include file='catalog/_partials/miniatures/supplier.tpl' supplier=$supplier displayImages=$displaySupplierImages}
      {/foreach}
    </ul>
  {/block}
{/block}
