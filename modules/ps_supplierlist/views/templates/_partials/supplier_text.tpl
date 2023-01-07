{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$componentName = 'search-filters-modules'}

<ul class="{$componentName}__list">
  {foreach from=$suppliers item=supplier name=supplier_list}
    {if $smarty.foreach.supplier_list.iteration <= $text_list_nb}
      <li class="{$componentName}__item facet-label">
        <a class="{$componentName}__item__link" href="{$supplier['link']}" title="{$supplier['name']}">
          {$supplier['name']}
        </a>
      </li>
    {/if}
  {/foreach}
</ul>
