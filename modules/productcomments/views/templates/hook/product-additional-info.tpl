{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{if $nb_comments != 0 || $post_allowed == 1}
  {if $nb_comments > 0}
    <div class="product-comments-additional-info">
      <a class="js-scroll-to-reviews" href="#product-comments-list-header">
        {include file='module:productcomments/views/templates/hook/average-grade-stars.tpl' grade=$average_grade showGradeAverage=true}
      </a>
    </div>
  {else}
    {if $post_allowed}
      <button class="btn btn-outline-primary post-product-comment" id="product-additional-info-review-button" type="button" data-bs-toggle="modal" data-bs-target="#post-product-comment-modal" data-ps-ref="product-post-review-button">
        {l s='Write your review' d='Modules.Productcomments.Shop'}
      </button>
    {/if}
  {/if}
{/if}
