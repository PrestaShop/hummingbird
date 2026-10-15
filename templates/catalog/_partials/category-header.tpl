{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
{$imageTypes = ['category_cover' => '']}
<div id="js-product-list-header">
  {if $listing.pagination.items_shown_from == 1}
    <div class="category__header">
      {include file='components/page-title-section.tpl' title=$category.name}

      {if $category.description}
        <div class="category__description rich-text">{$category.description nofilter}</div>
      {/if}

      {if !empty($category.cover.bySize.category_cover.url)}
        <div class="category__cover">
          {$srcset = $category.cover|srcset:$imageTypes}
          <picture>
            {include file='_partials/picture-sources.tpl' srcset=$srcset}

            <img
              class="category__cover-image img-fluid"
              {if $srcset.src}
                src="{$srcset.src}"
                width="{$srcset.width}"
                height="{$srcset.height}"
              {/if}
              alt="{if !empty($category.cover.legend)}{$category.cover.legend}{else}{$category.name}{/if}"
              fetchpriority="high"
            >
          </picture>
        </div>
      {/if}

      {include file='catalog/_partials/subcategories.tpl' subcategories=$subcategories|default:[]}
    </div>
  {/if}
</div>
