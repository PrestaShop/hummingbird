{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{block name='block_social'}
  {if !empty($social_links)}
    <div class="block-social d-flex justify-content-center align-items-center p-4">
      {foreach from=$social_links item='social_link'}
        <a href="{$social_link.url}" class="{$social_link.class} mx-2 fs-5" target="_blank" rel="noopener noreferrer">
          <span class="fs-0">{$social_link.label}</span>
        </a>
      {/foreach}
    </div>
  {/if}
{/block}
