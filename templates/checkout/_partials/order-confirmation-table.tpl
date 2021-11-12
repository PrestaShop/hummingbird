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
 {$componentName = 'order-confirmation'}

<div id="order-items" class="{$componentName}-items col-md-12">
  <div class="order-confirmation-table">
    {block name='order_confirmation_table'}
      {foreach from=$products item=product}
        <div class="order-confirmation-item row">
          <div class="{$componentName}-image col-sm-1 col-xs-2">
            <span class="image">
              {if !empty($product.default_image)}
                <img src="{$product.default_image.medium.url}" loading="lazy" />
              {else}
                <img src="{$urls.no_picture_image.bySize.medium_default.url}" loading="lazy" />
              {/if}
            </span>
          </div>
          <div class="{$componentName}-item-details col-sm-5 col-xs-10">
            {if $add_product_link}<a href="{$product.url}" target="_blank">{/if}
              <span class="{$componentName}-item-title">{$product.name}</span>
            {if $add_product_link}</a>{/if}
            {if is_array($product.customizations) && $product.customizations|count}
              {foreach from=$product.customizations item="customization"}
                <div class="customizations">
                  <a href="#" data-bs-toggle="modal" data-target="#product-customizations-modal-{$customization.id_customization}">{l s='Product customization' d='Shop.Theme.Catalog'}</a>
                </div>
                <div class="modal fade customization-modal" id="product-customizations-modal-{$customization.id_customization}" tabindex="-1" role="dialog" aria-hidden="true">
                  <div class="modal-dialog" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{l s='Close' d='Shop.Theme.Global'}"></button>
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
              {/foreach}
            {/if}
            {hook h='displayProductPriceBlock' product=$product type="unit_price"}
          </div>
          <div class="{$componentName}-item-prices col-sm-6 col-xs-12 qty">
            <div class="row">
              <div class="col-xs-4 text-end">{$product.price}</div>
              <div class="col-xs-4 text-end">{$product.quantity}</div>
              <div class="col-xs-4 text-end">{$product.total}</div>
            </div>
          </div>
        </div>
      {/foreach}

      <table class="{$componentName}-prices">
        {foreach $subtotals as $subtotal}
          {if $subtotal !== null && $subtotal.type !== 'tax' && $subtotal.label !== null}
            <tr class="{$componentName}-subtotal">
              <td>{$subtotal.label}</td>
              <td>{if 'discount' == $subtotal.type}-&nbsp;{/if}{$subtotal.value}</td>
            </tr>
          {/if}
        {/foreach}

        {if !$configuration.display_prices_tax_incl && $configuration.taxes_enabled}
          <tr>
            <td><span class="text-uppercase">{$totals.total.label}&nbsp;{$labels.tax_short}</span></td>
            <td>{$totals.total.value}</td>
          </tr>
          <tr class="total-value font-weight-bold">
            <td><span class="text-uppercase">{$totals.total_including_tax.label}</span></td>
            <td>{$totals.total_including_tax.value}</td>
          </tr>
        {else}
          <tr class="total-value font-weight-bold">
            <td><span class="text-uppercase">{$totals.total.label}&nbsp;{if $configuration.taxes_enabled}{$labels.tax_short}{/if}</span></td>
            <td>{$totals.total.value}</td>
          </tr>
        {/if}
        {if $subtotals.tax !== null && $subtotals.tax.label !== null}
          <tr class="sub taxes">
            <td colspan="2"><span class="label">{l s='%label%:' sprintf=['%label%' => $subtotals.tax.label] d='Shop.Theme.Global'}</span>&nbsp;<span class="value">{$subtotals.tax.value}</span></td>
          </tr>
        {/if}
      </table>
    {/block}

  </div>
</div>
