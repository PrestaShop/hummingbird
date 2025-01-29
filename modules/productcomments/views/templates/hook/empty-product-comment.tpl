{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<div id="empty-product-comment" class="product-comment-list-item py-3">
  {if $post_allowed}
    <button class="btn btn-outline-primary btn-with-icon post-product-comment">
      <i class="material-icons" aria-hidden="true">&#xE3C9;</i>
      {l s='Be the first to write your review' d='Modules.Productcomments.Shop'}
    </button>
  {else}
    {l s='No customer reviews for the moment.' d='Modules.Productcomments.Shop'}
  {/if}
</div>
