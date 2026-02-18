{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<label for="sort_dropdown_button" class="products__sort-label">
  {l s='Sort by:' d='Shop.Theme.Global'}
</label>

<div class="products__sort-dropdown">
  <button
    class="products__sort-dropdown-button btn btn-outline-tertiary dropdown-toggle"
    id="sort_dropdown_button"
    rel="nofollow"
    data-bs-toggle="dropdown"
    aria-haspopup="true"
    aria-expanded="false"
    aria-label="{l s='Change sort order' d='Shop.Theme.Global'}">
    {if $listing.sort_selected}{$listing.sort_selected}{else}{l s='Choose' d='Shop.Theme.Actions'}{/if}
  </button>

  <div class="dropdown-menu" role="menu" aria-labelledby="sort_dropdown_button">
    {foreach from=$listing.sort_orders item=sort_order}
      <a
        rel="nofollow"
        href="{$sort_order.url}"
        aria-label="{l s='Sort products by: %sort_order%' sprintf=['%sort_order%' => $sort_order.label] d='Shop.Theme.Global'}"
        role="menuitem"
        {if $sort_order.current}aria-current="true"{/if}
        class="dropdown-item {['current' => $sort_order.current, 'js-search-link' => true]|classnames}"
      >
        {$sort_order.label}
      </a>
    {/foreach}
  </div>
</div>
