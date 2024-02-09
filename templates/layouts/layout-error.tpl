{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<!doctype html>
<html lang="">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">

    {block name='head_seo'}
      <title>{block name='head_seo_title'}{/block}</title>

      <meta name="description" content="{block name='head_seo_description'}{/block}">
      <meta name="keywords" content="{block name='head_seo_keywords'}{/block}">
    {/block}

    <meta name="viewport" content="width=device-width, initial-scale=1">

    {block name='stylesheets'}
      {include file='_partials/stylesheets.tpl' stylesheets=$stylesheets}
    {/block}
  </head>

  <body>
    <div id="layout-error">
      {block name='content'}
        <p>Hello world! This is HTML5 Boilerplate.</p>
      {/block}
    </div>
  </body>
</html>
