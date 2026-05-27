{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
{assign var=hasAggregateRating value=false}

{if !empty($product.productComments.averageRating) && !empty($product.productComments.nbComments)}
  {assign var=hasAggregateRating value=true}
  {assign var=ratingValue value=$product.productComments.averageRating}
  {assign var=ratingReviewCount value=$product.productComments.nbComments}
{/if}

{if !empty($ratings.avg) && !empty($nbComments)}
  {assign var=hasAggregateRating value=true}
  {assign var=ratingValue value=$ratings.avg}
  {assign var=ratingReviewCount value=$nbComments}
{/if}

{assign var=hasWeight value=false}

{if isset($product.weight) && ($product.weight != 0)}
  {assign var=hasWeight value=true}
{/if}

{assign var=hasOffers value=$product.show_price}

<script type="application/ld+json">
  {
    "@context": "https://schema.org/",
    "@type": "Product",
    "name": {$product.name|json_encode nofilter},
    "description": {$page.meta.description|json_encode nofilter},
    "category": {$product.category_name|json_encode nofilter},
    {if !empty($product.cover)}"image": {$product.cover.bySize.home_default.url|json_encode nofilter},{/if}
    "sku": {if $product.reference}{$product.reference|json_encode nofilter}{else}{$product.id|json_encode nofilter}{/if},
    "mpn": {if $product.mpn}{$product.mpn|json_encode nofilter}{elseif $product.reference}{$product.reference|json_encode nofilter}{else}{$product.id|json_encode nofilter}{/if}
    {if $product.ean13},"gtin": {$product.ean13|json_encode nofilter}{/if}
    {if $product.upc},"gtin12": {$product.upc|json_encode nofilter}{/if}
    {if isset($product_manufacturer) && $product_manufacturer->name},
    "brand": {
      "@type": "Brand",
      "name": {$product_manufacturer->name|json_encode nofilter}
    }
    {elseif $shop.name},
    "brand": {
      "@type": "Organization",
      "name": {$shop.name|json_encode nofilter}
    }
    {/if}
    {if $hasAggregateRating},
    "aggregateRating": {
      "@type": "AggregateRating",
      "ratingValue": "{$ratingValue|round:1}",
      "reviewCount": "{$ratingReviewCount}"
    }
    {/if}
    {if $hasWeight},
    "weight": {
      "@context": "https://schema.org",
      "@type": "QuantitativeValue",
      "value": "{$product.weight}",
      "unitCode": {$product.weight_unit|json_encode nofilter}
    }
    {/if}
    {if $hasOffers},
    "offers": {
      "@type": "Offer",
      "priceCurrency": {$currency.iso_code|json_encode nofilter},
      "price": "{$product.price_amount}",
      "url": {$product.url|json_encode nofilter},
      "priceValidUntil": "{($smarty.now + (int) (60*60*24*15))|date_format:"%Y-%m-%d"}",
      {if $product.images|count > 0}
        "image": {strip}[
          {foreach from=$product.images item=p_img name="p_img_list"}
            {$p_img.large.url|json_encode nofilter}{if not $smarty.foreach.p_img_list.last},{/if}
          {/foreach}
        ]{/strip},
      {/if}
      {if !empty($product.show_condition) && !empty($product.condition)}"itemCondition": {$product.condition.schema_url|json_encode nofilter},{/if}
      "availability": {$product.seo_availability|json_encode nofilter},
      "seller": {
        "@type": "Organization",
        "name": {$shop.name|json_encode nofilter}
      }
    }
    {/if}
  }
</script>
