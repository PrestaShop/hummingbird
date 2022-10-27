{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{$componentName = 'category-tree'}

{function name="categories" nodes=[] depth=0}
  {strip}
    {if $nodes|count}
      <ul class="{$componentName}__list" data-depth="{$depth}">
        {foreach from=$nodes item=node name="categories"}
          <li class="{$componentName}__item">
            <div class="{$componentName}__item__header{if $node.children} {$componentName}__item__header--parent{/if}">
              <a class="{$componentName}__item__link" href="{$node.link}">{$node.name}</a>
              {if $node.children}
                <div class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#exCollapsingNavbar{$node.id}"></div>
              {/if}
            </div>
            {if $node.children}
              <div class="collapse" id="exCollapsingNavbar{$node.id}">
                {categories nodes=$node.children depth=$depth+1}
              </div>
            {/if}
          </li>
        {/foreach}
      </ul>
    {/if}
  {/strip}
{/function}

<div class="{$componentName}">
  <ul class="{$componentName}__list list-group">
    <li class="{$componentName}__title list-group-item"><a class="{$componentName}__title__link" href="{$categories.link nofilter}">{$categories.name}</a></li>
    {if !empty($categories.children)}
      <li class="{$componentName}__child list-group-item">{categories nodes=$categories.children}</li>
    {/if}
  </ul>
</div>
