{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$componentName = 'pagination'}

<nav class="{$componentName}-container row">
  <div class="{$componentName}-number text-center text-lg-start col-lg-4">
    {block name='pagination_summary'}
      {l s='Showing %from%-%to% of %total% item(s)' d='Shop.Theme.Catalog' sprintf=['%from%' => $pagination.items_shown_from ,'%to%' => $pagination.items_shown_to, '%total%' => $pagination.total_items]}
    {/block}
  </div>

  <div class="{$componentName}-list-container d-flex justify-content-center justify-content-lg-end col-lg-8">
    {block name='pagination_page_list'}
      <nav aria-label="{l s='Products pagination' d='Shop.Theme.Catalog'}">
        {if $pagination.should_be_displayed}
          <ul class="pagination pagination--custom">
            {foreach from=$pagination.pages item="page" name="paginationLoop"}
              {if $page@iteration === 1}
                <li class="page-item">
                  <a rel="prev" href="{$page.url}"
                    class="page-link btn-with-icon previous {['disabled' => !$page.clickable, 'js-pager-link' => true]|classnames}">
                    <i class="material-icons rtl-flip" aria-hidden="true">&#xE314;</i>
                    <span class="d-none d-xl-flex">{l s='Previous' d='Shop.Theme.Actions'}</span>
                  </a>
                </li>
                
                {if $page.type === 'previous'}
                  {continue}
                {/if}
              {/if}

              {if $page.type === 'spacer'}
                <li class="page-item disabled">
                  <span class="page-link">&hellip;</span>
                </li>
              {else if $page.type != "prev" && $page.type != "next"}
                <li class="page-item{if $page.current} active{/if}" {if $page.current}aria-current="page" {/if}>
                  <a rel="nofollow" href="{$page.url}"
                    class="page-link btn-with-icon {['disabled' => !$page.clickable, 'js-pager-link' => true]|classnames}">
                    {$page.page}
                  </a>
                </li>
              {/if}

              {if $smarty.foreach.paginationLoop.last}
                <li class="page-item">
                  <a rel="next" href="{$page.url}"
                    class="page-link btn-with-icon next {['disabled' => !$page.clickable, 'js-pager-link' => true]|classnames}">
                    <span class="d-none d-xl-flex">{l s='Next' d='Shop.Theme.Actions'}</span>
                    <i class="material-icons rtl-flip" aria-hidden="true">&#xE315;</i>
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
