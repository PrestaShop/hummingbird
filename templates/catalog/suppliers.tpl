{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file=$layout}

{block name='content'}
  {block name='supplier_header'}
    {include file='components/page-title-section.tpl' title={l s='Suppliers' d='Shop.Theme.Catalog'}}
  {/block}
 
  {block name='supplier_miniature'}
    <ul class="supplier__list">
      {foreach from=$suppliers item=supplier}
        {include file='catalog/_partials/miniatures/supplier.tpl' supplier=$supplier}
      {/foreach}
    </ul>
  {/block}
{/block}
