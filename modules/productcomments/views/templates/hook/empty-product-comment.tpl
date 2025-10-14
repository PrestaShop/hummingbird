{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<div id="empty-product-comment" data-ps-ref="empty-product-comment" class="product-comment-list-item py-3">
  {if $post_allowed == 1}
    <button class="btn btn-outline-primary post-product-comment" id="product-footer-review-button" type="button" data-bs-toggle="modal" data-bs-target="#post-product-comment-modal" data-ps-ref="product-post-review-button">
      {l s='Be the first to write your review' d='Modules.Productcomments.Shop'}
    </button>
  {else}
    {l s='No customer reviews for the moment.' d='Modules.Productcomments.Shop'}
  {/if}
</div>
