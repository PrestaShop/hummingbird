{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{if !empty($linkBlocks)}
  {foreach $linkBlocks as $linkBlock}
    <nav
      class="ps-linklist footer-block col-md-6 col-lg-3"
      aria-labelledby="footer_title_{$linkBlock.id}"
    >
      <p
        id="footer_title_{$linkBlock.id}"
        class="footer-block__title footer-block__title--toggle"
      >
        {$linkBlock.title}
        <button
          class="stretched-link collapsed d-md-none"
          type="button"
          aria-expanded="false"
          aria-controls="footer_linklist_{$linkBlock.id}"
          data-bs-target="#footer_linklist_{$linkBlock.id}"
          data-bs-toggle="collapse"
        >
          <span class="visually-hidden">
            {l s='Toggle %s links' sprintf=[$linkBlock.title|lower] d='Shop.Theme.Global'}
          </span>
          <i class="material-icons" aria-hidden="true">&#xE313;</i>
        </button>
      </p>

      <div class="footer-block__content collapse" id="footer_linklist_{$linkBlock.id}">
        <ul class="footer-block__list">
          {foreach $linkBlock.links as $link}
            <li>
              <a
                id="{$link.id}-{$linkBlock.id}"
                class="{$link.class}"
                href="{$link.url}"
                {if !empty($link.target)} target="{$link.target}" {/if}
                {if !empty($link.description)} aria-describedby="desc-{$link.id}-{$linkBlock.id}" {/if}
              >
                {$link.title}
              </a>
              {if !empty($link.description)}
                <span id="desc-{$link.id}-{$linkBlock.id}" class="visually-hidden">
                  {$link.description}
                </span>
              {/if}
            </li>
          {/foreach}
        </ul>
      </div>
    </nav>
  {/foreach}
{/if}
