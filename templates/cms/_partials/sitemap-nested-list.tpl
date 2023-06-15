{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{block name='sitemap_item'}
  <ul {if !empty($is_nested)}class="nested"{/if}>
    {foreach $links as $link}
      <li>
        <a id="{$link.id}" href="{$link.url}" title="{$link.label}">
          {$link.label}
        </a>

        {if !empty($link.children)}
          {include file='cms/_partials/sitemap-nested-list.tpl' links=$link.children is_nested=true}
        {/if}
      </li>
    {/foreach}
  </ul>
{/block}
