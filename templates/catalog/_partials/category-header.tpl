{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<div id="js-product-list-header">
  {if $listing.pagination.items_shown_from == 1}
    <div class="category__header">
      {include file='components/page-title-section.tpl' title=$category.name}

      {if $category.description}
        <div class="category__description rich-text">{$category.description nofilter}</div>
      {/if}

      {if !empty($category.cover.bySize.category_cover.url)}
        <div class="category__cover">
          <picture>
            {if isset($category.cover.bySize.category_cover.sources.avif)}
              <source srcset="{$category.cover.bySize.category_cover.sources.avif}" type="image/avif">
            {/if}

            {if isset($category.cover.bySize.category_cover.sources.webp)}
              <source srcset="{$category.cover.bySize.category_cover.sources.webp}" type="image/webp">
            {/if}

            <img
              class="category__cover-image img-fluid"
              src="{$category.cover.bySize.category_cover.url}"
              width="{$category.cover.bySize.category_cover.width}"
              height="{$category.cover.bySize.category_cover.height}"
              alt="{if !empty($category.cover.legend)}{$category.cover.legend}{else}{$category.name}{/if}"
              fetchpriority="high"
            >
          </picture>
        </div>
      {/if}

      {if isset($subcategories) && $subcategories|@count > 0}
        {include file='catalog/_partials/subcategories.tpl' subcategories=$subcategories}
      {/if}
    </div>
  {/if}
</div>
