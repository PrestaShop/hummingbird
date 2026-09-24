{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
{**
 * $hideOutOfStockFlag lets a caller that already renders the stock label drop the flag saying the same
 * thing. Filtering first so an empty list renders no list at all.
 *}
{assign 'visibleFlags' []}
{foreach from=$product.flags|default:[] item=flag}
  {if !($hideOutOfStockFlag|default:false) || $flag.type != 'out_of_stock'}
    {append 'visibleFlags' $flag}
  {/if}
{/foreach}

{if !empty($visibleFlags)}
  {block name='product_flags'}
    <ul class="product-flags js-product-flags">
      {foreach from=$visibleFlags item=flag}
        <li class="badge {$flag.type}">{$flag.label nofilter}</li>
      {/foreach}
    </ul>
  {/block}
{/if}
