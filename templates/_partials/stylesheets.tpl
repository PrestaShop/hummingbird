{assign var="handled" value=['index']}

<link rel="preload" as="style" onload="this.rel='stylesheet'" type="text/css" href="themes/hummingbirda4x/assets/fonts/fontello/css/v8a4x.css">

{if in_array($page.page_name, $handled)}
  {include file="stylesheets/`$page.page_name`.tpl"}
{else}
  {foreach $stylesheets.external as $stylesheet}
    {if str_starts_with($stylesheet.path, '/modules')}
      <link rel="preload" fetchpriority="low" as="style" type="text/css" href="{$stylesheet.uri}"
            media="{$stylesheet.media}" onload="this.rel='stylesheet'">
    {else}
      <link fetchpriority="high" rel="stylesheet" href="{$stylesheet.uri}" type="text/css" media="{$stylesheet.media}">
    {/if}
  {/foreach}

  {foreach $stylesheets.inline as $stylesheet}
    <style>
      {$stylesheet.content}
    </style>
  {/foreach}
{/if}
