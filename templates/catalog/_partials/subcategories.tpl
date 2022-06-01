{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$componentName = 'subcategories'}

{if !empty($subcategories)}
  {if (isset($display_subcategories) && $display_subcategories eq 1) || !isset($display_subcategories) }
    <div id="subcategories" class="{$componentName} row gx-3">
      {foreach from=$subcategories item=subcategory}
        <div class="subcategory__wrapper col-6 col-lg-4 col-xl-3"> 
          <a class="subcategory" href="{$link->getCategoryLink($subcategory.id_category, $subcategory.link_rewrite)|escape:'html':'UTF-8'}" title="{$subcategory.name|escape:'html':'UTF-8'}">
            <div class="subcategory__image">
              {if !empty($subcategory.image.large.url)}
                <img class="img-fluid" src="{$subcategory.image.large.url}" alt="{$subcategory.name|escape:'html':'UTF-8'}" loading="lazy" width="{$subcategory.image.large.width}" height="{$subcategory.image.large.height}" />
              {/if}
            </div>
            <p class="subcategory__name">{$subcategory.name|escape:'html':'UTF-8'}</p>
          </a>
        </div>
      {/foreach}
    </div>
  {/if}
{/if}
