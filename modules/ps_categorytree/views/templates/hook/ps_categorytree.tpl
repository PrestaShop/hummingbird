{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{$componentName = 'category-tree'}

{function name="categories" nodes=[] depth=0}
  {strip}
    {if $nodes|count}
      <ul class="{$componentName}-list">
        {foreach from=$nodes item=node}
          <li class="{$componentName}-item" data-depth="{$depth}">
            {if $depth===0}
              <a class="{$componentName}-item-link" href="{$node.link}">{$node.name}</a>
              {if $node.children}
                <div class="navbar-toggler collapse-icons" data-bs-toggle="collapse" data-bs-target="#exCollapsingNavbar{$node.id}">
                  <i class="material-icons add">&#xE145;</i>
                  <i class="material-icons remove">&#xE15B;</i>
                </div>
                <div class="collapse" id="exCollapsingNavbar{$node.id}">
                  {categories nodes=$node.children depth=$depth+1}
                </div>
              {else}
              {/if}
            {else}
              <a class="{$componentName}-child-link" href="{$node.link}">{$node.name}</a>
              {if $node.children}
                <span class="arrows" data-bs-toggle="collapse" data-bs-target="#exCollapsingNavbar{$node.id}">
                  <i class="material-icons arrow-right">&#xE315;</i>
                  <i class="material-icons arrow-down">&#xE313;</i>
                </span>
                <div class="collapse" id="exCollapsingNavbar{$node.id}">
                  {categories nodes=$node.children depth=$depth+1}
                </div>
              {/if}
            {/if}
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
