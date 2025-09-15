{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{$componentName = 'category-tree'}

{function name="categories" nodes=[] depth=0}
  {strip}
    {if $nodes|count}
      <ul class="{$componentName}__list" role="tree" data-depth="{$depth|escape:'htmlall':'UTF-8'}">
        {foreach from=$nodes item=node name="categories"}
          <li class="{$componentName}__item {if $node.children}accordion-item{/if}">
            <div class="{$componentName}__item-header nosplit {if $node.children} split parent{/if}">
              <a class="{$componentName}__item-link" href="{$node.link|escape:'htmlall':'UTF-8'}">
                {$node.name|escape:'htmlall':'UTF-8'}
              </a>

              {if $node.children}
                <button
                  class="accordion-button collapsed"
                  type="button"
                  data-bs-toggle="collapse"
                  data-bs-target="#category-tree-{$node.id|escape:'htmlall':'UTF-8'}"
                  aria-expanded="false"
                  aria-controls="category-tree-{$node.id|escape:'htmlall':'UTF-8'}"
                  aria-label="{l s='Subcategories for %s' sprintf=[$node.name] d='Shop.Theme.Catalog'}"
                >
                </button>
              {/if}
            </div>

            {if $node.children}
              <div
                class="accordion-collapse collapse"
                id="category-tree-{$node.id|escape:'htmlall':'UTF-8'}"
              >
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
  <div class="ps-categorytree {$componentName} left-block">
    <p class="left-block__title">
      <a class="left-block__title-link" href="{$categories.link nofilter}">
        {$categories.name|escape:'htmlall':'UTF-8'}
      </a>
    </p>

    <div class="accordion accordion-flush accordion--category">
      <nav aria-label="{l s='Categories' d='Shop.Theme.Catalog'}">
        {if !empty($categories.children)}
          <div class="{$componentName}__child">
            {categories nodes=$categories.children}
          </div>
        {/if}
      </nav>
    </div>
  </div>
{/if}
