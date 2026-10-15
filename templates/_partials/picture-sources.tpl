{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
{*
  The <source> elements of a <picture>, one per next-gen format the shop provides.

  Parameters:
    srcset  the array returned by the `srcset` modifier
    sizes   optional, the sizes attribute when the srcset uses width descriptors

  {$srcset = $product.cover|srcset:$imageTypes}
  <picture>
    {include file='_partials/picture-sources.tpl' srcset=$srcset sizes='(min-width: 992px) 50vw, 100vw'}
    <img srcset="{$srcset.url}" src="{$srcset.src}" width="{$srcset.width}" height="{$srcset.height}" ...>
  </picture>
*}
{foreach ['avif', 'webp'] as $format}
  {if $srcset.$format}
    <source
      srcset="{$srcset.$format}"
      {if !empty($sizes)}sizes="{$sizes}"{/if}
      type="image/{$format}"
    >
  {/if}
{/foreach}
