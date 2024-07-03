{assign var="excluded_modules" value=['ps_emailalerts', 'ets_blog', 'ets_extraoptions', 'payplug']}
{assign var="doNotDefer" value=['corejs']}

<link fetchpriority="high" rel="preload" as="script" href="/themes/core.js">

{foreach $javascript.external as $js}
  {assign var="module_name" value=null}
  {if strstr($js.path, "/modules/")}
    {assign var="module_name" value=strstr(substr(strstr($js.path, "/modules/"), 9), "/", true)}
  {/if}

  {if !in_array($module_name, $excluded_modules)}
    <script type="text/javascript"
            src="{$js.uri}" {$js.attribute} {if !in_array($js.id, $doNotDefer)}{/if}></script>
  {/if}

{*  <script type="text/javascript" src="{$js.uri}" {$js.attribute}></script>*}
{/foreach}

{foreach $javascript.inline as $js}
  <script type="text/javascript" >
    {$js.content nofilter}
  </script>
{/foreach}

{if isset($vars) && $vars|@count}
  <script type="text/javascript" >
    {foreach from=$vars key=var_name item=var_value}
    var {$var_name} = {$var_value|json_encode nofilter};
    {/foreach}
  </script>
{/if}
