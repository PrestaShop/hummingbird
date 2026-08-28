{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}

<div class="brands-sort dropdown">
  <button
    class="btn btn-outline-tertiary dropdown-toggle"
    rel="nofollow"
    data-bs-toggle="dropdown"
  >
    {l s='All brands' d='Shop.Theme.Catalog'}
  </button>
  <div class="dropdown-menu dropdown-menu-start">
    {foreach from=$brands item=brand}
      <a
        rel="nofollow"
        href="{$brand['link']}"
        class="dropdown-item"
      >
        {$brand['name']}
      </a>
    {/foreach}
  </div>
</div>
