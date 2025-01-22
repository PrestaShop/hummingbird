{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<div class="products">
  {foreach from=$products item='product' key='position'}
    {include file='catalog/_partials/miniatures/product.tpl' product=$product position=$position}
  {/foreach}
</div>
