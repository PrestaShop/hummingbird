{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{block name='order_products_table'}
  <form id="order-return-form" class="js-order-return-form" action="{$urls.pages.order_follow}" method="post">

    <div class="table-wrapper d-none d-sm-block d-md-block">
      <table id="order-products" class="table order-return">
        <thead class="thead-default">
          <tr>
            <th class="head-checkbox"><input type="checkbox" /></th>
            <th>{l s='Product' d='Shop.Theme.Catalog'}</th>
            <th>{l s='Quantity' d='Shop.Theme.Catalog'}</th>
            <th>{l s='Returned' d='Shop.Theme.Customeraccount'}</th>
            <th>{l s='Unit price' d='Shop.Theme.Catalog'}</th>
            <th>{l s='Total price' d='Shop.Theme.Catalog'}</th>
          </tr>
        </thead>
        {foreach from=$order.products item=product name=products}
          <tr>
            <td>
              {if !$product.customizations}
                <span id="_desktop_product_line_{$product.id_order_detail}">
                  <input type="checkbox" id="cb_{$product.id_order_detail}"
                    name="ids_order_detail[{$product.id_order_detail}]" value="{$product.id_order_detail}">
                </span>
              {else}
                {foreach $product.customizations  as $customization}
                  <span id="_desktop_product_customization_line_{$product.id_order_detail}_{$customization.id_customization}">
                    <input type="checkbox" id="cb_{$product.id_order_detail}"
                      name="customization_ids[{$product.id_order_detail}][]" value="{$customization.id_customization}">
                  </span>
                {/foreach}
              {/if}
            </td>
            <td>
              <strong>{$product.name}</strong><br />
              {if $product.product_reference}
                {l s='Reference' d='Shop.Theme.Catalog'}: {$product.product_reference}<br />
              {/if}
              {if $product.customizations}
                {foreach from=$product.customizations item="customization"}
                  <div class="customization">
                    <a href="#" data-bs-toggle="modal"
                      data-bs-target="#product-customizations-modal-{$customization.id_customization}">{l s='Product customization' d='Shop.Theme.Catalog'}</a>
                  </div>
                  <div id="_desktop_product_customization_modal_wrapper_{$customization.id_customization}">
                    {include file='catalog/_partials/customization-modal.tpl' customization=$customization}
                  </div>
                {/foreach}
              {/if}
            </td>
            <td class="qty">
              {if !$product.customizations}
                <div class="current">
                  {$product.quantity}
                </div>
                {if $product.quantity> $product.qty_returned}
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
                <div></div>
              {/if}
            </td>
            <td class="text-xs-end">{$product.qty_returned}</td>
            <td class="text-xs-end">{$product.price}</td>
            <td class="text-xs-end">{$product.total}</td>
          </tr>
        {/foreach}
        <tfoot>
          {foreach $order.subtotals as $line}
            {if $line.value}
              <tr class="text-xs-end line-{$line.type}">
                <td colspan="5">{$line.label}</td>
                <td colspan="2">{$line.value}</td>
              </tr>
            {/if}
          {/foreach}
          <tr class="text-xs-riendght line-{$order.totals.total.type}">
            <td colspan="5">{$order.totals.total.label}</td>
            <td colspan="2">{$order.totals.total.value}</td>
          </tr>
        </tfoot>
      </table>
    </div>

    <div class="order__items table-wrapper d-block d-sm-block d-md-none box">
      {foreach from=$order.products item=product}
        <div class="order__item">
          <div class="row">
            <div class="order__item__header col-12 row">
              <div class="col-2 order__item__checkbox checkbox">
                {if !$product.customizations}
                  <span id="_mobile_product_line_{$product.id_order_detail}"></span>
                {else}
                  {foreach $product.customizations  as $customization}
                    <span
                      id="_mobile_product_customization_line_{$product.id_order_detail}_{$customization.id_customization}"></span>
                  {/foreach}
                {/if}
              </div>
              <div class="col-4">
                {if $product.cover}
                  <picture>
                    {if isset($product.cover.bySize.default_xs.sources.avif)}
                      <source 
                        srcset="
                          {$product.cover.bySize.default_xs.sources.avif},
                          {$product.cover.bySize.default_m.sources.avif} 2x",
                        type="image/avif"
                      >
                    {/if}

                    {if isset($product.cover.bySize.default_xs.sources.webp)}
                      <source 
                        srcset="
                          {$product.cover.bySize.default_xs.sources.webp},
                          {$product.cover.bySize.default_m.sources.webp} 2x"
                        type="image/webp"
                      >
                    {/if}

                    <img
                      class="order-products__image card-img-top w-auto"
                      srcset="
                        {$product.cover.bySize.default_xs.url},
                        {$product.cover.bySize.default_m.url} 2x"
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
                          {$urls.no_picture_image.bySize.default_m.sources.avif} 2x"
                        type="image/avif"
                      >
                    {/if}

                    {if isset($urls.no_picture_image.bySize.default_xs.sources.webp)}
                      <source 
                        srcset="
                          {$urls.no_picture_image.bySize.default_xs.sources.webp},
                          {$urls.no_picture_image.bySize.default_m.sources.webp} 2x"
                        type="image/webp"
                      >
                    {/if}

                    <img
                      class="order-products__image card-img-top w-auto"
                      srcset="
                        {$urls.no_picture_image.bySize.default_xs.url},
                        {$urls.no_picture_image.bySize.default_m.url} 2x"
                      width="{$urls.no_picture_image.bySize.default_xs.width}"
                      height="{$urls.no_picture_image.bySize.default_xs.height}"
                      loading="lazy"
                    >
                  </picture>
                {/if}
              </div>

              <div class="col-6">
                <p class="order__item__name fw-bold">{$product.name}</p>
                {if $product.product_reference}
                  <div class="order__item__ref">{l s='Reference' d='Shop.Theme.Catalog'}: {$product.product_reference}</div>
                {/if}
                {if $product.customizations}
                  {foreach $product.customizations as $customization}
                    <div class="customization">
                      <a href="#" data-bs-toggle="modal"
                        data-bs-target="#product-customizations-modal-{$customization.id_customization}">{l s='Product customization' d='Shop.Theme.Catalog'}</a>
                    </div>
                    <div id="_mobile_product_customization_modal_wrapper_{$customization.id_customization}">
                    </div>
                  {/foreach}
                {/if}
              </div>
            </div>
            <div class="col-12 order__item__qty">
              <div class="order__item__line row">
                <span class="order__item__label col">{l s='Quantity' d='Shop.Theme.Catalog'}</span>
                <span class="order__item__value col text-end">
                  {if $product.customizations}
                    {foreach $product.customizations as $customization}
                      {$customization.quantity}
                      <div class="mt-2" id="_mobile_return_qty_{$product.id_order_detail}_{$customization.id_customization}"></div>
                    {/foreach}
                  {else}
                    {$product.quantity}
                    {if $product.quantity> $product.qty_returned}
                      <div class="mt-2" id="_mobile_return_qty_{$product.id_order_detail}"></div>
                    {/if}
                  {/if}
                </span>
              </div>
              {if $product.qty_returned > 0}
                <div class="order__item__line row">
                  <span class="order__item__label col">{l s='Returned' d='Shop.Theme.Customeraccount'}</span>
                  <span class="order__item__value col text-end">
                    {$product.qty_returned}
                  </span>
                </div>
              {/if}
              <div class="order__item__line row">
                <span class="order__item__label col">{l s='Unit price' d='Shop.Theme.Catalog'}</span>
                <span class="order__item__value col text-end">
                  {$product.price}
                </span>
              </div>
              <div class="order__item__line row">
                <span class="order__item__label col">{l s='Total price' d='Shop.Theme.Catalog'}</span>
                <span class="order__item__value col text-end">
                  {$product.total}
                </span>
              </div>
            </div>
          </div>
        </div>
      {/foreach}
    </div>
    <div class="order-totals d-none d-sm-block d-md-none box">
      {foreach $order.subtotals as $line}
        {if $line.value}
          <div class="order-total row">
            <div class="col-xs-8"><strong>{$line.label}</strong></div>
            <div class="col-xs-4 text-xs-end">{$line.value}</div>
          </div>
        {/if}
      {/foreach}
      <div class="order-total row">
        <div class="col-xs-8"><strong>{$order.totals.total.label}</strong></div>
        <div class="col-xs-4 text-xs-end">{$order.totals.total.value}</div>
      </div>
    </div>
    <hr>
    <div class="box">
      <header>
        <h3 class="h3">{l s='Merchandise return' d='Shop.Theme.Customeraccount'}</h3>
        <p>
          {l s='If you wish to return one or more products, please mark the corresponding boxes and provide an explanation for the return. When complete, click the button below.' d='Shop.Theme.Customeraccount'}
        </p>
      </header>
      <section class="form-fields">
        <div class="mb-3">
          <textarea cols="67" rows="3" name="returnText" class="form-control"></textarea>
        </div>
      </section>
      <footer class="form-footer">
        <input type="hidden" name="id_order" value="{$order.details.id}">
        <button class="form-control-submit btn btn-primary" type="submit" name="submitReturnMerchandise">
          {l s='Request a return' d='Shop.Theme.Customeraccount'}
        </button>
      </footer>
    </div>

  </form>
{/block}
