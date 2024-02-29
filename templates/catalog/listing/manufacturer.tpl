{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file='catalog/listing/product-list.tpl'}

{block name='product_list_header'}
  {include file='components/page-title-section.tpl' title={l s='List of products by brand %brand_name%' sprintf=['%brand_name%' => $manufacturer.name] d='Shop.Theme.Catalog'}}
  <div id="manufacturer-short_description" class="rich-text">{$manufacturer.short_description nofilter}</div>
  <div id="manufacturer-description" class="rich-text">{$manufacturer.description nofilter}</div>
{/block}
