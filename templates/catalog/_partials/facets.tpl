{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{if $facets|count}
  <div id="search-filters" class="js-search-filters">
    {block name='facets_title'}
      <p class="text-uppercase h6 d-none d-sm-block d-md-block">{l s='Filter By' d='Shop.Theme.Actions'}</p>
    {/block}

    {block name='facets_clearall_button'}
      {if $activeFilters|count}
        <div id="_desktop_search_filters_clear_all" class="d-none d-sm-block d-md-block clear-all-wrapper">
          <button data-search-url="{$clear_all_link}" class="btn btn-tertiary js-search-filters-clear-all">
            <i class="material-icons" aria-hidden="true">&#xE14C;</i>
            {l s='Clear all' d='Shop.Theme.Actions'}
          </button>
        </div>
      {/if}
    {/block}

    {foreach from=$facets item="facet"}
      {if !$facet.displayed}
        {continue}
      {/if}

      <section class="facet">
        <p class="h6 facet-title d-none d-sm-block d-md-block">{$facet.label}</p>

        {assign var=_expand_id value=10|mt_rand:100000}
        {assign var=_collapse value=true}

        {foreach from=$facet.filters item="filter"}
          {if $filter.active}{assign var=_collapse value=false}{/if}
        {/foreach}

        <div class="title d-none d-sm-block d-md-none" data-target="#facet_{$_expand_id}" data-bs-toggle="collapse"{if !$_collapse} aria-expanded="true"{/if}>
          <p class="h6 facet-title">{$facet.label}</p>

          <span>
            <span class="navbar-toggler collapse-icons">
              <i class="material-icons add">&#xE313;</i>
              <i class="material-icons remove">&#xE316;</i>
            </span>
          </span>
        </div>

        {if $facet.widgetType !== 'dropdown'}
          {block name='facet_item_other'}
            <ul id="facet_{$_expand_id}" class="collapse{if !$_collapse} in{/if}">
              {foreach from=$facet.filters key=filter_key item="filter"}
                {if !$filter.displayed}
                  {continue}
                {/if}

                <li>
                  <label class="facet-label{if $filter.active} active {/if}" for="facet_input_{$_expand_id}_{$filter_key}">
                    {if $facet.multipleSelectionAllowed}
                      <span class="custom-checkbox">
                        <input
                          id="facet_input_{$_expand_id}_{$filter_key}"
                          data-search-url="{$filter.nextEncodedFacetsURL}"
                          type="checkbox"
                          {if $filter.active }checked{/if}
                       >
                        {if isset($filter.properties.texture)}
                          <span class="color texture" style="background-image:url({$filter.properties.texture})"></span>
                        {elseif isset($filter.properties.color)}
                          <span class="color" style="background-color:{$filter.properties.color}"></span>
                        {else}
                          <span {if !$js_enabled} class="ps-shown-by-js" {/if}><i class="material-icons rtl-no-flip checkbox-checked">&#xE5CA;</i></span>
                        {/if}
                      </span>
                    {else}
                      <span class="custom-radio">
                        <input
                          id="facet_input_{$_expand_id}_{$filter_key}"
                          data-search-url="{$filter.nextEncodedFacetsURL}"
                          type="radio"
                          name="filter {$facet.label}"
                          {if $filter.active }checked{/if}
                       >
                        <span {if !$js_enabled} class="ps-shown-by-js" {/if}></span>
                      </span>
                    {/if}

                    <a
                      href="{$filter.nextEncodedFacetsURL}"
                      class="_gray-darker search-link js-search-link"
                      rel="nofollow"
                   >
                      {$filter.label}

                      {if $filter.magnitude}
                        <span class="magnitude">({$filter.magnitude})</span>
                      {/if}
                    </a>
                  </label>
                </li>
              {/foreach}
            </ul>
          {/block}
        {else}
          {block name='facet_item_dropdown'}
            <ul id="facet_{$_expand_id}" class="collapse{if !$_collapse} in{/if}">
              <li>
                <div class="facet-dropdown dropdown">
                  <a class="select-title" rel="nofollow" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    {$active_found = false}

                    <span>
                      {foreach from=$facet.filters item="filter"}
                        {if $filter.active}
                          {$filter.label}
                          {if $filter.magnitude}
                            ({$filter.magnitude})
                          {/if}
                          {$active_found = true}
                        {/if}
                      {/foreach}

                      {if !$active_found}
                        {l s='(no filter)' d='Shop.Theme.Global'}
                      {/if}
                    </span>

                    <i class="material-icons" aria-hidden="true">&#xE5C5;</i>
                  </a>

                  <div class="dropdown-menu dropdown-menu-start">
                    {foreach from=$facet.filters item="filter"}
                      {if !$filter.active}
                        <a
                          rel="nofollow"
                          href="{$filter.nextEncodedFacetsURL}"
                          class="dropdown-item select-list"
                       >
                          {$filter.label}

                          {if $filter.magnitude}
                            ({$filter.magnitude})
                          {/if}
                        </a>
                      {/if}
                    {/foreach}
                  </div>
                </div>
              </li>
            </ul>
          {/block}
        {/if}
      </section>
    {/foreach}
  </div>
{/if}
