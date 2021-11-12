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
{block name='cart_summary_product_line'}
  <div class="media-left">
    <a href="{$product.url}" title="{$product.name}">
      {if $product.default_image}
        <img class="media-object" src="{$product.default_image.small.url}" alt="{$product.name}" loading="lazy">
      {else}
        <img src="{$urls.no_picture_image.bySize.small_default.url}" loading="lazy" />
      {/if}
    </a>
  </div>
  <div class="media-body">
    <div class="media-body-top">
      <span class="product-name">
          <a href="{$product.url}" target="_blank" rel="noopener noreferrer nofollow">{$product.name}</a>
      </span>
      <span class="product-quantity">x{$product.quantity}</span>
    </div>
    {foreach from=$product.attributes key="attribute" item="value"}
      <div class="product-line-info product-line-info-secondary text-muted">
          <span class="label">{$attribute}:</span>
          <span class="value">{$value}</span>
      </div>
    {/foreach}

    <div class="media-price">
      {block name='product_flags'}
        <ul class="product-flags js-product-flags">
          {foreach from=$product.flags item=flag}
            {if $flag.type == 'discount'}
              <li class="product-flag {$flag.type}">{$flag.label}</li>
            {/if}
          {/foreach}
        </ul>
      {/block}

      <span class="product-price float-end">{$product.price}</span>
    </div>
    {hook h='displayProductPriceBlock' product=$product type="unit_price"}
    <br/>
  </div>
{/block}
