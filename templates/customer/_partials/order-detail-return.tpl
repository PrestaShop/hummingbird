{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{block name='order_products_table'}
  <form id="order-return-form" class="js-order-return-form" action="{$urls.pages.order_follow}" method="post" data-ps-action="form-validation">
    <div class="grid-table grid-table--collapse mb-0" role="table" data-ps-ref="order-return-products-table" aria-label="{l s='Products details' d='Shop.Theme.Catalog'}" aria-describedby="order_products_heading">
      <div class="grid-table__inner grid-table__inner--6" role="rowgroup">
        <div class="grid-table__header" role="row">
          <span class="grid-table__cell" role="columnheader" aria-label="{l s='Select product to return' d='Shop.Theme.Catalog'}">
            <input class="form-check-input" type="checkbox" data-ps-ref="select-all-products" aria-label="{l s='Select all products' d='Shop.Theme.Catalog'}">
          </span>
          <span class="grid-table__cell" role="columnheader">{l s='Product' d='Shop.Theme.Catalog'}</span>
          <span class="grid-table__cell grid-table__cell--center" role="columnheader">{l s='Quantity' d='Shop.Theme.Catalog'}</span>
          <span class="grid-table__cell grid-table__cell--center" role="columnheader">{l s='Returned' d='Shop.Theme.Catalog'}</span>
          <span class="grid-table__cell grid-table__cell--center" role="columnheader">{l s='Unit price' d='Shop.Theme.Catalog'}</span>
          <span class="grid-table__cell grid-table__cell--right" role="columnheader">{l s='Total price' d='Shop.Theme.Catalog'}</span>
        </div>

        {foreach from=$order.products item=product name=products}
          <div class="grid-table__row {if $smarty.foreach.products.last}rounded-bottom-0{/if}" role="row">
            <span class="grid-table__cell" role="cell" data-ps-label="{l s='Select' d='Shop.Theme.Catalog'}">
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

                  {if $product.customizations}
                    {foreach from=$product.customizations item="customization"}
                      <div id="product_customization_modal_wrapper_{$customization.id_customization}">
                        {include file='catalog/_partials/customization-modal.tpl' customization=$customization}
                      </div>

                      <div class="customization">
                        <a class="btn btn-sm btn-link p-0" href="#" data-bs-toggle="modal"
                          data-bs-target="#product-customizations-modal-{$customization.id_customization}">
                          <i class="material-icons" aria-hidden="true">&#xE8F4;</i>
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
                <span class="current">
                  <span class="visually-hidden">{l s='Available quantity to return:' d='Shop.Theme.Catalog'}</span>
                  {$product.quantity}
                </span>
                {if $product.quantity > $product.qty_returned}
                  <span class="select" id="_desktop_return_qty_{$product.id_order_detail}">
                    <select name="order_qte_input[{$product.id_order_detail}]" class="form-select" aria-label="{l s='Select quantity to return' d='Shop.Theme.Catalog'}">
                      {section name=quantity start=1 loop=$product.quantity+1-$product.qty_returned}
                        <option value="{$smarty.section.quantity.index}">{$smarty.section.quantity.index}</option>
                      {/section}
                    </select>
                  </span>
                {/if}
              </span>
            </span>

            <span class="grid-table__cell grid-table__cell--center" role="cell" data-ps-label="{l s='Returned' d='Shop.Theme.Catalog'}">{$product.qty_returned}</span>

            <span class="grid-table__cell grid-table__cell--center" role="cell" data-ps-label="{l s='Unit price' d='Shop.Theme.Catalog'}">{$product.price}</span>

            <span class="grid-table__cell grid-table__cell--right" role="cell" data-ps-label="{l s='Total price' d='Shop.Theme.Catalog'}">{$product.total}</span>
          </div>
        {/foreach}
      </div>
    </div>

    <div class="grid-table grid-table--collapse" role="table" aria-label="{l s='Order totals' d='Shop.Theme.Catalog'}">
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

    <hr class="order-separator">

    <section class="order-merchandise-return">
      <h3 class="h3">{l s='Merchandise return' d='Shop.Theme.Customeraccount'}</h3>

      <label class="form-label required" for="return_notes">{l s='Return notes' d='Shop.Forms.Labels'}</label>

      <textarea
        rows="3"
        name="returnText"
        id="return_notes"
        class="form-control required"
        aria-describedby="order_merchandise_return"
        required
      ></textarea>

      <p class="form-text" id="order_merchandise_return">
        {l s='If you wish to return one or more products, please mark the corresponding boxes and provide an explanation for the return. When complete, click the button below.' d='Shop.Theme.Customeraccount'}
      </p>

      <div class="buttons-wrapper buttons-wrapper--end mt-3">
        <input type="hidden" name="id_order" value="{$order.details.id}">
        <button class="btn btn-primary" type="submit" name="submitReturnMerchandise" data-ps-action="form-validation-submit">
          {l s='Request a return' d='Shop.Theme.Customeraccount'}
        </button>
      </footer>
    </div>
  </form>
{/block}
