{*
 * This file allows you to customize your search page.
 * You can safely remove it if you want it to appear exactly like all other product listing pages
 *}
{extends file='catalog/listing/product-list.tpl'}

{block name='product_list'}
  {include file='catalog/_partials/products.tpl' listing=$listing}
{/block}

{block name='error_content'}
  <p>{l s='Search again what you are looking for.' d='Shop.Theme.Catalog'}</p>
{/block}

{block name='product_list_header'}
  {if empty($search_string)}
    {assign var='title' value={l s='Nothing to search for' d='Shop.Theme.Catalog'}}
  {else}
    {if $listing.products|count}
      {assign var='title' value={l s='Search results for "%search_term%"' sprintf=['%search_term%' => $search_string] d='Shop.Theme.Catalog'}}
    {else}
      {assign var='title' value={l s='No search results for "%search_term%"' sprintf=['%search_term%' => $search_string] d='Shop.Theme.Catalog'}}
    {/if}
  {/if}

  <div id="js-product-list-header">
    {include file='components/page-title-section.tpl' title=$title}
  </div>
{/block}
