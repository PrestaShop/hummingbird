{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
{**
 * Builds a srcset value out of the image sizes that actually exist.
 *
 * An image type declared in theme.yml only reaches `bySize` once the shop has a row for it in
 * ps_image_type. A shop that was upgraded rather than freshly installed can be missing one the theme
 * asks for, because a theme's image types are applied when the theme is installed and not again
 * afterwards. Naming the type unconditionally then emitted a candidate with a descriptor and no URL,
 * such as " 216w" or " 2x", which is not a valid srcset candidate and which the browser resolves as a
 * relative URL - hence requests for /216w. It also raised "Undefined array key" warnings on every
 * image.
 *
 * Every lookup here goes through isset() rather than a |default modifier, because the modifier runs
 * after PHP has already evaluated the missing offset and warned.
 *
 * The front office runs with $smarty->escape_html = true, so each URL printed below is already
 * escaped. Callers therefore capture this output and print it with nofilter - escaping it a second
 * time would turn an & in a URL into &amp;amp;.
 *
 * @param array  $image         image array holding a bySize map, e.g. $product.cover
 * @param array  $sizes         image type name => descriptor, in order. The descriptor is emitted
 *                              verbatim after the URL, so use '216w' for a width candidate, '2x' for
 *                              a density one, or '' for the default candidate that carries none.
 * @param string $srcsetVariant 'url' (default), 'avif' or 'webp'
 *}
{assign var='srcsetSeparator' value=''}
{strip}
{foreach $sizes as $srcsetType => $srcsetDescriptor}
  {assign var='srcsetUrl' value=''}
  {if ($srcsetVariant|default:'url') === 'avif'}
    {if isset($image.bySize.$srcsetType.sources.avif)}
      {assign var='srcsetUrl' value=$image.bySize.$srcsetType.sources.avif}
    {/if}
  {elseif ($srcsetVariant|default:'url') === 'webp'}
    {if isset($image.bySize.$srcsetType.sources.webp)}
      {assign var='srcsetUrl' value=$image.bySize.$srcsetType.sources.webp}
    {/if}
  {else}
    {if isset($image.bySize.$srcsetType.url)}
      {assign var='srcsetUrl' value=$image.bySize.$srcsetType.url}
    {/if}
  {/if}
  {if $srcsetUrl}{$srcsetSeparator}{$srcsetUrl}{if $srcsetDescriptor} {$srcsetDescriptor}{/if}{assign var='srcsetSeparator' value=', '}{/if}
{/foreach}
{/strip}
