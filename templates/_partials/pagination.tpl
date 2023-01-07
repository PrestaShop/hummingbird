{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$componentName = 'pagination'}

<nav class="{$componentName}-container row">
  <div class="{$componentName}-number col-md-4">
    {block name='pagination_summary'}
      {l s='Showing %from%-%to% of %total% item(s)' d='Shop.Theme.Catalog' sprintf=['%from%' => $pagination.items_shown_from ,'%to%' => $pagination.items_shown_to, '%total%' => $pagination.total_items]}
    {/block}
  </div>

  <div class="{$componentName}-list-container col-md-6 offset-md-2 pr-0">
    {block name='pagination_page_list'}
      <nav aria-label="{l s='Products pagination' d='Shop.Theme.Catalog'}">
        {if $pagination.should_be_displayed}
          <ul class="pagination">
            {foreach from=$pagination.pages item="page"}
              {if $page.type === 'spacer'}
                <li class="page-item disabled">
                  <span class="page-link">&hellip;</span>
                </li>
              {else}
                <li class="page-item{if $page.current} active{/if}" {if $page.current}aria-current="page" {/if}>
                  <a rel="{if $page.type === 'previous'}prev{elseif $page.type === 'next'}next{else}nofollow{/if}"
                    href="{$page.url}"
                    class="page-link btn-with-icon {if $page.type === 'previous'}previous {elseif $page.type === 'next'}next {/if}{['disabled' => !$page.clickable, 'js-search-link' => true]|classnames}">
                    {if $page.type === 'previous'}
                      <i class="material-icons rtl-flip">&#xE314;</i>
                      <span class="d-none d-md-flex">{l s='Previous' d='Shop.Theme.Actions'}</span>
                    {elseif $page.type === 'next'}
                      <span class="d-none d-md-flex">{l s='Next' d='Shop.Theme.Actions'}</span>
                      <i class="material-icons rtl-flip">&#xE315;</i>
                    {else}
                      {$page.page}
                    {/if}
                  </a>
                </li>
              {/if}
            {/foreach}
          </ul>
        {/if}
      </nav>
    {/block}
  </div>

</nav>
