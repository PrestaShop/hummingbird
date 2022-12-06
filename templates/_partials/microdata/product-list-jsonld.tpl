{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
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
        "name": "{$item.name}",
        "url": "{$item.url}"
      }{if !$smarty.foreach.productsForJsonLd.last},{/if}
    {/foreach}
    ]
  }
</script>
