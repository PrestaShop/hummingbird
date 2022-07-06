{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{$componentName = 'category-tree'}

{function name="categories" nodes=[] depth=0}
  {strip}
    {if $nodes|count}
      <ul class="{$componentName}-list">
        {foreach from=$nodes item=node name="categories"}
          <li class="{$componentName}-item" data-depth="{$depth}">
            {if $depth===0}
              {if $node.children}
                <div class="d-flex align-items-center justify-content-space-between">
              {/if}
              <a class="{$componentName}-item-link" href="{$node.link}">{$node.name}</a>
              {if $node.children}
                  <div class="accordion-button px-0 collapsed" data-bs-toggle="collapse" data-bs-target="#exCollapsingNavbar{$node.id}">
                  </div>
                </div>
                <div class="collapse py-2" id="exCollapsingNavbar{$node.id}">
                  {categories nodes=$node.children depth=$depth+1}
                </div>
              {else}
              {/if}
            {else}
              {if $node.children}
                <div class="d-flex align-items-center justify-content-space-between">
              {/if}
              <a class="{$componentName}-child-link" href="{$node.link}">{$node.name}</a>
              {if $node.children}
                  <div class="accordion-button px-0 collapsed" data-bs-toggle="collapse" data-bs-target="#exCollapsingNavbar{$node.id}">
                  </div>
                </div>
                <div class="collapse pt-1 pb-2" id="exCollapsingNavbar{$node.id}">
                  {categories nodes=$node.children depth=$depth+1}
                </div>
              {/if}
            {/if}
            {if !$smarty.foreach.categories.last}<hr class="my-0">{/if}
          </li>
        {/foreach}
      </ul>
    {/if}
  {/strip}
{/function}

<div class="{$componentName}">
  <ul class="{$componentName}-list list-group">
    <li class="{$componentName}-title list-group-item"><a class="{$componentName}-title-link" href="{$categories.link nofilter}">{$categories.name}</a></li>
    {if !empty($categories.children)}
      <li class="{$componentName}-child list-group-item">{categories nodes=$categories.children}</li>
    {/if}
  </ul>
</div>
