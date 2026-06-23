{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
{$componentName = 'subcategory'}

{**
 * Determine if at least one subcategory has a thumbnail image.
 * If so, set 'displaySubcategoryImages' to true so the list will render with images.
 *}
{assign var=displaySubcategoryImages value=false}
{if !empty($subcategories)}
  {foreach $subcategories as $category}
    {if isset($category.thumbnail) && !empty($category.thumbnail)}
      {assign var=displaySubcategoryImages value=true}
      {break}
    {/if}
  {/foreach}
{/if}

{**
 * Get content of subcategory hook, so we display the list even if no native subcategories exist.
 * The module receives information about whether to display images or not, so it can render accordingly, if wanted.
 *}
{capture name="displaySubcategoriesContent"}{hook h='displaySubcategories' displaySubcategoryImages=$displaySubcategoryImages}{/capture}

{if !empty($subcategories) || !empty($smarty.capture.displaySubcategoriesContent)}
  <div class="{$componentName}">
    <div class="{$componentName}__list{if $displaySubcategoryImages} {$componentName}__list--with-images{/if}">

      {* Render a list of true subcategories from the core, with an image or not, depending on the pre-check before *}
      {if !empty($subcategories)}
        {foreach from=$subcategories item=subcategory}
          <a class="{$componentName}__link{if $displaySubcategoryImages} {$componentName}__link--with-image{/if}" href="{$subcategory.url}" title="{$subcategory.name|escape:'html':'UTF-8'}">
            {if $displaySubcategoryImages}
              {if isset($subcategory.thumbnail.bySize.category_default.url) && !empty($subcategory.thumbnail.bySize.category_default.url)}
                <picture>
                  {if isset($subcategory.thumbnail.bySize.category_default.sources.avif)}
                    <source srcset="{$subcategory.thumbnail.bySize.category_default.sources.avif}" type="image/avif">
                  {/if}
  
                  {if isset($subcategory.thumbnail.bySize.category_default.sources.webp)}
                    <source srcset="{$subcategory.thumbnail.bySize.category_default.sources.webp}" type="image/webp">
                  {/if}
  
                  <img
                    class="{$componentName}__thumbnail img-fluid"
                    src="{$subcategory.thumbnail.bySize.category_default.url}"
                    width="{$subcategory.thumbnail.bySize.category_default.width}"
                    height="{$subcategory.thumbnail.bySize.category_default.height}"
                    alt="{$subcategory.name|escape:'html':'UTF-8'}"
                    loading="lazy"
                  >
                </picture>
              {else}
                <img
                  class="{$componentName}__thumbnail img-fluid"
                  src="{$urls.no_picture_image.bySize.small_default.url}"
                  width="{$urls.no_picture_image.bySize.small_default.width}"
                  height="{$urls.no_picture_image.bySize.small_default.height}"
                  alt="{$subcategory.name|escape:'html':'UTF-8'}"
                  loading="lazy"
                >
              {/if}
            {/if}
  
            <span class="{$componentName}__name">{$subcategory.name|escape:'html':'UTF-8'}</span>
          </a>
        {/foreach}
      {/if}

      {* Render the content of displaySubcategories hook we got before *}
      {$smarty.capture.displaySubcategoriesContent nofilter}
    </div>
  </div>
{/if}
