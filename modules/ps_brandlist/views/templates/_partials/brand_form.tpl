{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<div class="brands-sort dropdown">
  <button
    class="btn-unstyle select-title"
    rel="nofollow"
    data-bs-toggle="dropdown"
    aria-haspopup="true"
    aria-expanded="false">
    {l s='All brands' d='Shop.Theme.Catalog'}
    <i class="material-icons float-end" aria-hidden="true">arrow_drop_down</i>
  </button>
  <div class="dropdown-menu dropdown-menu-start">
    {foreach from=$brands item=brand}
      <a
        rel="nofollow"
        href="{$brand['link']}"
        class="dropdown-item select-list js-search-link"
     >
        {$brand['name']}
      </a>
    {/foreach}
  </div>
</div>
