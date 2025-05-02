{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$componentName = 'subcategory'}

{if !empty($subcategories)}
  <div class="{$componentName}">
    {if (isset($display_subcategories) && $display_subcategories eq 1) || !isset($display_subcategories) }
      <div class="{$componentName}__list">
        {foreach from=$subcategories item=subcategory}
          <a class="{$componentName}__link" href="{$subcategory.url}" title="{$subcategory.name|escape:'html':'UTF-8'}">
            <span class="{$componentName}__name">{$subcategory.name|escape:'html':'UTF-8'}</span>
          </a>
        {/foreach}
      </div>
    {/if}
  </div>
{/if}
