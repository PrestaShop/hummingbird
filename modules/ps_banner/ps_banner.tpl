{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<a class="banner d-block text-center" href="{$banner_link}" title="{$banner_desc}">
  {if isset($banner_img)}
    <img
      src="{$banner_img}"
      alt="{$banner_desc}"
      title="{$banner_desc}"
      class="img-fluid"
      loading="lazy"
      {if !empty($banner_width)}
        width="{$banner_width}"
      {/if}
      {if !empty($banner_height)}
        height="{$banner_height}"
      {/if}
      >
  {else}
    <span>{$banner_desc}</span>
  {/if}
</a>
