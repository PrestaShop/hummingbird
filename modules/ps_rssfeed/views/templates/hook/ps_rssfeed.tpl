{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<div class="block-contact col-md-2 links wrapper">
  <h3 class="h3 d-none d-sm-block d-md-block">{$title}</h3>
  <div>
    {if $rss_links}
      <ul>
        {foreach from=$rss_links item='rss_link'}
          <li><a href="{$rss_link['link']}" title="{$rss_link['title']}" target="_blank">{$rss_link['title']}</a></li>
        {/foreach}
      </ul>
    {else}
      <p>{l s='No RSS feed added' d='Shop.Theme.Catalog'}</p>
    {/if}
  </div>
</div>
