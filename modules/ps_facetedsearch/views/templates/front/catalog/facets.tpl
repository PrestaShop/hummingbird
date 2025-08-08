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
  <div id="search-filters" class="{$componentName}">
    {block name='facets_title'}
      <p class="left-block__title d-none d-md-block">
        {l s='Filter By' d='Shop.Theme.Actions'}
      </p>
    {/block}

    {block name='facets_clearall_button'}
      {if $activeFilters|count}
        <div class="{$componentName}__clear">
          <button data-search-url="{$clear_all_link}" class="btn btn-outline-tertiary js-search-filters-clear-all">
            <i class="material-icons">&#xE5CD;</i>
            {l s='Clear all' d='Shop.Theme.Actions'}
          </button>
        </div>
      {/if}
    {/block}

    <div class="accordion accordion-flush accordion--small">
      {foreach from=$displayedFacets item="facet" name="facets"}
        <section class="accordion-item">
          {assign var=_expand_id value=10|mt_rand:100000}
          {assign var=_collapse value=true}

          {foreach from=$facet.filters item="filter"}
            {if $filter.active}{assign var=_collapse value=false}{/if}
          {/foreach}

          <button class="accordion-button {if $_collapse} collapsed{/if}" type="button" data-bs-target="#facet_{$_expand_id}" data-bs-toggle="collapse"{if !$_collapse} aria-expanded="true"{/if}>
            {$facet.label}
          </button>

          <div id="facet_{$_expand_id}" class="accordion-collapse collapse{if !$_collapse} show{/if}">
            {if in_array($facet.widgetType, ['radio', 'checkbox'])}
              {block name='facet_item_other'}
                <ul class="accordion-body">
                  {foreach from=$facet.filters key=filter_key item="filter"}
                    {assign var="isColorOrTexture" value=(isset($filter.properties.color) || isset($filter.properties.texture))}

                    {if !$filter.displayed}
                      {continue}
                    {/if}

                    <li>
                      <div class="{$componentName}__item facet-label{if $filter.active} active {/if}">
                        {if $facet.multipleSelectionAllowed}
                          <div class="{$componentName}__form-check{if $isColorOrTexture} {$componentName}__form-check--color{/if} form-check">
                            <input 
                              class="form-check-input{if $isColorOrTexture} d-none{/if}" 
                              id="facet_input_{$_expand_id}_{$filter_key}"
                              data-search-url="{$filter.nextEncodedFacetsURL}"
                              type="checkbox"
                              {if $filter.active }checked{/if}
                            >

                            <label class="{$componentName}__form-label form-check-label" for="facet_input_{$_expand_id}_{$filter_key}">
                              {if isset($filter.properties.color)}
                                <span class="color color-sm {if $filter.active } active{/if}" style="background-color:{$filter.properties.color}"></span>
                                <span class="{$componentName}__color-label">
                                  {$filter.label}
                                  {if $filter.magnitude and $show_quantities}
                                    <span class="{$componentName}__magnitude">
                                      ({$filter.magnitude})
                                    </span>
                                  {/if}
                                </span>
                              {elseif isset($filter.properties.texture)}
                                <span class="color color-sm {if $filter.active } active{/if}" style="background-image:url({$filter.properties.texture})"></span>
                                <span class="{$componentName}__color-label">
                                  {$filter.label}
                                  {if $filter.magnitude and $show_quantities}
                                    <span class="{$componentName}__magnitude">
                                      ({$filter.magnitude})
                                    </span>
                                  {/if}
                                </span>
                              {else}
                                <a
                                  href="{$filter.nextEncodedFacetsURL}"
                                  class="{$componentName}__link search-link js-search-link"
                                  rel="nofollow"
                                >
                                  {$filter.label}
                                  {if $filter.magnitude and $show_quantities}
                                    <span class="{$componentName}__magnitude">
                                      ({$filter.magnitude})
                                    </span>
                                  {/if}
                                </a>
                              {/if}
                            </label>
                          </div>
                        {else}
                          <div class="{$componentName}__form-check form-check">
                            <input
                              class="form-check-input"
                              id="facet_input_{$_expand_id}_{$filter_key}"
                              data-search-url="{$filter.nextEncodedFacetsURL}"
                              type="radio"
                              name="filter {$facet.label}"
                              {if $filter.active }checked{/if}
                            >
                            <label class="{$componentName}__form-label form-check-label" for="facet_input_{$_expand_id}_{$filter_key}">
                              <a
                                href="{$filter.nextEncodedFacetsURL}"
                                class="{$componentName}__link search-link js-search-link"
                                rel="nofollow"
                              >
                                {$filter.label}
                                {if $filter.magnitude and $show_quantities}
                                  <span class="{$componentName}__magnitude">
                                    ({$filter.magnitude})
                                  </span>
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
                    <div class="{$componentName}__item facet-dropdown dropdown">
                      <button class="{$componentName}__dropdown-toggle btn btn-outline-tertiary dropdown-toggle" rel="nofollow" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        {assign var="active_found" value=false}

                        {foreach from=$facet.filters item="filter"}
                          {if $filter.active}
                            {$filter.label}
                            {if $filter.magnitude and $show_quantities}
                              <span class="{$componentName}__magnitude">
                                ({$filter.magnitude})
                              </span>
                            {/if}
                            {$active_found = true}
                          {/if}
                        {/foreach}

                        {if !$active_found}
                          {l s='(no filter)' d='Shop.Theme.Global'}
                        {/if}
                      </button>

                      <div class="{$componentName}__dropdown-menu dropdown-menu dropdown-menu-start">
                        {foreach from=$facet.filters item="filter"}
                          {if !$filter.active}
                            <a
                              rel="nofollow"
                              href="{$filter.nextEncodedFacetsURL}"
                              class="dropdown-item select-list js-search-link"
                            >
                              {$filter.label}
                              {if $filter.magnitude and $show_quantities}
                                <span class="{$componentName}__magnitude">
                                  ({$filter.magnitude})
                                </span>
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
                  <div class="{$componentName}__slider-container accordion-body js-faceted-filter-slider">
                    <div
                      class="{$componentName}__slider js-faceted-slider-container"
                      data-slider-min="{$facet.properties.min}"
                      data-slider-max="{$facet.properties.max}"
                      data-slider-id="{$_expand_id}"
                      data-slider-values="{$filter.value|@json_encode}"
                      data-slider-unit="{$facet.properties.unit}"
                      data-slider-label="{$facet.label}"
                      data-slider-specifications="{$facet.properties.specifications|@json_encode}"
                      data-slider-encoded-url="{$filter.nextEncodedFacetsURL}"
                      data-slider-direction="{$language.is_rtl}"
                    ></div>

                    <div class="{$componentName}__slider-values js-faceted-values"></div>

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
        </section>
      {/foreach}
    </div>
  </div>
{/if}
