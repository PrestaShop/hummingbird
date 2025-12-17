{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$componentName = 'pagination'}

<nav class="{$componentName}__container">
  <div class="{$componentName}__number">
    {block name='pagination_summary'}
      {l s='Showing %from%-%to% of %total% item(s)' d='Shop.Theme.Catalog' sprintf=['%from%' => $pagination.items_shown_from ,'%to%' => $pagination.items_shown_to, '%total%' => $pagination.total_items]}
    {/block}
  </div>

  <div class="{$componentName}__nav">
    {block name='pagination_page_list'}
      <nav aria-label="{l s='Products pagination' d='Shop.Theme.Catalog'}">
        {if $pagination.should_be_displayed}
          <ul class="{$componentName}">
            {foreach from=$pagination.pages item="page" name="paginationLoop"}
              {if $page@iteration === 1}
                <li class="page-item">
                  <button data-ps-data="{$page.url}"
                    class="page-link previous {['disabled' => !$page.clickable, 'js-pager-link' => $page.clickable]|classnames}"
                    {if !$page.clickable}aria-disabled="true" disabled{/if}
                    aria-label="{l s='Go to previous page' d='Shop.Theme.Actions'}"
                  >
                    <i class="material-icons rtl-flip" aria-hidden="true">&#xE314;</i>
                    <span class="d-none d-xl-flex">{l s='Previous' d='Shop.Theme.Actions'}</span>
                  </button>
                </li>
                
                {if $page.type === 'previous'}
                  {continue}
                {/if}
              {/if}

              {if $page.type === 'spacer'}
                <li class="page-item disabled">
                  <span class="page-link" aria-hidden="true">&hellip;</span>
                </li>
              {elseif $page.type != "prev" && $page.type != "next"}
                <li class="page-item{if $page.current} active{/if}">
                  <button data-ps-data="{$page.url}"
                    class="page-link {['js-pager-link' => $page.clickable]|classnames}"
                    {if !$page.clickable}aria-disabled="true"{/if}
                    {if $page.current}aria-current="page"{/if}
                    aria-label="{l s='Go to page %page%' sprintf=['%page%' => $page.page] d='Shop.Theme.Actions'}"
                  >
                    {$page.page}
                  </button>
                </li>
              {/if}

              {if $smarty.foreach.paginationLoop.last}
                <li class="page-item">
                  <button data-ps-data="{$page.url}"
                    class="page-link next {['disabled' => !$page.clickable, 'js-pager-link' => $page.clickable]|classnames}"
                    {if !$page.clickable}aria-disabled="true" disabled{/if}
                    aria-label="{l s='Go to next page' d='Shop.Theme.Actions'}"
                  >
                    <span class="d-none d-xl-flex">{l s='Next' d='Shop.Theme.Actions'}</span>
                    <i class="material-icons rtl-flip" aria-hidden="true">&#xE315;</i>
                  </button>
                </li>
              {/if}
            {/foreach}
          </ul>
        {/if}
      </nav>
    {/block}
  </div>
</nav>
