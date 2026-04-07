{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
<script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "ItemList",
    "itemListElement": [
    {foreach from=$listing.products item=item name=productsForJsonLd}
      {
        "@type": "ListItem",
        "position": {$smarty.foreach.productsForJsonLd.iteration},
        "item": {
          "@type": "Product",
          "name": "{$item.name|escape:'json'}",
          "url": "{$item.url|escape:'json'}"
          {if !empty($item.cover) && isset($item.cover.bySize.default_md.url)},
          "image": "{$item.cover.bySize.default_md.url|escape:'json'}"
          {/if}
          {if !empty($item.description_short)},
          "description": "{$item.description_short|strip_tags|escape:'json'}"
          {/if}
          {if isset($item.manufacturer_name) && !empty($item.manufacturer_name)},
          "brand": {
            "@type": "Brand",
            "name": "{$item.manufacturer_name|escape:'json'}"
          }
          {/if}
          {if $item.show_price},
          "offers": {
            "@type": "Offer",
            "url": "{$item.url|escape:'json'}",
            "priceCurrency": "{$currency.iso_code}",
            "price": "{$item.price_amount}",
            "availability": "{$item.seo_availability}"
          }
          {/if}
        }
      }{if !$smarty.foreach.productsForJsonLd.last},{/if}
    {/foreach}
    ]
  }
</script>
