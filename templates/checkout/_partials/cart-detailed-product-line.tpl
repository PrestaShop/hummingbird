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

<div class="product-line row">
  <div class="product-line__image col-4 col-sm-2">
    {if $product.default_image}
      <img src="{$product.default_image.bySize.cart_default.url}" class="img-fluid" alt="{$product.name|escape:'quotes'}"
        loading="lazy">
    {else}
      <img src="{$urls.no_picture_image.bySize.cart_default.url}" class="img-fluid" loading="lazy" />
    {/if}
  </div>

  <div class="product-line__content col-8 col-sm-4 col-md-6">
    <a class="product-line__title product-line__item" href="{$product.url}"
      data-id_customization="{$product.id_customization|intval}">
      {$product.name}
    </a>

    {foreach from=$product.attributes key="attribute" item="value"}
      <div class="product-line__info product-line__item {$attribute|lower}">
        <span class="label">{$attribute}:</span>
        <span class="value">{$value}</span>
      </div>
    {/foreach}

    <div class="product-line__prices product-line__item">
      <div class="product-line__current">
        <span class="price">{$product.price}</span>
        {if $product.unit_price_full}
          <div class="unit-price-cart">{$product.unit_price_full}</div>
        {/if}
      </div>

      <div class="product-line__basic">
        <span class="product-line__regular">{$product.regular_price}</span>

        {if $product.has_discount}
          {if $product.discount_type === 'percentage'}
            <span class="discount badge discount">
              -{$product.discount_percentage_absolute}
            </span>
          {else}
            <span class="discount badge discount">
              -{$product.discount_to_display}
            </span>
          {/if}
        {/if}
      </div>
    </div>
  </div>

  <div class="col-4 d-block d-sm-none"></div>

  <div class="product-line__informations col-8 col-sm-6 col-md-4">
    <div class="row align-items-center">
      <div class="quantity-button js-quantity-button col-6">
        {if !empty($product.is_gift)}
          <span class="gift-quantity">{$product.quantity}</span>
        {else}
          <input 
            class="js-cart-line-product-quantity form-control" 
            data-down-url="{$product.down_quantity_url}"
            data-up-url="{$product.up_quantity_url}" 
            data-update-url="{$product.update_quantity_url}"
            data-product-id="{$product.id_product}" 
            type="number" 
            inputmode="numeric" 
            pattern="[0-9]*"
            value="{$product.quantity}" 
            min="{$product.minimal_quantity}"
            name="product-quantity-spin"/>
        {/if}
      </div>

      <div class="col-6">
        {if $product.has_discount}
          <div class="product-line__discount text-end">
            <div class="price">
              <span class="product-line__price">
                <strong>
                  {if !empty($product.is_gift)}
                    <span class="gift">{l s='Gift' d='Shop.Theme.Checkout'}</span>
                  {else}
                    {$product.total}
                  {/if}
                </strong>
              </span>
            </div>
          </div>
        {else}
          {if !empty($product.is_gift)}
            <span class="gift">{l s='Gift' d='Shop.Theme.Checkout'}</span>
          {else}
            {$product.total}
          {/if}
        {/if}

        {hook h='displayProductPriceBlock' product=$product type="unit_price"}
      </div>
    </div>
    <div class="row">
      <p class="product__minimal-quantity js-product-minimal-quantity text-muted mt-2">
        {if $product.minimal_quantity > 1}
          {l
          s='The minimum purchase order quantity for the product is %quantity%.'
          d='Shop.Theme.Checkout'
          sprintf=['%quantity%' => $product.minimal_quantity]
          }
        {/if}
      </p>
    </div>
  </div>

  <div class="col-4 col-sm-2"></div>

  <div class="product-line__actions col-8 col-sm-10">
    {if empty($product.is_gift)}
      <a class="remove-from-cart" rel="nofollow" href="{$product.remove_from_cart_url}"
        data-link-action="delete-from-cart" data-id-product="{$product.id_product|escape:'javascript'}"
        data-id-product-attribute="{$product.id_product_attribute|escape:'javascript'}"
        data-id-customization="{$product.id_customization|escape:'javascript'}">
        {l s='Remove' d='Shop.Theme.Checkout'}
      </a>
    {/if}

    {block name='hook_cart_extra_product_actions'}
      {hook h='displayCartExtraProductActions' product=$product}
    {/block}
  </div>
</div>
