{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{foreach from=$variants item=variant}
  <a href="{$variant.url}"
    class="{$variant.type}"
    title="{$variant.name}"
    aria-label="{$variant.name} - {$product.name}"
    {if $variant.texture}style="background-image: url({$variant.texture})"{/if}
    {if $variant.html_color_code}style="background-color: {$variant.html_color_code}"{/if}
  ></a>
{/foreach}
