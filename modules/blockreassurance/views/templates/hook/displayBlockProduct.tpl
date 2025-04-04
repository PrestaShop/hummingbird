{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{if isset($blocks) && !empty($blocks)}
  <div class="blockreassurance blockreassurance--{$page.page_name}">
    {foreach from=$blocks item=$block key=$key}
      {if $block['type_link'] !== $LINK_TYPE_NONE && !empty($block['link'])}
        <a class="reassurance reassurance--link" href="{$block['link']|escape:'htmlall':'UTF-8'}">
      {else}
        <div class="reassurance">
      {/if}

        <span class="reassurance__image">
          {if $block['custom_icon']}
            <img {if $block['is_svg']}class="svg img-fluid invisible" {/if}src="{$block['custom_icon']}">
          {elseif $block['icon']}
            <img class="svg img-fluid invisible" src="{$block['icon']}">
          {/if}
        </span>

        <span class="reassurance__content">
          <span class="reassurance__title">{$block['title']|escape:'htmlall':'UTF-8'}</span>
          {if !empty($block['description'])}
            <br/>
            <small class="reassurance__desc">{$block['description'] nofilter}</small>
          {/if}
        </span>

      {if !empty($block['link']) && $block['type_link'] !== $LINK_TYPE_NONE}
        </a>
      {else}
        </div>
      {/if}
    {/foreach}
  </div>
{/if}
