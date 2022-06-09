{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{block name='block_social'}
  {if !empty($social_links)}
    <div class="block-social">
      <div class="container">
        <div class="row">
          <div class="col-12 d-flex justify-content-center">
            <ul>
              {foreach from=$social_links item='social_link'}
                <li class="{$social_link.class}"><a href="{$social_link.url}" target="_blank"
                    rel="noopener noreferrer">{$social_link.label}</a></li>
              {/foreach}
            </ul>
          </div>
        </div>
      </div>
    </div>
  {/if}
{/block}
