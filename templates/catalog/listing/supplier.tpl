{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file='catalog/listing/product-list.tpl'}

{block name='product_list_header'}
  {include file='components/page-title-section.tpl' title={l s='List of products by supplier %s' sprintf=[$supplier.name] d='Shop.Theme.Catalog'}}
  <div id="supplier-description" class="rich-text">{$supplier.description nofilter}</div>
{/block}
