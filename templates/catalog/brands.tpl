{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file=$layout}

{block name='content'}
  {block name='brand_header'}
    <h1 class="h1 mb-4">{l s='Brands' d='Shop.Theme.Catalog'}</h1>
  {/block}

  {block name='brand_miniature'}
    <ul class="row">
      {foreach from=$brands item=brand}
        {include file='catalog/_partials/miniatures/brand.tpl' brand=$brand}
      {/foreach}
    </ul>
  {/block}
{/block}
