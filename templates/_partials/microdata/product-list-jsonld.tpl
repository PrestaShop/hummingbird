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
            "name": {$item.name|json_encode nofilter},
            "url": {$item.url|json_encode nofilter}
            {if !empty($item.cover) && isset($item.cover.bySize.default_md.url)},
            "image": {$item.cover.bySize.default_md.url|json_encode nofilter}
            {/if}
            {if !empty($item.description_short)},
            "description": {$item.description_short|strip_tags|json_encode nofilter}
            {/if}
            {if !empty($item.manufacturer_name)},
            "brand": {
              "@type": "Brand",
              "name": {$item.manufacturer_name|json_encode nofilter}
            }
            {/if},
            "offers": {
              "@type": "Offer",
              "url": {$item.url|json_encode nofilter},
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
