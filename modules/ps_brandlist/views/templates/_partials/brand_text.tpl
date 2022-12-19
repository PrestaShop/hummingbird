{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$componentName = 'search-filters-modules'}

<ul class="{$componentName}__list">
  {foreach from=$brands item=brand name=brand_list}
    {if $smarty.foreach.brand_list.iteration <= $text_list_nb}
      <li class="{$componentName}__item facet-label">
        <a class="{$componentName}__item__link" href="{$brand['link']}" title="{$brand['name']}">
          {$brand['name']}
        </a>
      </li>
    {/if}
  {/foreach}
</ul>
