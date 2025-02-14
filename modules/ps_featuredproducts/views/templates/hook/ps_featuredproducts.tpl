{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{extends file="components/module-products.tpl"}

{block name='module_products_name'}ps-featuredproducts{/block}

{block name='module_products_title'}
  {include file='components/section-title.tpl' title={l s='Popular Products' d='Shop.Theme.Catalog'}}
{/block}

{block name='module_products_footer'}
  <a class="btn btn-outline-primary btn-with-icon" href="{$allProductsLink}">
    {l s='All products' d='Shop.Theme.Catalog'}
    <i class="material-icons rtl-flip" aria-hidden="true">&#xE315;</i>
  </a>
{/block}
