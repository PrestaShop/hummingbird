{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<div id="js-product-list-footer">
    {if !empty($category.additional_description) && $listing.pagination.items_shown_from == 1}
      {$category.additional_description nofilter}
    {/if}
</div>
