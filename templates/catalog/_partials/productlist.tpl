{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{capture assign="productClasses"}{if !empty($productClass)}{$productClass}{else}col-12 col-xs-6 col-xl-4{/if}{/capture}

<div class="products{if !empty($cssClass)} {$cssClass}{else} row{/if}">
  {foreach from=$products item='product' key='position'}
    {include file='catalog/_partials/miniatures/product.tpl' product=$product position=$position productClasses=$productClasses}
  {/foreach}
</div>
