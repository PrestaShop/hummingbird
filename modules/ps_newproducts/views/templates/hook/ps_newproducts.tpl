{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{extends file="components/module-products.tpl"}

{block name='module_products_name'}ps-newproducts{/block}

{block name='module_products_title'}
  {include file='components/section-title.tpl' title={l s='Latest arrivals' d='Shop.Theme.Catalog'}}
{/block}

{block name='module_products_footer'}
  <a class="btn btn-outline-primary" href="{$allNewProductsLink}">
    {l s='All new products' d='Shop.Theme.Catalog'}
    <i class="material-icons" aria-hidden="true">&#xE315;</i>
  </a>
{/block}
