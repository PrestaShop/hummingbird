{assign var="doNotLoad" value=['paypal', 'ets_blog', 'payplug']}
{assign var="doNotPreload" value=['modules-searchbar']}

<link rel="preload" as="image" fetchpriority="high"
      href="/modules/ps_imageslider/images/1524bd27a8f5eb4436b9ff383f35232876fc010f_A4X_a_lheure_americaine_-_Pick-up_-_4x4.webp
">
<link rel="preload" as="image" fetchpriority="high"
      href="/img/logo-1717502977.webp">

{foreach $stylesheets.external as $stylesheet}
  {assign var="module_name" value=null}
  {if strstr($stylesheet.path, "/modules/")}
    {assign var="module_name" value=strstr(substr(strstr($stylesheet.path, "/modules/"), 9), "/", true)}
  {/if}

  {if !in_array($module_name, $doNotLoad)}
    {if $module_name !== null || str_starts_with($stylesheet.path, '/js/jquery') }

      {if in_array($stylesheet.id, $doNotPreload)}
        <link fetchpriority="high" rel="stylesheet" href="{$stylesheet.uri}" type="text/css" media="{$stylesheet.media}">
      {else}
        <link rel="preload" as="style" fetchpriority="low" href="{$stylesheet.uri}" media="{$stylesheet.media}" onload="this.rel='stylesheet'">
      {/if}

    {else}
      <link fetchpriority="high" rel="stylesheet" href="{$stylesheet.uri}" type="text/css" media="{$stylesheet.media}">
    {/if}
  {/if}
{/foreach}

{foreach $stylesheets.inline as $stylesheet}
  <style>
    {$stylesheet.content}
  </style>
{/foreach}
