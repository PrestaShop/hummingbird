{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "Organization",
    "name" : "{$shop.name}",
    "url" : "{$urls.pages.index}",
    {if $shop.logo_details}
      "logo": {
        "@type": "ImageObject",
        "url":"{$shop.logo_details.src}"
      }
    {/if}
  }
</script>

<script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "WebPage",
    "isPartOf": {
      "@type": "WebSite",
      "url":  "{$urls.pages.index}",
      "name": "{$shop.name}"
    },
    "name": "{$page.meta.title}",
    "url":  "{$urls.current_url}"
  }
</script>

{if $page.page_name == 'index'}
  <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@type": "WebSite",
      "url" : "{$urls.pages.index}",
      "image": {
        "@type": "ImageObject",
        "url":"{$shop.logo_details.src}"
      },
      "potentialAction": {
        "@type": "SearchAction",
        "target": "{'--search_term_string--'|str_replace:'{search_term_string}':$link->getPageLink('search',true,null,['search_query'=>'--search_term_string--'])}",
        "query-input": "required name=search_term_string"
      }
    }
  </script>
{/if}

{if isset($breadcrumb.links[1])}
  <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@type": "BreadcrumbList",
      "itemListElement": [
        {foreach from=$breadcrumb.links item=path name=breadcrumb}
          {
            "@type": "ListItem",
            "position": {$smarty.foreach.breadcrumb.iteration},
            "name": "{$path.title}",
            "item": "{$path.url}"
            }{if !$smarty.foreach.breadcrumb.last},{/if}
          {/foreach}]
        }
  </script>
{/if}
