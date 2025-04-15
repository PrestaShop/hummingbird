{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<div class="products__sort-label">
  <span class="align-middle">{l s='Sort by:' d='Shop.Theme.Global'}</span>
</div>

<div class="products__sort-dropdown">
  <button
    class="products__sort-dropdown-button btn btn-outline-tertiary dropdown-toggle"
    rel="nofollow"
    data-bs-toggle="dropdown"
    aria-haspopup="true"
    aria-expanded="false">
    {if $listing.sort_selected}{$listing.sort_selected}{else}{l s='Choose' d='Shop.Theme.Actions'}{/if}
  </button>

  <div class="dropdown-menu">
    {foreach from=$listing.sort_orders item=sort_order}
      <a
        rel="nofollow"
        href="{$sort_order.url}"
        class="dropdown-item {['current' => $sort_order.current, 'js-search-link' => true]|classnames}"
      >
        {$sort_order.label}
      </a>
    {/foreach}
  </div>
</div>
