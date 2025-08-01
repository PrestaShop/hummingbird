{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{block name='order_products_table'}
  <form id="order-return-form" class="js-order-return-form" action="{$urls.pages.order_follow}" method="post">
    <div class="grid-table grid-table--collapse" data-ps-ref="order-return-products-table" data-role="table">
      <div class="grid-table__inner grid-table__inner--6">
        <header class="grid-table__header">
          <div class="grid-table__cell"><input class="form-check-input" type="checkbox" data-ps-ref="select-all-products"></div>
          <div class="grid-table__cell">{l s='Product' d='Shop.Theme.Catalog'}</div>
          <div class="grid-table__cell grid-table__cell--center">{l s='Quantity' d='Shop.Theme.Catalog'}</div>
          <div class="grid-table__cell grid-table__cell--center">{l s='Returned' d='Shop.Theme.Customeraccount'}</div>
          <div class="grid-table__cell grid-table__cell--center">{l s='Unit price' d='Shop.Theme.Catalog'}</div>
          <div class="grid-table__cell grid-table__cell--right">{l s='Total price' d='Shop.Theme.Catalog'}</div>
        </header>

        {foreach from=$order.products item=product name=products}
          <div class="grid-table__row">
            <div class="grid-table__cell" aria-label="{l s='Select' d='Shop.Theme.Catalog'}">
              {if !$product.customizations}
                <span id="_desktop_product_line_{$product.id_order_detail}">
                  <input class="form-check-input" type="checkbox" id="cb_{$product.id_order_detail}" data-ps-ref="select-product"
                    name="ids_order_detail[{$product.id_order_detail}]" value="{$product.id_order_detail}" {if $product.qty_returned >= $product.quantity}disabled{/if}>
                </span>
              {else}
                {foreach $product.customizations  as $customization}
                  <span id="_desktop_product_customization_line_{$product.id_order_detail}_{$customization.id_customization}">
                    <input class="form-check-input" type="checkbox" id="cb_{$product.id_order_detail}" data-ref="select-product"
                      name="customization_ids[{$product.id_order_detail}][]" value="{$customization.id_customization}" {if $product.qty_returned >= $product.quantity}disabled{/if}>
                  </span>
                {/foreach}
              {/if}
            </div>

            <div class="grid-table__cell order-product" aria-label="{l s='Product' d='Shop.Theme.Catalog'}">
              <div class="order-product__infos">
                <div class="order-product__image">
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
                </div>

                <div class="order-product__content">
                  <a class="order-product__name" href="{$link->getProductLink($product.id_product)}">
                    {$product.name}
                  </a>

                  {if $product.product_reference}
                    <small class="text-secondary">
                      {l s='Reference' d='Shop.Theme.Catalog'}: {$product.product_reference}
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
                </div>
              </div>
            </div>

            <div class="grid-table__cell grid-table__cell--center" aria-label="{l s='Quantity' d='Shop.Theme.Catalog'}">
              <div class="grid-table__cell-group grid-table__cell-group--sm grid-table__cell-group--inline">
                {if !$product.customizations}
                  <div class="current">
                    {$product.quantity}
                  </div>
                  {if $product.quantity > $product.qty_returned}
                    <div class="select" id="_desktop_return_qty_{$product.id_order_detail}">
                      <select name="order_qte_input[{$product.id_order_detail}]" class="form-select">
                        {section name=quantity start=1 loop=$product.quantity+1-$product.qty_returned}
                          <option value="{$smarty.section.quantity.index}">{$smarty.section.quantity.index}</option>
                        {/section}
                      </select>
                    </div>
                  {/if}
                {else}
                  {foreach $product.customizations as $customization}
                    <div class="current">
                      {$customization.quantity}
                    </div>
                    <div class="select" id="_desktop_return_qty_{$product.id_order_detail}_{$customization.id_customization}">
                      <select name="customization_qty_input[{$customization.id_customization}]" class="form-select">
                        {section name=quantity start=1 loop=$customization.quantity+1}
                          <option value="{$smarty.section.quantity.index}">{$smarty.section.quantity.index}</option>
                        {/section}
                      </select>
                    </div>
                  {/foreach}
                {/if}
              </div>
            </div>

            <div class="grid-table__cell grid-table__cell--center" aria-label="{l s='Returned' d='Shop.Theme.Customeraccount'}">{$product.qty_returned}</div>

            <div class="grid-table__cell grid-table__cell--center" aria-label="{l s='Unit price' d='Shop.Theme.Catalog'}">{$product.price}</div>

            <div class="grid-table__cell grid-table__cell--right" aria-label="{l s='Total price' d='Shop.Theme.Catalog'}">{$product.total}</div>
          </div>
        {/foreach}

        <div class="grid-table__row">
          {foreach $order.subtotals as $line}
            {if $line.value}
              <div class="grid-table__cell grid-table__cell--label-value" aria-label="{$line.label}">{$line.value}</div>
            {/if}
          {/foreach}

          <div class="grid-table__cell grid-table__cell--label-value" aria-label="{$order.totals.total.label}">{$order.totals.total.value}</div>
        </div>
      </div>
    </div>

    <hr class="order-separator">

    <section class="order-merchandise-return">
      <h3 class="h3">{l s='Merchandise return' d='Shop.Theme.Customeraccount'}</h3>

      <p>
        {l s='If you wish to return one or more products, please mark the corresponding boxes and provide an explanation for the return. When complete, click the button below.' d='Shop.Theme.Customeraccount'}
      </p>

      <textarea rows="3" name="returnText" class="form-control" required></textarea>

      <div class="buttons-wrapper buttons-wrapper--end mt-3">
        <input type="hidden" name="id_order" value="{$order.details.id}">
        <button class="btn btn-primary" type="submit" name="submitReturnMerchandise">
          {l s='Request a return' d='Shop.Theme.Customeraccount'}
        </button>
      </footer>
    </div>
  </form>
{/block}
