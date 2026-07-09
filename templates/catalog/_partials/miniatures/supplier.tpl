{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
{block name='supplier_miniature_item'}
  <li class="supplier">
    {if $displayImages|default:false}
      <div class="supplier__image">
        {if !empty($supplier.image.bySize.small_default.url)}
          <picture>
            {if !empty($supplier.image.bySize.small_default.sources.avif)}<source srcset="{$supplier.image.bySize.small_default.sources.avif}" type="image/avif">{/if}
            {if !empty($supplier.image.bySize.small_default.sources.webp)}<source srcset="{$supplier.image.bySize.small_default.sources.webp}" type="image/webp">{/if}
            <img
              class="supplier__img img-fluid"
              src="{$supplier.image.bySize.small_default.url}"
              alt="{if !empty($supplier.image.legend)}{$supplier.image.legend}{else}{$supplier.name}{/if}"
              width="{$supplier.image.bySize.small_default.width}"
              height="{$supplier.image.bySize.small_default.height}"
              loading="lazy"
            >
          </picture>
        {else}
          <img
            class="supplier__img img-fluid"
            src="{$urls.no_picture_image.bySize.small_default.url}"
            alt="{$supplier.name}"
            width="{$urls.no_picture_image.bySize.small_default.width}"
            height="{$urls.no_picture_image.bySize.small_default.height}"
            loading="lazy"
          >
        {/if}
      </div>
    {/if}

    <div class="supplier__infos">
      <a class="supplier__title stretched-link" href="{$supplier.url}">
        {$supplier.name}
      </a>
    </div>

    <p class="supplier__products">
      {if $supplier.nb_products > 1}
        {l s='%number% products' sprintf=['%number%' => $supplier.nb_products] d='Shop.Theme.Catalog'}
      {elseif $supplier.nb_products == 1}
        {l s='%number% product' sprintf=['%number%' => $supplier.nb_products] d='Shop.Theme.Catalog'}
      {else}
        {l s='No products' d='Shop.Theme.Catalog'}
      {/if}
    </p>
  </li>
{/block}
