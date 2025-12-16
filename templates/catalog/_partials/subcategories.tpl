{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$componentName = 'subcategory'}

{if !empty($subcategories)}
  {**
   * Determine if at least one subcategory has a thumbnail image.
   * If so, set 'displaySubcategoryImages' to true so the list will render with images.
   *}
  {assign var=displaySubcategoryImages value=false}
  {foreach $subcategories as $category}
    {if isset($category.thumbnail) && !empty($category.thumbnail)}
      {assign var=displaySubcategoryImages value=true}
      {break}
    {/if}
  {/foreach}

  <div class="{$componentName}">
    <div class="{$componentName}__list{if $displaySubcategoryImages} {$componentName}__list--with-images{/if}">
      {foreach from=$subcategories item=subcategory}
        <a class="{$componentName}__link{if $displaySubcategoryImages} {$componentName}__link--with-image{/if}" href="{$subcategory.url}" title="{$subcategory.name|escape:'html':'UTF-8'}">
          {if $displaySubcategoryImages}
            {if isset($subcategory.thumbnail.bySize.category_default.url) && !empty($subcategory.thumbnail.bySize.category_default.url)}
              <img
                class="{$componentName}__thumbnail img-fluid"
                src="{$subcategory.thumbnail.bySize.category_default.url}"
                width="{$subcategory.thumbnail.bySize.category_default.width}"
                height="{$subcategory.thumbnail.bySize.category_default.height}"
                alt="{$subcategory.name|escape:'html':'UTF-8'}"
                loading="lazy"
              >
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
    </div>
  </div>
{/if}
