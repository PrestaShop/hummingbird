{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<div class="product-comment-list-item comment" data-product-comment-id="@COMMENT_ID@" data-product-id="@PRODUCT_ID@">
  <div class="comment-top">
    <div class="comment-author">
      @CUSTOMER_NAME@
    </div>

    <div class="comment-date">
      @COMMENT_DATE@
    </div>
  </div>

  <div class="comment-infos">
    <div class="grade-stars" data-grade="@COMMENT_GRADE@"></div>
    <p class="comment-title">@COMMENT_TITLE@</p>
  </div>

  <div class="comment-content">
    <p class="comment-text">@COMMENT_COMMENT@</p>
  </div>

  <div class="comment-buttons">
    {if $usefulness_enabled}
      <a class="useful-review">
        <i class="material-icons thumb_up" data-icon="thumb_up"></i>
        <span class="useful-review-value">@COMMENT_USEFUL_ADVICES@</span>
      </a>
      <a class="not-useful-review">
        <i class="material-icons thumb_down" data-icon="thumb_down"></i>
        <span class="not-useful-review-value">@COMMENT_NOT_USEFUL_ADVICES@</span>
      </a>
    {/if}
    <a class="report-abuse" title="{l s='Report abuse' d='Modules.Productcomments.Shop'}">
      <i class="material-icons flag" data-icon="flag"></i> {l s='Report abuse' d='Modules.Productcomments.Shop'}
    </a>
  </div>
</div>
