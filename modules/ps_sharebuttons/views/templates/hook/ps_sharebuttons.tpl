{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{block name='social_sharing'}
  {if $social_share_links}
    <div class="ps-sharebuttons">
      <span class="ps-sharebuttons__label">{l s='Share' d='Shop.Theme.Actions'}</span>
      <ul class="ps-sharebuttons__list">
        {foreach from=$social_share_links item='social_share_link'}
          <li class="{$social_share_link.class}">
            <a href="{$social_share_link.url}" class="ps-sharebuttons__link" target="_blank" rel="noopener noreferrer"
              {if $social_share_link.class}
                aria-label="{l s='Share on %social_share_link_label%' sprintf=['%social_share_link_label%' => $social_share_link.class] d='Shop.Theme.Actions'}"
              {/if}
            >
              <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" viewBox="0 0 16 16">
                {if $social_share_link.class == 'facebook'}
                  <path d="M16 8.049c0-4.446-3.582-8.05-8-8.05C3.58 0-.002 3.603-.002 8.05c0 4.017 2.926 7.347 6.75 7.951v-5.625h-2.03V8.05H6.75V6.275c0-2.017 1.195-3.131 3.022-3.131.876 0 1.791.157 1.791.157v1.98h-1.009c-.993 0-1.303.621-1.303 1.258v1.51h2.218l-.354 2.326H9.25V16c3.824-.604 6.75-3.934 6.75-7.951"/>
                {elseif $social_share_link.class == 'twitter'}
                  <path d="M12.6.75h2.454l-5.36 6.142L16 15.25h-4.937l-3.867-5.07-4.425 5.07H.316l5.733-6.57L0 .75h5.063l3.495 4.633L12.601.75Zm-.86 13.028h1.36L4.323 2.145H2.865z"/>
                {elseif $social_share_link.class == 'pinterest'}
                  <path d="M8 0a8 8 0 0 0-2.915 15.452c-.07-.633-.134-1.606.027-2.297.146-.625.938-3.977.938-3.977s-.239-.479-.239-1.187c0-1.113.645-1.943 1.448-1.943.682 0 1.012.512 1.012 1.127 0 .686-.437 1.712-.663 2.663-.188.796.4 1.446 1.185 1.446 1.422 0 2.515-1.5 2.515-3.664 0-1.915-1.377-3.254-3.342-3.254-2.276 0-3.612 1.707-3.612 3.471 0 .688.265 1.425.595 1.826a.24.24 0 0 1 .056.23c-.061.252-.196.796-.222.907-.035.146-.116.177-.268.107-1-.465-1.624-1.926-1.624-3.1 0-2.523 1.834-4.84 5.286-4.84 2.775 0 4.932 1.977 4.932 4.62 0 2.757-1.739 4.976-4.151 4.976-.811 0-1.573-.421-1.834-.919l-.498 1.902c-.181.695-.669 1.566-.995 2.097A8 8 0 1 0 8 0"/>
                {/if}
              </svg>
            </a>
          </li>
        {/foreach}
      </ul>
    </div>
  {/if}
{/block}
