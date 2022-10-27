{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{block name='pack_miniature_item'}
  <article class="product-pack__item rounded mb-2 p-2">
    <a href="{$product.url}" title="{$product.name}" class="row align-items-center">
      <div class="product-pack__image col-2">
        {if !empty($product.default_image.medium)}
          <img
            src="{$product.default_image.medium.url}"
            {if !empty($product.default_image.legend)}
              alt="{$product.default_image.legend}"
              title="{$product.default_image.legend}"
            {else}
              alt="{$product.name}"
            {/if}
            loading="lazy"
            class="img-fluid rounded"
          >
        {else}
          <img src="{$urls.no_picture_image.bySize.medium_default.url}" loading="lazy" class="img-fluid rounded" />
        {/if}
      </div>

      <p class="product-pack__name col-6 my-0">
        {$product.name}
      </p>

      {if $showPackProductsPrice}
        <p class="product-pack__price col text-center">
          <strong>{$product.price}</strong>
        </p>
      {/if}

      <p class="product-pack__quantity col text-center my-0">
        x{$product.pack_quantity}
      </p>
    </a>
  </article>
{/block}
