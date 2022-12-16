{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file='catalog/listing/product-list.tpl'}

{block name='product_list_header'}
  <h1 class="h1 mb-4">{l s='List of products by brand %brand_name%' sprintf=['%brand_name%' => $manufacturer.name] d='Shop.Theme.Catalog'}</h1>
  <div id="manufacturer-short_description" class="rich-text">{$manufacturer.short_description nofilter}</div>
  <div id="manufacturer-description" class="rich-text">{$manufacturer.description nofilter}</div>
{/block}
