{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<div id="js-product-list">
  {include file='catalog/_partials/productlist.tpl' products=$listing.products}

  {block name='pagination'}
    <div class="products__pagination">
      {include file='_partials/pagination.tpl' pagination=$listing.pagination}
    </div>
  {/block}
</div>
