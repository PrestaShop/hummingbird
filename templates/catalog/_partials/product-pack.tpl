{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{if $packItems}
  <section class="product__pack">
    <p class="h4">{l s='This pack contains' d='Shop.Theme.Catalog'}</p>

    <div class="product-pack__list">
      {foreach from=$packItems item="product_pack"}
        {block name='product_miniature'}
          {include file='catalog/_partials/miniatures/product-pack.tpl' product=$product_pack showPackProductsPrice=$product.show_price}
        {/block}
      {/foreach}
    </div>
  </section>
{/if}
