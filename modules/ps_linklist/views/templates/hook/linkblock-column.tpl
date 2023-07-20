{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{foreach $linkBlocks as $linkBlock}
  <div class="left-block">

    <p class="left-block__title">{$linkBlock.title}</p>

    <ul id="left-block__{$linkBlock.id}" class="left-block__content left-block__content--list">
      {foreach $linkBlock.links as $link}
        <li>
          <a
              id="{$link.id}-{$linkBlock.id}"
              class="left-block__link {$link.class}"
              href="{$link.url}"
              title="{$link.description}"
              {if !empty($link.target)} target="{$link.target}" {/if}
          >
            {$link.title}
          </a>
        </li>
      {/foreach}
    </ul>
  </div>
{/foreach}
