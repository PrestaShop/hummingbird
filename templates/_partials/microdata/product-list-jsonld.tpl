{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
<script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "ItemList",
    "itemListElement": [
    {$needsComma = false}
    {$position = 0}
    {foreach from=$listing.products item=item name=productsForJsonLd}
      {if $item.show_price}
        {$position = $position + 1}
        {if $needsComma},{/if}
        {$needsComma = true}
        {
          "@type": "ListItem",
          "position": {$position},
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
            {/if},
            "offers": {
              "@type": "Offer",
              "url": "{$item.url|escape:'json'}",
              "priceCurrency": "{$currency.iso_code}",
              "price": "{$item.price_amount}",
              "availability": "{$item.seo_availability}"
            }
          }
        }
      {/if}
    {/foreach}
    ]
  }
</script>
