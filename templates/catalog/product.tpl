{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file=$layout}

{block name='head' append}
  <meta property="og:type" content="product">
  <meta content="{$product.url}">

  {if $product.cover}
    <meta property="og:image" content="{$product.cover.large.url}">
  {/if}

  {if $product.show_price}
    <meta property="product:pretax_price:amount" content="{$product.price_tax_exc}">
    <meta property="product:pretax_price:currency" content="{$currency.iso_code}">
    <meta property="product:price:amount" content="{$product.price_amount}">
    <meta property="product:price:currency" content="{$currency.iso_code}">
  {/if}
  {if isset($product.weight) && ($product.weight != 0)}
  <meta property="product:weight:value" content="{$product.weight}">
  <meta property="product:weight:units" content="{$product.weight_unit}">
  {/if}
{/block}

{block name='head_microdata_special'}
  {include file='_partials/microdata/product-jsonld.tpl'}
{/block}

{block name='content'}
  {* FIRST PART - PHOTO, NAME, PRICES, ADD TO CART*}
  <div class="product__container product-container js-product-container" data-ps-ref="product-container">
    <div class="product__left">
      {block name='product_cover_thumbnails'}
        {include file='catalog/_partials/product-cover-thumbnails.tpl'}
      {/block}
    </div>

    <div class="product__right" data-ps-ref="product-right" tabindex="-1">
      {block name='product_header'}
        <h1 class="h2 product__name">{block name='page_title'}{$product.name}{/block}</h1>
      {/block}

      {block name='product_prices'}
        {include file='catalog/_partials/product-prices.tpl'}
      {/block}

      {block name='product_description_short'}
        <div class="product__description-short rich-text">{$product.description_short nofilter}</div>
      {/block}

      {block name='product_customization'}
        {if $product.is_customizable && count($product.customizations.fields)}
          {include file='catalog/_partials/product-customization.tpl' customizations=$product.customizations}
        {/if}
      {/block}

      <div class="product__actions js-product-actions">
        {block name='product_buy'}
          <form action="{$urls.pages.cart}" method="post" id="add-to-cart-or-refresh">
            <input type="hidden" name="token" value="{$static_token}">
            <input type="hidden" name="id_product" value="{$product.id}" id="product_page_product_id">
            <input type="hidden" name="id_customization" value="{$product.id_customization}" id="product_customization_id" class="js-product-customization-id">

            {block name='product_variants'}
              {include file='catalog/_partials/product-variants.tpl'}
            {/block}

            {block name='product_pack'}
              {include file='catalog/_partials/product-pack.tpl'}
            {/block}

            {block name='product_discounts'}
              {include file='catalog/_partials/product-discounts.tpl'}
            {/block}

            {block name='product_add_to_cart'}
              {include file='catalog/_partials/product-add-to-cart.tpl'}
            {/block}

            {block name='product_additional_info'}
              {include file='catalog/_partials/product-additional-info.tpl'}
            {/block}

            {block name='product_out_of_stock'}
              {hook h='actionProductOutOfStock' product=$product}
            {/block}

            {* Input to refresh product HTML removed, block kept for compatibility with themes *}
            {block name='product_refresh'}{/block}
          </form>
        {/block}
      </div>
    </div>
  </div>
  {* END OF FIRST PART *}

  {* SECOND PART - REASSURANCE, TABS *}
  <div class="product__bottom">
    <div class="product__bottom-left">
      {block name='product_tabs'}
        <div class="product__accordion accordion accordion-flush" id="product_accordion">
          {block name='product_description'}
            {if $product.description}
              <div class="accordion-item" id="product_description">
                <h2 class="accordion-header" id="product_description_heading">
                  <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#product_description_collapse" aria-expanded="true" aria-controls="product_description_collapse">
                    {l s='Description' d='Shop.Theme.Catalog'}
                  </button>
                </h2>

                <div id="product_description_collapse" class="accordion-collapse collapse show" aria-labelledby="product_description_heading">
                  <div class="accordion-body">
                    <div class="product__description rich-text">
                      {$product.description nofilter}
                    </div>
                  </div>
                </div>
              </div>
            {/if}
          {/block}

          {block name='product_details'}
            {include file='catalog/_partials/product-details.tpl'}
          {/block}

          {block name='product_attachments'}
            {if $product.attachments}
              <div class="info accordion-item" id="product_attachments">
                <h2 class="accordion-header" id="product_attachments_heading">
                  <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#product_attachments_collapse" aria-expanded="false" aria-controls="product_attachments_collapse">
                    {l s='Download' d='Shop.Theme.Actions'}
                  </button>
                </h2>

                <div id="product_attachments_collapse" class="accordion-collapse collapse" aria-labelledby="product_attachments_heading">
                  <div class="accordion-body">
                    <div class="product__attachments">
                      {foreach from=$product.attachments item=attachment}
                        <div class="attachment">
                          <p class="attachment__name">
                            {$attachment.name}
                          </p>

                          {if $attachment.description}
                            <p class="attachment__description">
                              {$attachment.description}
                            </p>
                          {/if}

                          <a class="attachment__link stretched-link"
                            href="{url entity='attachment' params=['id_attachment' => $attachment.id_attachment]}"
                            aria-label="{l s='Download %attachment_name%' sprintf=['%attachment_name%' => $attachment.name] d='Shop.Theme.Actions'}"
                          >
                            <i class="material-icons">&#xE2C4;</i> {l s='Download' d='Shop.Theme.Actions'} ({$attachment.file_size_formatted})
                          </a>
                        </div>
                      {/foreach}
                    </div>
                  </div>
                </div>
              </div>
            {/if}
          {/block}

          {* New collapses for module hooked content *}
          {foreach from=$product.extraContent item=extra key=extraKey}
            <div class="accordion-item" id="extra_{$extraKey}" {foreach $extra.attr as $key => $val} {$key}="{$val}"{/foreach}>
              <h2 class="accordion-header" id="product_extra_{$extraKey}_heading">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#product_extra_{$extraKey}_collapse" aria-expanded="false" aria-controls="product_extra_{$extraKey}_collapse">
                  {$extra.title}
                </button>
              </h2>

              <div id="product_extra_{$extraKey}_collapse" class="accordion-collapse collapse" data-bs-parent="#product_accordion" aria-labelledby="product_extra_{$extraKey}_heading">
                <div class="accordion-body">
                  {$extra.content nofilter}
                </div>
              </div>
            </div>
          {/foreach}
        </div>
      {/block}
    </div>

    <div class="product__bottom-right">
      {block name='hook_display_reassurance'}
        {hook h='displayReassurance'}
      {/block}
    </div>
  </div>
  {* END OF SECOND PART *}

  {block name='product_accessories'}
    {if $accessories}
      {include file='catalog/_partials/product-accessories.tpl'}
    {/if}
  {/block}

  {block name='product_footer'}
    {hook h='displayFooterProduct' product=$product category=$category}
  {/block}

  {block name='page_footer_container'}
    {block name='page_footer'}
    {/block}
  {/block}
{/block}
