{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<ul>
  {foreach from=$suppliers item=supplier name=supplier_list}
    {if $smarty.foreach.supplier_list.iteration <= $text_list_nb}
      <li class="facet-label">
        <a href="{$supplier['link']}" title="{$supplier['name']}">
          {$supplier['name']}
        </a>
      </li>
    {/if}
  {/foreach}
</ul>
