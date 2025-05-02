{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<div id="js-product-list-top">
  <div class="products__selection">
    <div class="products__count">
      {if $listing.pagination.total_items> 1}
        <span>{l s='There are %product_count% products.' d='Shop.Theme.Catalog' sprintf=['%product_count%' => $listing.pagination.total_items]}</span>
      {elseif $listing.pagination.total_items> 0}
        <span>{l s='There is 1 product.' d='Shop.Theme.Catalog'}</span>
      {/if}
    </div>

    <div class="products__sort">
      {block name='sort_by'}
        {include file='catalog/_partials/sort-orders.tpl' sort_orders=$listing.sort_orders}
      {/block}

      {if !empty($listing.rendered_facets) && !$page.body_classes['layout-full-width']}
        <button id="search_filter_toggler" class="products__filter-button btn btn-outline-primary js-search-toggler" data-bs-toggle="offcanvas" data-bs-target="#offcanvas-faceted">
          <i class="material-icons" aria-hidden="true">&#xE152;</i>
          {l s='Filter' d='Shop.Theme.Actions'}
        </button>
      {/if}
    </div>
  </div>
</div>
