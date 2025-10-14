{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<div class="product-comment-list-item comment" data-ps-ref="product-comment-item" data-product-comment-id="@COMMENT_ID@" data-product-id="@PRODUCT_ID@">
  <div class="comment__top">
    <div class="comment__author">
      @CUSTOMER_NAME@
    </div>

    <div class="comment__date">
      @COMMENT_DATE@
    </div>
  </div>

  <div class="comment__infos">
    <div class="grade-stars" data-ps-ref="grade-stars" data-grade="@COMMENT_GRADE@"></div>
    <p class="comment__title">@COMMENT_TITLE@</p>
  </div>

  <div class="comment__content">
    <p class="comment__text">@COMMENT_COMMENT@</p>
  </div>

  <div class="comment__buttons">
    {if $usefulness_enabled}
      <button class="useful-review btn btn-sm btn-outline-primary" data-ps-ref="useful-review">
        <i class="material-icons thumb_up fs-6" aria-hidden="true" data-icon="thumb_up"></i>
        <span class="useful-review-value" data-ps-ref="useful-review-value">@COMMENT_USEFUL_ADVICES@</span>
      </button>
      <button class="not-useful-review btn btn-sm btn-outline-primary" data-ps-ref="not-useful-review">
        <i class="material-icons thumb_down fs-6" aria-hidden="true" data-icon="thumb_down"></i>
        <span class="not-useful-review-value" data-ps-ref="not-useful-review-value">@COMMENT_NOT_USEFUL_ADVICES@</span>
      </button>
    {/if}
    <button class="report-abuse btn btn-sm btn-outline-primary" data-ps-ref="report-abuse" title="{l s='Report abuse' d='Modules.Productcomments.Shop'}">
      <i class="material-icons flag fs-6" aria-hidden="true" data-icon="flag"></i> {l s='Report abuse' d='Modules.Productcomments.Shop'}
    </button>
  </div>
</div>
