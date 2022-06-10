{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{block name='block_social'}
  {if !empty($social_links)}
    <div class="block-social">
      <ul>
        {foreach from=$social_links item='social_link'}
          <li class="{$social_link.class}"><a href="{$social_link.url}" target="_blank"
              rel="noopener noreferrer">{$social_link.label}</a></li>
        {/foreach}
      </ul>
    </div>
  {/if}
{/block}
