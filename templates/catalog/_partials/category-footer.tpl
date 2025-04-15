{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<div id="js-product-list-footer">
  {if $listing.pagination.items_shown_from == 1}
    <div class="category__footer">
      {if !empty($category.additional_description) && $listing.pagination.items_shown_from == 1}
        <div class="category__additional-description rich-text">
          {$category.additional_description nofilter}
        </div>
      {/if}
    </div>
  {/if}
</div>
