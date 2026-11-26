{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
{block name='brand_miniature_item'}
  {$imageTypes = ['small_default' => '']}
  <li class="brand">
    {if $displayImages|default:false}
      <div class="brand__image">
        {if !empty($brand.image.bySize.small_default.url)}
          {$srcset = $brand.image|srcset:$imageTypes}
          <picture>
            {include file='_partials/picture-sources.tpl' srcset=$srcset}

            <img
              class="brand__img img-fluid"
              {if $srcset.src}
                src="{$srcset.src}"
                width="{$srcset.width}"
                height="{$srcset.height}"
              {/if}
              alt="{if !empty($brand.image.legend)}{$brand.image.legend}{else}{$brand.name}{/if}"
              loading="lazy"
            >
          </picture>
        {else}
          {$srcset = $urls.no_picture_image|srcset:$imageTypes}
          <img
            class="brand__img img-fluid"
            {if $srcset.src}
              src="{$srcset.src}"
              width="{$srcset.width}"
              height="{$srcset.height}"
            {/if}
            alt="{$brand.name}"
            loading="lazy"
          >
        {/if}
      </div>
    {/if}

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
