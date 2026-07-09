{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
{extends file=$layout}

{block name='content'}
  {block name='brand_header'}
    {include file='components/page-title-section.tpl' title={l s='Brands' d='Shop.Theme.Catalog'}}
  {/block}

  {block name='brand_miniature'}
    {**
     * Determine if at least one brand has an image.
     * If so, render every miniature with an image slot (real image or placeholder),
     * so the list stays visually consistent. Otherwise, render no image at all.
     *}
    {assign var=displayBrandImages value=false}
    {if !empty($brands)}
      {foreach $brands as $brand}
        {if !empty($brand.image.bySize.small_default.url)}
          {assign var=displayBrandImages value=true}
          {break}
        {/if}
      {/foreach}
    {/if}

    <ul class="brand__list">
      {foreach from=$brands item=brand}
        {include file='catalog/_partials/miniatures/brand.tpl' brand=$brand displayImages=$displayBrandImages}
      {/foreach}
    </ul>
  {/block}
{/block}
