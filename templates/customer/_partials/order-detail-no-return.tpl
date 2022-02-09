{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 *}
{block name='order_products_table'}
  <div class="table-wrapper d-none d-sm-block d-md-block">
    <table id="order-products" class="table order-products">
      <thead class="thead-default">
        <tr>
          <th>{l s='Image' d='Shop.Theme.Catalog'}</th>
          <th>{l s='Product' d='Shop.Theme.Catalog'}</th>
          <th class="text-xs-start text-end">{l s='Quantity' d='Shop.Theme.Catalog'}</th>
          <th class="text-xs-start text-end">{l s='Unit price' d='Shop.Theme.Catalog'}</th>
          <th class="text-xs-start text-end">{l s='Total price' d='Shop.Theme.Catalog'}</th>
        </tr>
      </thead>
      {foreach from=$order.products item=product}
        <tr>
          <td>
            {if $product.cover}
              <img src="{$product.cover.bySize.small_default.url}"
                alt="{if !empty($product.cover.legend)}{$product.cover.legend}{else}{$product.name|truncate:30:'...'}{/if}"
                loading="lazy" data-full-size-image-url="{$product.cover.large.url}" width="64" height="64"
                class="order-products__image card-img-top w-auto" />
            {else}
              <img src="{$urls.no_picture_image.bySize.small_default.url}" loading="lazy" width="64" height="64"
                class="order-products__image card-img-top w-auto" />
            {/if}
          </td>

          <td>
            <strong>
              <a {if isset($product.download_link)}href="{$product.download_link}" {/if}>
                {$product.name}
              </a>
            </strong><br />

            {if $product.product_reference}
              {l s='Reference' d='Shop.Theme.Catalog'}: {$product.product_reference}<br />
            {/if}

            {if $product.customizations}
              {foreach from=$product.customizations item="customization"}
                <div class="customization">
                  <a href="#" data-bs-toggle="modal"
                    data-target="#product-customizations-modal-{$customization.id_customization}">{l s='Product customization' d='Shop.Theme.Catalog'}</a>
                </div>

                <div id="_desktop_product_customization_modal_wrapper_{$customization.id_customization}">
                  <div class="modal fade customization-modal"
                    id="product-customizations-modal-{$customization.id_customization}" tabindex="-1" role="dialog"
                    aria-hidden="true">
                    <div class="modal-dialog" role="document">
                      <div class="modal-content">
                        <div class="modal-header">
                          <button type="button" class="btn-close" data-bs-dismiss="modal"
                            aria-label="{l s='Close' d='Shop.Theme.Global'}"></button>
                          <h4 class="modal-title">{l s='Product customization' d='Shop.Theme.Catalog'}</h4>
                        </div>
                        <div class="modal-body">
                          {foreach from=$customization.fields item="field"}
                            <div class="product-customization-line row">
                              <div class="col-sm-3 col-xs-4 label">
                                {$field.label}
                              </div>
                              <div class="col-sm-9 col-xs-8 value">
                                {if $field.type == 'text'}
                                  {if (int)$field.id_module}
                                    {$field.text nofilter}
                                  {else}
                                    {$field.text}
                                  {/if}
                                {elseif $field.type == 'image'}
                                  <img src="{$field.image.small.url}" loading="lazy">
                                {/if}
                              </div>
                            </div>
                          {/foreach}
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              {/foreach}
            {/if}
          </td>

          <td class="text-xs-start text-end">
            {if $product.customizations}
              {foreach $product.customizations as $customization}
                {$customization.quantity}
              {/foreach}
            {else}
              {$product.quantity}
            {/if}
          </td>
          <td class="text-xs-start text-end">{$product.price}</td>
          <td class="text-xs-start text-end">{$product.total}</td>
        </tr>
      {/foreach}
      <tfoot>
        {foreach $order.subtotals as $line}
          {if $line.value}
            <tr class="text-xs-end line-{$line.type}">
              <td colspan="4">{$line.label}</td>
              <td class="text-xs-start text-end">{$line.value}</td>
            </tr>
          {/if}
        {/foreach}
        <tr class="text-xs-end line-{$order.totals.total.type}">
          <td colspan="4">{$order.totals.total.label}</td>
          <td class="text-xs-start text-end">{$order.totals.total.value}</td>
        </tr>
      </tfoot>
    </table>
  </div>

  <div class="order__items table-wrapper d-block d-sm-none">
    {foreach from=$order.products item=product}
      <div class="order__item">
        <div class="row">
          <div class="order__item__header col-12 row">
            <div class="col-4">
              {if $product.cover}
                <img src="{$product.cover.bySize.small_default.url}"
                  alt="{if !empty($product.cover.legend)}{$product.cover.legend}{else}{$product.name|truncate:30:'...'}{/if}"
                  loading="lazy" data-full-size-image-url="{$product.cover.large.url}" width="64" height="64"
                  class="order-products__image card-img-top w-auto" />
              {else}
                <img src="{$urls.no_picture_image.bySize.small_default.url}" loading="lazy" width="64" height="64"
                  class="order-products__image card-img-top w-auto" />
              {/if}
            </div>

            <div class="col-8">
              <p class="order__item__name fw-bold">{$product.name}</p>
              {if $product.product_reference}
                <div class="order__item__ref">{l s='Reference' d='Shop.Theme.Catalog'}: {$product.product_reference}</div>
              {/if}
              {if $product.customizations}
                {foreach $product.customizations as $customization}
                  <div class="customization">
                    <a href="#" data-bs-toggle="modal"
                      data-target="#product-customizations-modal-{$customization.id_customization}">{l s='Product customization' d='Shop.Theme.Catalog'}</a>
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
                  {/foreach}
                {else}
                  {$product.quantity}
                {/if}
              </span>
            </div>

            <div class="order__item__line row">
              <span class="order__item__label col">{l s='Unit price' d='Shop.Theme.Catalog'}</span>
              <span class="order__item__value col text-end">
                {$product.price}
              </span>
            </div>

            <div class="order__item__line row">
              <span class="order__item__label col">{l s='Total price' d='Shop.Theme.Catalog'}</span>
              <span class="order__item__value col text-end">
                {$product.price}
              </span>
            </div>
          </div>
        </div>
      </div>
    {/foreach}

    <hr>

    <div class="order__totals d-block d-sm-none">
      {foreach $order.subtotals as $line}
        {if $line.value}
          <div class="order__total row">
            <div class="col">{$line.label}</div>
            <div class="col text-end">{$line.value}</div>
          </div>
        {/if}
      {/foreach}
      <div class="order__total row">
        <div class="col fw-bold">{$order.totals.total.label}</div>
        <div class="col text-end fw-bold">{$order.totals.total.value}</div>
      </div>
    </div>
  </div>
{/block}
