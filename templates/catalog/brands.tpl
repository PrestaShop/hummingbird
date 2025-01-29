{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file=$layout}

{block name='content'}
  {block name='brand_header'}
    {include file='components/page-title-section.tpl' title={l s='Brands' d='Shop.Theme.Catalog'}}
  {/block}

  {block name='brand_miniature'}
    <ul class="row">
      {foreach from=$brands item=brand}
        {include file='catalog/_partials/miniatures/brand.tpl' brand=$brand}
      {/foreach}
    </ul>
  {/block}
{/block}
