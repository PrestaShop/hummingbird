{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<p class="d-none d-md-block sort-by m-0 me-3"><i class="material-icons" aria-hidden="true">sort</i><span class="align-middle">{l s='Sort by:' d='Shop.Theme.Global'}</span></p>

<div class="products-sort-order flex-grow-1 flex-grow-md-0 dropdown me-2 me-md-0">
  <button
    class="btn py-2 pe-3 select-title"
    rel="nofollow"
    data-bs-toggle="dropdown"
    aria-haspopup="true"
    aria-expanded="false">
    {if $listing.sort_selected}{$listing.sort_selected}{else}{l s='Choose' d='Shop.Theme.Actions'}{/if}
    <i class="material-icons ms-2">expand_more</i>
  </button>

  <div class="dropdown-menu dropdown-menu-start">
    {foreach from=$listing.sort_orders item=sort_order}
      <a
        rel="nofollow"
        href="{$sort_order.url}"
        class="dropdown-item select-list {['current' => $sort_order.current, 'js-search-link' => true]|classnames}"
      >
        {$sort_order.label}
      </a>
    {/foreach}
  </div>
</div>
