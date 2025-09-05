{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{block name='brand_miniature_item'}
  <li class="brand">
    <div class="brand__image">
      <picture>
        {if !empty($brand.image.bySize.small_default.sources.avif)}<source srcset="{$brand.image.bySize.small_default.sources.avif}" type="image/avif">{/if}
        {if !empty($brand.image.bySize.small_default.sources.webp)}<source srcset="{$brand.image.bySize.small_default.sources.webp}" type="image/webp">{/if}
        <img
          class="brand__img img-fluid"
          src="{$brand.image.bySize.small_default.url}"
          alt="{if !empty($brand.image.legend)}{$brand.image.legend}{else}{$brand.name}{/if}"
          width="{$brand.image.bySize.small_default.width}"
          height="{$brand.image.bySize.small_default.height}"
          loading="lazy"
        >
      </picture>
    </div>

    <div class="brand__infos">
      <a class="brand__title stretched-link" href="{$brand.url}">
        {$brand.name}
      </a>
    </div>

    <p class="brand__products">
      {if $brand.nb_products > 1}
        {l s='%number% products' sprintf=['%number%' => $brand.nb_products] d='Shop.Theme.Catalog'}
      {elseif $brand.nb_products == 1}
        {l s='%number% product' sprintf=['%number%' => $brand.nb_products] d='Shop.Theme.Catalog'}
      {else}
        {l s='No products' d='Shop.Theme.Catalog'}
      {/if}
    </p>
  </li>
{/block}
