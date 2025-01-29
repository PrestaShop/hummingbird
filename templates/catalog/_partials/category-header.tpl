{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<div id="js-product-list-header">
    {if $listing.pagination.items_shown_from == 1}
        <div class="block-category">
          {include file='components/page-title-section.tpl' title={$category.name}}
            {if $category.description}
              <div id="category-description" class="rich-text mb-4">{$category.description nofilter}</div>
            {/if}
            {if !empty($category.cover.large.url)}
              <div class="category-cover mb-4">
                <img src="{$category.cover.large.url}" 
                  alt="{if !empty($category.cover.legend)}{$category.cover.legend}{else}{$category.name}{/if}" 
                  fetchpriority="high" 
                  class="img-fluid"
                  width="{$category.cover.large.width}" 
                  height="{$category.cover.large.height}">
              </div>
            {/if}
        </div>
    {/if}
    {if isset($subcategories) && $subcategories|@count> 0}
      {include file='catalog/_partials/subcategories.tpl' subcategories=$subcategories}
    {/if}
</div>
