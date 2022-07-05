{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<a class="banner" href="{$banner_link}" title="{$banner_desc}">
  {if isset($banner_img)}
    <img src="{$banner_img}" alt="{$banner_desc}" title="{$banner_desc}" class="img-fluid w-100" loading="lazy" width="1110" height="213">
  {else}
    <span>{$banner_desc}</span>
  {/if}
</a>
