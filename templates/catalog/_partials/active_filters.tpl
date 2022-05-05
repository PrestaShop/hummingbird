{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<section id="js-active-search-filters" class="{if $activeFilters|count}active_filters{else}hide{/if}">
  {block name='active_filters_title'}
    <h1 class="h6 {if $activeFilters|count}active-filter-title{else}d-block d-sm-none{/if}">{l s='Active filters' d='Shop.Theme.Global'}</h1>
  {/block}

  {if $activeFilters|count}
    <ul>
      {foreach from=$activeFilters item="filter"}
        {block name='active_filters_item'}
          <li class="filter-block">
            {l s='%1$s:' d='Shop.Theme.Catalog' sprintf=[$filter.facetLabel]}
            {$filter.label}
            <a class="js-search-link" href="{$filter.nextEncodedFacetsURL}"><i class="material-icons close">&#xE5CD;</i></a>
          </li>
        {/block}
      {/foreach}
    </ul>
  {/if}
</section>
