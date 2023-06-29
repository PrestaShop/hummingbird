{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
 <section class="product-pack">
  <p class="h6">{l s='This pack contains' d='Shop.Theme.Catalog'}</p>

  {foreach from=$packItems item="product_pack"}
    {block name='product_miniature'}
      {include file='catalog/_partials/miniatures/pack-product.tpl' product=$product_pack showPackProductsPrice=$product.show_price}
    {/block}
  {/foreach}
</section>
