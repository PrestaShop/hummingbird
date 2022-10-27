{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<ul>
  {foreach from=$brands item=brand name=brand_list}
    {if $smarty.foreach.brand_list.iteration <= $text_list_nb}
      <li class="facet-label">
        <a href="{$brand['link']}" title="{$brand['name']}">
          {$brand['name']}
        </a>
      </li>
    {/if}
  {/foreach}
</ul>
