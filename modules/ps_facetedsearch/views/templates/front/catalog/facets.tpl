{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 *}
{$componentName = 'search-filters'}
 
{if $displayedFacets|count}
  <div id="search-filters" class="{$componentName} d-flex flex-direction-column flex-wrap w-100">
    {block name='facets_title'}
      <p class="{$componentName}-title left-block__title d-none d-md-block">{l s='Filter By' d='Shop.Theme.Actions'}</p>
    {/block}

    {block name='facets_clearall_button'}
      {if $activeFilters|count}
        <div class="clear-all-wrapper w-100 order-2 order-md-1">
          <button data-search-url="{$clear_all_link}" class="btn border rounded-pill text-gray py-1 my-2 js-search-filters-clear-all">
            {l s='Clear all' d='Shop.Theme.Actions'}
          </button>
        </div>
      {/if}
    {/block}

    <div class="accordion w-100 order-1 order-md-2">
      {foreach from=$displayedFacets item="facet" name="facets"}
        <section class="facet accordion-item">
          {assign var=_expand_id value=10|mt_rand:100000}
          {assign var=_collapse value=true}
          {foreach from=$facet.filters item="filter"}
            {if $filter.active}{assign var=_collapse value=false}{/if}
          {/foreach}

          <span class="{$componentName}-subtitle facet-title">
            <button class="accordion-button fw-bold px-0{if $_collapse} collapsed{/if}" type="button" data-bs-target="#facet_{$_expand_id}" data-bs-toggle="collapse"{if !$_collapse} aria-expanded="true"{/if}>
              {$facet.label}
            </button>
          </span>
          <div id="facet_{$_expand_id}" class="accordion-collapse collapse{if !$_collapse} show{/if}">
            {if in_array($facet.widgetType, ['radio', 'checkbox'])}
              {block name='facet_item_other'}
                <ul  class="accordion-body px-0 mb-0 pb-1 pt-0">
                  {foreach from=$facet.filters key=filter_key item="filter"}
                    {$isColorOrTexture = isset($filter.properties.color) || isset($filter.properties.texture)}
                    {if !$filter.displayed}
                      {continue}
                    {/if}

                    <li>
                      <div class="{$componentName}-label facet-label{if $filter.active} active {/if}">
                        {if $facet.multipleSelectionAllowed}
                          <div class="form-check{if $isColorOrTexture} ps-0{/if}">
                            <input 
                              class="form-check-input{if $isColorOrTexture} d-none{/if}" 
                              id="facet_input_{$_expand_id}_{$filter_key}"
                              data-search-url="{$filter.nextEncodedFacetsURL}"
                              type="checkbox"
                              {if $filter.active }checked{/if}
                          >
                            <label class="form-check-label align-middle" for="facet_input_{$_expand_id}_{$filter_key}">
                              {if isset($filter.properties.color)}
                                <span class="color color-sm me-1 align-middle{if $filter.active } active{/if}" style="background-color:{$filter.properties.color}"></span>
                                <span class="align-middle">
                                  {$filter.label}
                                  {if $filter.magnitude and $show_quantities}
                                    ({$filter.magnitude})
                                  {/if}
                                </span>
                              {elseif isset($filter.properties.texture)}
                                <span class="color color-sm me-1 texture align-middle{if $filter.active } active{/if}" style="background-image:url({$filter.properties.texture})"></span>
                                <span class="align-middle">
                                  {$filter.label}
                                  {if $filter.magnitude and $show_quantities}
                                    ({$filter.magnitude})
                                  {/if}
                                </span>
                              {else}
                                <a
                                  href="{$filter.nextEncodedFacetsURL}"
                                  class="{$componentName}-link _gray-darker search-link js-search-link"
                                  rel="nofollow"
                              >
                                  {$filter.label}
                                  {if $filter.magnitude and $show_quantities}
                                    <span class="magnitude">({$filter.magnitude})</span>
                                  {/if}
                                </a>
                              {/if}
                            </label>
                          </div>
                        {else}
                          <div class="form-check">
                            <input
                              class="form-check-input"
                              id="facet_input_{$_expand_id}_{$filter_key}"
                              data-search-url="{$filter.nextEncodedFacetsURL}"
                              type="radio"
                              name="filter {$facet.label}"
                              {if $filter.active }checked{/if}
                          >
                            <label class="form-check-label" for="facet_input_{$_expand_id}_{$filter_key}">
                              <a
                                href="{$filter.nextEncodedFacetsURL}"
                                class="{$componentName}-link _gray-darker search-link js-search-link"
                                rel="nofollow"
                            >
                                {$filter.label}
                                {if $filter.magnitude and $show_quantities}
                                  <span class="magnitude">({$filter.magnitude})</span>
                                {/if}
                              </a>
                            </label>
                          </div>
                        {/if}
                      </div>
                    </li>
                  {/foreach}
                </ul>
              {/block}

            {elseif $facet.widgetType == 'dropdown'}
              {block name='facet_item_dropdown'}
                <ul class="accordion-body">
                  <li>
                    <div class="facet-dropdown dropdown">
                      <a class="select-title" rel="nofollow" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        {$active_found = false}
                        <span>
                          {foreach from=$facet.filters item="filter"}
                            {if $filter.active}
                              {$filter.label}
                              {if $filter.magnitude and $show_quantities}
                                ({$filter.magnitude})
                              {/if}
                              {$active_found = true}
                            {/if}
                          {/foreach}
                          {if !$active_found}
                            {l s='(no filter)' d='Shop.Theme.Global'}
                          {/if}
                        </span>
                        <i class="material-icons float-end">&#xE5C5;</i>
                      </a>
                      <div class="dropdown-menu dropdown-menu-start">
                        {foreach from=$facet.filters item="filter"}
                          {if !$filter.active}
                            <a
                              rel="nofollow"
                              href="{$filter.nextEncodedFacetsURL}"
                              class="dropdown-item select-list js-search-link"
                           >
                              {$filter.label}
                              {if $filter.magnitude and $show_quantities}
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

            {elseif $facet.widgetType == 'slider'}
              {block name='facet_item_slider'}
                {foreach from=$facet.filters item="filter"}
                  <div class="accordion-body faceted-filter px-0 js-faceted-filter-slider">
                    <div
                      class="faceted-slider js-faceted-slider-container"
                      data-slider-min="{$facet.properties.min}"
                      data-slider-max="{$facet.properties.max}"
                      data-slider-id="{$_expand_id}"
                      data-slider-values="{$filter.value|@json_encode}"
                      data-slider-unit="{$facet.properties.unit}"
                      data-slider-label="{$facet.label}"
                      data-slider-specifications="{$facet.properties.specifications|@json_encode}"
                      data-slider-encoded-url="{$filter.nextEncodedFacetsURL}"
                      data-slider-direction="{$language.is_rtl}"
                  >
                    </div>
                    <div class="js-faceted-values"></div>  
                  <input 
                    type="hidden"
                    class="form-range-start js-faceted-slider js-faceted-slider-start"
                    id="slider-range_{$_expand_id}-start"
                  >
                  <input 
                    type="hidden"
                    class="form-range-start js-faceted-slider js-faceted-slider-end"
                    id="slider-range_{$_expand_id}-end"
                  >
                </div>
                {/foreach}
              {/block}
            {/if}
          </div>
          {if !$smarty.foreach.facets.last}<hr class="my-0">{/if}
        </section>
      {/foreach}
    </div>
  </div>
{/if}
