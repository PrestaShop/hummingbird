{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<script type="text/javascript">
  var productCommentUpdatePostErrorMessage = '{l|escape:'javascript' s='Sorry, your review appreciation cannot be sent.' d='Modules.Productcomments.Shop'}';
  var productCommentAbuseReportErrorMessage = '{l|escape:'javascript' s='Sorry, your abuse report cannot be sent.' d='Modules.Productcomments.Shop'}';
</script>

<div class="row">
  <div class="col-md-12 col-sm-12" id="product-comments-list-header">
    <div class="comments-nb">
      <i class="material-icons" data-icon="chat" aria-hidden="true"></i>
      {l s='Comments' d='Modules.Productcomments.Shop'} ({$nb_comments})
    </div>
    {include file='module:productcomments/views/templates/hook/average-grade-stars.tpl' grade=$average_grade}
  </div>
</div>

{include file='module:productcomments/views/templates/hook/product-comment-item-prototype.tpl' assign="comment_prototype"}
{include file='module:productcomments/views/templates/hook/empty-product-comment.tpl'}
<div class="row">
  <div class="col-md-12 col-sm-12"
       id="product-comments-list"
       data-list-comments-url="{$list_comments_url nofilter}"
       data-update-comment-usefulness-url="{$update_comment_usefulness_url nofilter}"
       data-report-comment-url="{$report_comment_url nofilter}"
       data-comment-item-prototype="{$comment_prototype|escape:'html'}">
  </div>
</div>
<div class="row">
  <div class="col-md-12 col-sm-12" id="product-comments-list-footer">
    <div id="product-comments-list-pagination"></div>
    {if $post_allowed && $nb_comments != 0}
      <button class="btn btn-primary btn-with-icon post-product-comment">
        <i class="material-icons" data-icon="edit" aria-hidden="true"></i>
        {l s='Write your review' d='Modules.Productcomments.Shop'}
      </button>
    {/if}
  </div>
</div>

{* Appreciation post error modal *}
{include file='module:productcomments/views/templates/hook/alert-modal.tpl'
  modal_id='update-comment-usefulness-post-error'
  modal_title={l s='Your review appreciation cannot be sent' d='Modules.Productcomments.Shop'}
  icon='error'
}

{* Confirm report modal *}
{include file='module:productcomments/views/templates/hook/confirm-modal.tpl'
  modal_id='report-comment-confirmation'
  modal_title={l s='Report comment' d='Modules.Productcomments.Shop'}
  modal_message={l s='Are you sure that you want to report this comment?' d='Modules.Productcomments.Shop'}
  icon='feedback'
}

{* Report comment posted modal *}
{include file='module:productcomments/views/templates/hook/alert-modal.tpl'
  modal_id='report-comment-posted'
  modal_title={l s='Report sent' d='Modules.Productcomments.Shop'}
  modal_message={l s='Your report has been submitted and will be considered by a moderator.' d='Modules.Productcomments.Shop'}
}

{* Report abuse error modal *}
{include file='module:productcomments/views/templates/hook/alert-modal.tpl'
  modal_id='report-comment-post-error'
  modal_title={l s='Your report cannot be sent' d='Modules.Productcomments.Shop'}
  icon='error'
}
