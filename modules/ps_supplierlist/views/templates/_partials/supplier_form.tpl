{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}

<div class="suppliers-sort dropdown">
  <button
    class="btn btn-outline-tertiary dropdown-toggle"
    rel="nofollow"
    data-bs-toggle="dropdown"
    aria-expanded="false"
  >
    {l s='All suppliers' d='Shop.Theme.Catalog'}
  </button>
  <div class="dropdown-menu dropdown-menu-start">
    {foreach from=$suppliers item=supplier}
      <a
        rel="nofollow"
        href="{$supplier['link']}"
        class="dropdown-item"
      >
        {$supplier['name']}
      </a>
    {/foreach}
  </div>
</div>
