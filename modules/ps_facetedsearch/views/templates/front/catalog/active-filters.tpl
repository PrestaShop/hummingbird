{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$componentName = 'active-filters'}

<div id="js-active-search-filters" class="{$componentName}">
  {if $activeFilters|count}
    <ul class="{$componentName}__list">
      {block name='active_filters_title'}
        <li class="{$componentName}__item">
          <span class="{$componentName}__title">{l s='Active filters' d='Shop.Theme.Global'}</span>
        </li>
      {/block}
      {foreach from=$activeFilters item="filter"}
        {block name='active_filters_item'}
          <li class="{$componentName}__item">
            <a
              class="{$componentName}__link btn btn-outline-tertiary rounded-pill btn-sm js-search-link"
              href="{$filter.nextEncodedFacetsURL}"
              rel="nofollow"
              aria-label="{l s='Remove filter: %1$s %2$s' d='Shop.Theme.Catalog' sprintf=[$filter.facetLabel, $filter.label]}"
              tabindex="0"
            >
              {l s='%1$s:' d='Shop.Theme.Catalog' sprintf=[$filter.facetLabel]} {$filter.label}
              <i class="material-icons" aria-hidden="true">&#xE14C;</i>
            </a>
          </li>
        {/block}
      {/foreach}
    </ul>
  {/if}
</div>
