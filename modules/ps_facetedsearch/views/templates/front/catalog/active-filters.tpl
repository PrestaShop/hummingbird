{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<section id="js-active-search-filters">
  {if $activeFilters|count}
    <ul class="d-flex align-items-center flex-wrap mb-4">
      {block name='active_filters_title'}
        <li class="p-1">
          <p class="fw-bold m-0 me-2">{l s='Active filters' d='Shop.Theme.Global'}</p>
        </li>
      {/block}
      {foreach from=$activeFilters item="filter"}
        {block name='active_filters_item'}
          <li class="p-1">
            <a class="text-nowrap btn rounded-pill bg-light js-search-link d-flex align-items-center" href="{$filter.nextEncodedFacetsURL}" rel="nofollow">
              {l s='%1$s:' d='Shop.Theme.Catalog' sprintf=[$filter.facetLabel]} {$filter.label} <i class="material-icons font-reset ms-1 align-middle">&#xE14C;</i>
            </a>
          </li>
        {/block}
      {/foreach}
    </ul>
  {/if}
</section>
