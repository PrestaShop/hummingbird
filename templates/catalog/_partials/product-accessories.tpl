{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file="components/module-products.tpl"}

{block name='module_products_variables'}
  {assign var="products" value=$accessories}
  {assign var="need_container" value=false}
{/block}

{block name='module_products_name'}product__accessories{/block}

{block name='module_products_title'}
  {include file='components/section-title.tpl' title={l s='You might also like' d='Shop.Theme.Catalog'}}
{/block}
