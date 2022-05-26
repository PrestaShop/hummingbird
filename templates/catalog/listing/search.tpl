{*
 * This file allows you to customize your search page.
 * You can safely remove it if you want it to appear exactly like all other product listing pages
 *}
{extends file='catalog/listing/product-list.tpl'}

{block name='product_list'}
  {include file='catalog/_partials/products.tpl' listing=$listing productClass="col-6 col-md-4 col-xl-3"}
{/block}

{block name="error_content"}
  <p>{l s='Search again what you are looking for.' d='Shop.Theme.Catalog'}</p>
{/block}

{block name='product_list_header'}
  {if $listing.products|count}
    <h1 id="js-product-list-header" class="h4">
      {l s='Search results for "%searchString%"' sprintf=['%searchString%' => $smarty.get.s] d='Shop.Theme.Catalog'}</h1>
  {else}
    <h1 id="js-product-list-header" class="h4">
      {l s='No search results for "%searchString%"' sprintf=['%searchString%' => $smarty.get.s] d='Shop.Theme.Catalog'}</h1>
  {/if}
{/block}
