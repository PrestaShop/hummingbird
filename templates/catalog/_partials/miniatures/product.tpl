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
{$componentName = 'product-miniature'}

{block name='product_miniature_item'}
  <article class="{$componentName} js-{$componentName} col-md-3">
    <div class="card">
      <a href="{$product.url}" class="{$componentName}-link">
        {include file='catalog/_partials/product-flags.tpl'}

        {block name='product_miniature_image'}
          <div class="{$componentName}-image-container">
            {if $product.cover}
              <img
                src="{$product.cover.bySize.home_default.url}"
                alt="{if !empty($product.cover.legend)}{$product.cover.legend}{else}{$product.name|truncate:30:'...'}{/if}"
                loading="lazy"
                data-full-size-image-url="{$product.cover.large.url}"
                width="250"
                height="250"
                class="{$componentName}-image card-img-top"
              />
            {else}
              <img
                src="{$urls.no_picture_image.bySize.home_default.url}"
                loading="lazy"
                width="250"
                height="250"
                class="{$componentName}-image card-img-top"
              />
            {/if}
          </div>
        {/block}
      </a>

      {block name='product_miniature_bottom'}
        <div class="{$componentName}-infos card-body">
          {block name='quick_view'}
            <button class="{$componentName}-quickview" data-link-action="quickview">
              <i class="material-icons search">remove_red_eye</i> {l s='Quick view' d='Shop.Theme.Actions'}
            </button>
          {/block}

          <div class="{$componentName}-infos-top">
            {block name='product_name'}
              <a href="{$product.url}"><p class="{$componentName}-title">{$product.name|truncate:30:'...'}</p></a>
            {/block}

            {block name='product_discount_price'}
              {if $product.show_price}
                <div class="{$componentName}-discount-price">
                  {if $product.has_discount}
                    {hook h='displayProductPriceBlock' product=$product type="old_price"}

                    <span class="{$componentName}-regular-price" aria-label="{l s='Regular price' d='Shop.Theme.Catalog'}">{$product.regular_price}</span>
                  {/if}
                </div>
              {/if}
            {/block}
          </div>

          <div class="{$componentName}-infos-bottom">
            {block name='product_variants'}
              <div class="{$componentName}-variants">
                {if $product.main_variants}
                  {include file='catalog/_partials/variant-links.tpl' variants=$product.main_variants}
                {/if}
              </div>
            {/block}

            {block name='product_price'}
              {if $product.show_price}
                {hook h='displayProductPriceBlock' product=$product type="before_price"}

                <span class="{$componentName}-price" aria-label="{l s='Price' d='Shop.Theme.Catalog'}">
                  {capture name='custom_price'}{hook h='displayProductPriceBlock' product=$product type='custom_price' hook_origin='products_list'}{/capture}
                  {if '' !== $smarty.capture.custom_price}
                    {$smarty.capture.custom_price nofilter}
                  {else}
                    {$product.price}
                  {/if}
                </span>

                {hook h='displayProductPriceBlock' product=$product type='unit_price'}

                {hook h='displayProductPriceBlock' product=$product type='weight'}
              {/if}
            {/block}
          </div>
        </div>
      {/block}
    </div>
  </article>
{/block}
