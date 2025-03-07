{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{if !empty($linkBlocks)}
  {foreach $linkBlocks as $linkBlock}
    <div class="ps-linklist footer-block col-md-6 col-lg-3">
      <p class="footer-block__title footer-block__title--toggle">
        {$linkBlock.title}
        <span class="stretched-link collapsed d-md-none" role="button" aria-expanded="true"
          data-bs-target="#footer_linklist_{$linkBlock.id}" data-bs-toggle="collapse">
          <i class="material-icons" aria-hidden="true">&#xE313;</i>
        </span>
      </p>
  
      <div class="footer-block__content collapse" id="footer_linklist_{$linkBlock.id}">
        <ul class="footer-block__list">
          {foreach $linkBlock.links as $link}
            <li>
              <a id="{$link.id}-{$linkBlock.id}" class="{$link.class}" href="{$link.url}" title="{$link.description}" {if !empty($link.target)} target="{$link.target}" {/if}>
                {$link.title}
              </a>
            </li>
          {/foreach}
        </ul>
      </div>
    </div>
  {/foreach}  
{/if}
