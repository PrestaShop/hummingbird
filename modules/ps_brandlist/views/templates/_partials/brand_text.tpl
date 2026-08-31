{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
<ul class="left-block__content left-block__content--list">
  {foreach from=$brands item=brand name=brand_list}
    {if $smarty.foreach.brand_list.iteration <= $text_list_nb}
      <li class="facet-label">
        <a class="left-block__link" href="{$brand['link']}" title="{$brand['name']}">
          {$brand['name']}
        </a>
      </li>
    {/if}
  {/foreach}
</ul>
