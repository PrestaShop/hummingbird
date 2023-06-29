{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{if $elements}
  <div id="block-reassurance">
    <ul>
      {foreach from=$elements item=element}
        <li>
          <div class="block-reassurance-item">
            <img src="{$element.image}" alt="{$element.text}" loading="lazy">
            <span class="h6">{$element.text}</span>
          </div>
        </li>
      {/foreach}
    </ul>
  </div>
{/if}
