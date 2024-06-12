{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{$componentName = 'category-tree'}

{function name="categories" nodes=[] depth=0}
  {strip}
    {if $nodes|count}
      <ul class="{$componentName}__list" data-depth="{$depth|escape:'htmlall':'UTF-8'}">
        {foreach from=$nodes item=node name="categories"}
          <li class="{$componentName}__item {if $node.children}accordion-item{/if}">
            <div class="{$componentName}__item__header nosplit {if $node.children} split parent{/if}">
              <a class="{$componentName}__item__link" href="{$node.link|escape:'htmlall':'UTF-8'}">{$node.name|escape:'htmlall':'UTF-8'}</a>
              {if $node.children}
                <div class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#category-tree-{$node.id|escape:'htmlall':'UTF-8'}"></div>
              {/if}
            </div>
            {if $node.children}
              <div class="accordion-collapse collapse" id="category-tree-{$node.id|escape:'htmlall':'UTF-8'}">
                <div class="accordion-body">
                  {categories nodes=$node.children depth=$depth+1}
                </div>
              </div>
            {/if}
          </li>
        {/foreach}
      </ul>
    {/if}
  {/strip}
{/function}

{if !empty($categories.children)}
  <div class="ps_categorytree {$componentName} left-block">
    <div class="left-block__title">
      <a class="left-block__title__link" href="{$categories.link nofilter}">{$categories.name|escape:'htmlall':'UTF-8'}</a>
    </div>

    <ul class="accordion accordion-flush accordion--small accordion--category">
      {if !empty($categories.children)}
        <li class="{$componentName}__child">{categories nodes=$categories.children}</li>
      {/if}
    </ul>
  </div>
{/if}
