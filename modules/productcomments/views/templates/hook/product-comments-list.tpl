{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<div class="product-comments-wrapper">
  <script type="text/javascript">
    var productCommentUpdatePostErrorMessage = '{l|escape:'javascript' s='Sorry, your review appreciation cannot be sent.' d='Modules.Productcomments.Shop'}';
    var productCommentAbuseReportErrorMessage = '{l|escape:'javascript' s='Sorry, your abuse report cannot be sent.' d='Modules.Productcomments.Shop'}';
  </script>

  <div id="product-comments-list-header">
    <h2 class="section-title">{l s='Comments' d='Modules.Productcomments.Shop'}
      ({$nb_comments})</h2>
    {include file='module:productcomments/views/templates/hook/average-grade-stars.tpl' grade=$average_grade showGradeAverage=true showNbComments=false}
  </div>

  {if $nb_comments > 0 && $post_allowed}
    <div id="product-comments-list-btn-group">
      <button class="w-100 w-sm-auto btn btn-outline-primary post-product-comment" id="product-comments-list-review-button" type="button" data-bs-toggle="modal" data-bs-target="#post-product-comment-modal" data-ps-ref="product-post-review-button">
        {l s='Write your review' d='Modules.Productcomments.Shop'}
      </button>
    </div>
  {elseif $nb_comments == 0}
    {include file='module:productcomments/views/templates/hook/empty-product-comment.tpl'}
  {/if}

  {include file='module:productcomments/views/templates/hook/product-comment-item-prototype.tpl' assign="comment_prototype"}

  <div id="product-comments-list" class="{if $nb_comments > 0}has-comments{/if}"
    data-ps-ref="product-comments-list"
    data-list-comments-url="{$list_comments_url nofilter}"
    data-update-comment-usefulness-url="{$update_comment_usefulness_url nofilter}"
    data-report-comment-url="{$report_comment_url nofilter}"
    data-comment-item-prototype="{$comment_prototype}"
    data-current-page="1"
    data-total-pages="{$list_total_pages}"></div>

  {if $list_total_pages > 1}
    <div id="product-comments-list-footer">
      <nav id="product-comments-list-pagination" data-ps-ref="product-comments-pagination">
        <ul class="pagination justify-content-center">
          <li class="page-item disabled" data-ps-ref="pagination-item" data-ps-action="prev">
            <button class="page-link btn prev" aria-label="{l s='Previous' d='Shop.Theme.Actions'}"><i class="material-icons">chevron_left</i></button>
          </li>
          {for $pageCount = 1 to $list_total_pages}
            <li class="page-item {if $pageCount == 1}active{/if}" data-ps-ref="pagination-item" data-ps-action="page" data-ps-data="{$pageCount}">
              <button class="page-link btn" {if $pageCount == 1}aria-current="page"{/if}>{$pageCount}</button>
            </li>
          {/for}
          <li class="page-item" data-ps-ref="pagination-item" data-ps-action="next">
            <button class="page-link btn next" aria-label="{l s='Next' d='Shop.Theme.Actions'}"><i class="material-icons">chevron_right</i></button>
          </li>
        </ul>
      </nav>
    </div>
  {/if}

  {* Appreciation post error modal *}
  {include file='module:productcomments/views/templates/hook/alert-modal.tpl'
    modal_id='update-comment-usefulness-post-error'
    data_ps_ref='update-comment-usefulness-post-error'
    modal_title={l s='Your review appreciation cannot be sent' d='Modules.Productcomments.Shop'}
    icon='error'
  }

  {* Confirm report modal *}
  {include file='module:productcomments/views/templates/hook/confirm-modal.tpl'
    modal_id='report-comment-confirmation'
    data_ps_ref='report-comment-confirmation'
    modal_title={l s='Report comment' d='Modules.Productcomments.Shop'}
    modal_message={l s='Are you sure that you want to report this comment?' d='Modules.Productcomments.Shop'}
    icon='feedback'
  }

  {* Report comment posted modal *}
  {include file='module:productcomments/views/templates/hook/alert-modal.tpl'
    modal_id='report-comment-posted'
    data_ps_ref='report-comment-post-success'
    modal_title={l s='Report sent' d='Modules.Productcomments.Shop'}
    modal_message={l s='Your report has been submitted and will be considered by a moderator.' d='Modules.Productcomments.Shop'}
  }

  {* Report abuse error modal *}
  {include file='module:productcomments/views/templates/hook/alert-modal.tpl'
    modal_id='report-comment-post-error'
    data_ps_ref='report-comment-post-error'
    modal_title={l s='Your report cannot be sent' d='Modules.Productcomments.Shop'}
    icon='error'
  }
</div>
