{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{block name='order_products_table_line_return'}
  <div class="grid-table__row {if isset($is_last_product) && $is_last_product}rounded-bottom-0{/if}" role="row">
    <span class="grid-table__cell" role="cell" data-ps-label="{l s='Select' d='Shop.Theme.Catalog'}">
      {if !$product.customizations}
        <input
          class="form-check-input"
          type="checkbox"
          id="cb_{$product.id_order_detail}"
          data-ps-ref="select-product"
          name="ids_order_detail[{$product.id_order_detail}]"
          value="{$product.id_order_detail}"
          {if $product.qty_returned >= $product.quantity}disabled{/if}
          aria-label="{$product.name}"
        >
      {else}
        {foreach $product.customizations  as $customization}
          <input
            class="form-check-input"
            type="checkbox"
            id="cb_{$product.id_order_detail}"
            data-ps-ref="select-product"
            name="customization_ids[{$product.id_order_detail}][]"
            value="{$customization.id_customization}"
            {if $product.qty_returned >= $product.quantity}disabled{/if}
            aria-label="{$product.name}"
          >
        {/foreach}
      {/if}
    </span>

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
              {l s='Reference: %reference%' sprintf=['%reference%' => $product.product_reference] d='Shop.Theme.Catalog'}
            </small>
          {/if}

          {if $product.is_virtual}
            <small class="text-secondary">
              {l s='Virtual product(s): No delivery service' d='Shop.Theme.Global'}
            </small>
          {/if}

          {if !$product.is_virtual && isset($carrier_name)}
            <small class="text-secondary">
              {l s='Carrier: %carrier_name%' sprintf=['%carrier_name%' => $carrier_name] d='Shop.Theme.Catalog'}
            </small>
          {/if}

          {if $product.customizations}
            {foreach from=$product.customizations item="customization"}
              <div id="product_customization_modal_wrapper_{$customization.id_customization}">
                {include file='catalog/_partials/customization-modal.tpl' customization=$customization}
              </div>

              <div class="customization">
                <a class="btn btn-sm btn-link p-0" href="#" data-bs-toggle="modal"
                  data-bs-target="#product-customizations-modal-{$customization.id_customization}">
                  <i class="material-icons">&#xE8F4;</i>
                  {l s='Product customization' d='Shop.Theme.Catalog'}
                </a>
              </div>
            {/foreach}
          {/if}
        </span>
      </span>
    </span>

    <span class="grid-table__cell grid-table__cell--center" role="cell" data-ps-label="{l s='Quantity' d='Shop.Theme.Catalog'}">
      <span class="grid-table__cell-group grid-table__cell-group--sm grid-table__cell-group--inline">
        {if !$product.customizations}
          <span class="current">
            <span class="visually-hidden">{l s='Available quantity to return:' d='Shop.Theme.Catalog'}</span>
            {$product.quantity}
          </span>
          {if $product.quantity > $product.qty_returned}
            <span class="select" id="order_return_qty_{$product.id_order_detail}">
              <select name="order_qte_input[{$product.id_order_detail}]" class="form-select" aria-label="{l s='Select quantity to return' d='Shop.Theme.Catalog'}">
                {section name=quantity start=1 loop=$product.quantity+1-$product.qty_returned}
                  <option value="{$smarty.section.quantity.index}">{$smarty.section.quantity.index}</option>
                {/section}
              </select>
            </span>
          {/if}
        {else}
          {foreach $product.customizations as $customization}
            <span class="current">
              <span class="visually-hidden">{l s='Available quantity to return:' d='Shop.Theme.Catalog'}</span>
              {$customization.quantity}
            </span>
            <span class="select" id="order_return_qty_{$product.id_order_detail}_{$customization.id_customization}">
              <select name="customization_qty_input[{$customization.id_customization}]" class="form-select" aria-label="{l s='Select quantity to return' d='Shop.Theme.Catalog'}">
                {section name=quantity start=1 loop=$customization.quantity+1}
                  <option value="{$smarty.section.quantity.index}">{$smarty.section.quantity.index}</option>
                {/section}
              </select>
            </span>
          {/foreach}
        {/if}
      </span>
    </span>

    <span class="grid-table__cell grid-table__cell--center" role="cell" data-ps-label="{l s='Returned' d='Shop.Theme.Catalog'}">{$product.qty_returned}</span>

    <span class="grid-table__cell grid-table__cell--center" role="cell" data-ps-label="{l s='Unit price' d='Shop.Theme.Catalog'}">{$product.price}</span>

    <span class="grid-table__cell grid-table__cell--right" role="cell" data-ps-label="{l s='Total price' d='Shop.Theme.Catalog'}">{$product.total}</span>
  </div>
{/block}
