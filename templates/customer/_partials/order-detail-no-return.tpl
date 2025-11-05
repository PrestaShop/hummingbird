{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{block name='order_products_table'}
  <div class="grid-table grid-table--collapse mb-0" role="table" aria-label="{l s='Products details' d='Shop.Theme.Customeraccount'}" aria-describedby="order_products_heading">
    <div class="grid-table__inner grid-table__inner--4" role="rowgroup">
      <header class="grid-table__header" role="row">
        <span class="grid-table__cell" role="columnheader">{l s='Product' d='Shop.Theme.Catalog'}</span>
        <span class="grid-table__cell grid-table__cell--center" role="columnheader">{l s='Quantity' d='Shop.Theme.Catalog'}</span>
        <span class="grid-table__cell grid-table__cell--center" role="columnheader">{l s='Unit price' d='Shop.Theme.Catalog'}</span>
        <span class="grid-table__cell grid-table__cell--right" role="columnheader">{l s='Total price' d='Shop.Theme.Catalog'}</span>
      </header>

      {foreach from=$order.products item=product name=products}
        <div class="grid-table__row {if $smarty.foreach.products.last}rounded-bottom-0{/if}" role="row">
          <span class="grid-table__cell order-product" role="cell" data-ps-label="{l s='Product' d='Shop.Theme.Catalog'}">
            <span class="order-product__infos">
              <span class="order-product__image">
                <a href="{$link->getProductLink($product.id_product)}">
                  {if $product.cover}
                    <picture>
                      {if isset($product.cover.bySize.default_xs.sources.avif)}
                        <source
                          srcset="
                            {$product.cover.bySize.default_xs.sources.avif},
                            {$product.cover.bySize.default_md.sources.avif} 2x",
                          type="image/avif"
                        >
                      {/if}

                      {if isset($product.cover.bySize.default_xs.sources.webp)}
                        <source
                          srcset="
                            {$product.cover.bySize.default_xs.sources.webp},
                            {$product.cover.bySize.default_md.sources.webp} 2x"
                          type="image/webp"
                        >
                      {/if}

                      <img
                        class="order-product__img img-fluid"
                        srcset="
                          {$product.cover.bySize.default_xs.url},
                          {$product.cover.bySize.default_md.url} 2x"
                        width="{$product.cover.bySize.default_xs.width}"
                        height="{$product.cover.bySize.default_xs.height}"
                        loading="lazy"
                        alt="{$product.cover.legend}"
                        title="{$product.cover.legend}"
                      >
                    </picture>
                  {else}
                    <picture>
                      {if isset($urls.no_picture_image.bySize.default_xs.sources.avif)}
                        <source
                          srcset="
                            {$urls.no_picture_image.bySize.default_xs.sources.avif},
                            {$urls.no_picture_image.bySize.default_md.sources.avif} 2x"
                          type="image/avif"
                        >
                      {/if}

                      {if isset($urls.no_picture_image.bySize.default_xs.sources.webp)}
                        <source
                          srcset="
                            {$urls.no_picture_image.bySize.default_xs.sources.webp},
                            {$urls.no_picture_image.bySize.default_md.sources.webp} 2x"
                          type="image/webp"
                        >
                      {/if}

                      <img
                        class="order-product__img img-fluid"
                        srcset="
                          {$urls.no_picture_image.bySize.default_xs.url},
                          {$urls.no_picture_image.bySize.default_md.url} 2x"
                        width="{$urls.no_picture_image.bySize.default_xs.width}"
                        height="{$urls.no_picture_image.bySize.default_xs.height}"
                        loading="lazy"
                      >
                    </picture>
                  {/if}
                </a>
              </span>

              <span class="order-product__content">
                <a class="order-product__name" href="{$link->getProductLink($product.id_product)}">
                  {$product.name}
                </a>

                {if $product.product_reference}
                  <small class="text-secondary">
                    {l s='Reference' d='Shop.Theme.Catalog'}: {$product.product_reference}
                  </small>
                {/if}

                {if isset($product.download_link)}
                  <a href="{$product.download_link}">
                    <i class="material-icons" aria-hidden="true">&#xF090;</i> {l s='Download' d='Shop.Theme.Actions'}
                  </a>
                {/if}

                {if $product.customizations}
                  {foreach from=$product.customizations item="customization"}
                    <span id="product_customization_modal_wrapper_{$customization.id_customization}">
                      {include file='catalog/_partials/customization-modal.tpl' customization=$customization}
                    </span>

                    <span class="customization">
                      <a class="btn btn-sm btn-link p-0" href="#" data-bs-toggle="modal"
                        data-bs-target="#product-customizations-modal-{$customization.id_customization}">
                        <i class="material-icons">&#xE8F4;</i>
                        {l s='Product customization' d='Shop.Theme.Catalog'}
                      </a>
                    </span>
                  {/foreach}
                {/if}
              </span>
            </span>
          </span>

          <span class="grid-table__cell grid-table__cell--center" role="cell" data-ps-label="{l s='Quantity' d='Shop.Theme.Catalog'}">
            {if $product.customizations}
              {foreach $product.customizations as $customization}
                {$customization.quantity}
              {/foreach}
            {else}
              {$product.quantity}
            {/if}
          </span>

          <span class="grid-table__cell grid-table__cell--center" role="cell" data-ps-label="{l s='Unit price' d='Shop.Theme.Catalog'}">
            {$product.price}
          </span>

          <span class="grid-table__cell grid-table__cell--right" role="cell" data-ps-label="{l s='Total price' d='Shop.Theme.Catalog'}">
            {$product.total}
          </span>
        </div>
      {/foreach}
    </div>
  </div>

  <div class="grid-table grid-table--collapse" role="table" aria-label="{l s='Order totals' d='Shop.Theme.Customeraccount'}">
    <div class="grid-table__inner grid-table__inner--6" role="rowgroup">
      {foreach $order.subtotals as $line}
        {if $line.value}
          <div class="grid-table__row" role="row">
            <span class="grid-table__cell grid-table__cell--label-value" role="cell" data-ps-label="{$line.label}">
              <span class="visually-hidden">{l s='%label%' d='Shop.Theme.Catalog' sprintf=['%label%' => $line.label]}</span>
              {$line.value}
            </span>
          </div>
        {/if}
      {/foreach}

      <div class="grid-table__row" role="row">
        <span class="grid-table__cell grid-table__cell--label-value" role="cell" data-ps-label="{$order.totals.total.label}">
          <span class="visually-hidden">{l s='Total price' d='Shop.Theme.Catalog'}</span>
          {$order.totals.total.value}
        </span>
      </div>
    </div>
  </div>
{/block}
