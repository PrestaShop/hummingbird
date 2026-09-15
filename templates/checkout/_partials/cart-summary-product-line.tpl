{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
{assign var='emptyImageSizes' value=['default_xs' => '', 'default_sm' => '2x']}
{assign var='imageSizes' value=['default_xs' => '', 'default_sm' => '2x']}
{$componentName = 'cart-summary-product'}

{block name='cart_summary_product_line'}
  <div class="{$componentName}">
    <div class="{$componentName}__image">
      <a href="{$product.url}" title="{$product.name}">
        {if $product.default_image}
          <picture>
            {capture name='imageSrcsetAvif'}{include file='catalog/_partials/srcset.tpl' image=$product.default_image sizes=$imageSizes srcsetVariant='avif'}{/capture}
            {if $smarty.capture.imageSrcsetAvif|trim}
              <source
                srcset="{$smarty.capture.imageSrcsetAvif|trim nofilter}"
                type="image/avif"
              >
            {/if}

            {capture name='imageSrcsetWebp'}{include file='catalog/_partials/srcset.tpl' image=$product.default_image sizes=$imageSizes srcsetVariant='webp'}{/capture}
            {if $smarty.capture.imageSrcsetWebp|trim}
              <source
                srcset="{$smarty.capture.imageSrcsetWebp|trim nofilter}"
                type="image/webp"
              >
            {/if}

            <img
              class="{$componentName}__img img-fluid"
              {capture name='imageSrcset'}{include file='catalog/_partials/srcset.tpl' image=$product.default_image sizes=$imageSizes}{/capture}
              {if $smarty.capture.imageSrcset|trim}
                srcset="{$smarty.capture.imageSrcset|trim nofilter}"
              {/if}
              width="{$product.default_image.bySize.default_xs.width}"
              height="{$product.default_image.bySize.default_xs.height}"
              loading="lazy"
              alt="{$product.name}"
              title="{$product.name}"
            >
          </picture>
        {else}
          <picture>
            {capture name='emptyImageSrcsetAvif'}{include file='catalog/_partials/srcset.tpl' image=$urls.no_picture_image sizes=$emptyImageSizes srcsetVariant='avif'}{/capture}
            {if $smarty.capture.emptyImageSrcsetAvif|trim}
              <source
                srcset="{$smarty.capture.emptyImageSrcsetAvif|trim nofilter}"
                type="image/avif"
              >
            {/if}

            {capture name='emptyImageSrcsetWebp'}{include file='catalog/_partials/srcset.tpl' image=$urls.no_picture_image sizes=$emptyImageSizes srcsetVariant='webp'}{/capture}
            {if $smarty.capture.emptyImageSrcsetWebp|trim}
              <source
                srcset="{$smarty.capture.emptyImageSrcsetWebp|trim nofilter}"
                type="image/webp"
              >
            {/if}

            <img
              class="{$componentName}__img img-fluid"
              {capture name='emptyImageSrcset'}{include file='catalog/_partials/srcset.tpl' image=$urls.no_picture_image sizes=$emptyImageSizes}{/capture}
              {if $smarty.capture.emptyImageSrcset|trim}
                srcset="{$smarty.capture.emptyImageSrcset|trim nofilter}"
              {/if}
              width="{$urls.no_picture_image.bySize.default_xs.width}"
              height="{$urls.no_picture_image.bySize.default_xs.height}"
              loading="lazy"
            >
          </picture>
        {/if}
      </a>
    </div>

    <div class="{$componentName}__content">
      <div class="{$componentName}__content-left">
        <a class="{$componentName}__link" href="{$product.url}" target="_blank" rel="noopener noreferrer nofollow">
          {$product.name}
        </a>
        
        {if !empty($product.attributes)}
          <div class="{$componentName}__attributes">
            {foreach from=$product.attributes key="attribute" item="value"}
              <div class="{$componentName}__attribute">
                <span class="label">{$attribute}:</span>
                <span class="value">{$value}</span>
              </div>
            {/foreach}
          </div>
        {/if}

        <div class="{$componentName}__price">
          <span class="label">{$product.price}</span>
          {if $product.has_discount}
            <span class="value">{$product.regular_price}</span>
          {/if}
        </div>

        {if $product.unit_price_full}
          <div class="{$componentName}__unit-price">
            <span class="value">{$product.unit_price_full}</span>
          </div>
        {/if}

        <div class="{$componentName}__quantity">
          <span class="label">{l s='Quantity:' d='Shop.Theme.Checkout'}</span>
          <span class="value">x{$product.quantity}</span>
        </div>

        <div class="{$componentName}__gift">
          {if !empty($product.is_gift)}
            <i class="{$componentName}__gift-icon material-icons" aria-hidden="true">&#xE8B1;</i> {l s='Gift(s)' d='Shop.Theme.Checkout'}
          {/if}
        </div>
      </div>

      <div class="{$componentName}__content-right">
        <div class="{$componentName}__prices">
          <div class="{$componentName}__total">{$product.total}</div>

          {hook h='displayProductPriceBlock' product=$product type="unit_price"}
        </div>
      </div>
    </div>
  </div>
{/block}
