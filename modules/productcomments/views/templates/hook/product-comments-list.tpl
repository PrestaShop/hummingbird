{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<script type="text/javascript">
  var productCommentUpdatePostErrorMessage = '{l|escape:'javascript' s='Sorry, your review appreciation cannot be sent.' d='Modules.Productcomments.Shop'}';
  var productCommentAbuseReportErrorMessage = '{l|escape:'javascript' s='Sorry, your abuse report cannot be sent.' d='Modules.Productcomments.Shop'}';
</script>

<div id="product-comments-list-header">
  <div class="comments-nb">
    {l s='Comments' d='Modules.Productcomments.Shop'} ({$nb_comments})
  </div>
  {include file='module:productcomments/views/templates/hook/average-grade-stars.tpl' grade=$average_grade showGradeAverage=true showNbComments=false}
</div>

{include file='module:productcomments/views/templates/hook/product-comment-item-prototype.tpl' assign="comment_prototype"}
{include file='module:productcomments/views/templates/hook/empty-product-comment.tpl'}

<div id="product-comments-list" data-list-comments-url="{$list_comments_url nofilter}"
  data-update-comment-usefulness-url="{$update_comment_usefulness_url nofilter}"
  data-report-comment-url="{$report_comment_url nofilter}"
  data-comment-item-prototype="{$comment_prototype|escape:'html'}" data-current-page="1"
  data-total-pages="{$list_total_pages}">
</div>

<div id="product-comments-list-footer">
  <div id="product-comments-list-pagination">
    {if $list_total_pages > 0}
      <ul>
        {assign var = "prevCount" value = 0}
        <li id="pcl_page_{$prevCount}"><span class="prev"><i class="material-icons">chevron_left</i></span></li>
        {for $pageCount = 1 to $list_total_pages}
          <li id="pcl_page_{$pageCount}"><span>{$pageCount}</span></li>
        {/for}
        {assign var = "nextCount" value = $list_total_pages + 1}
        <li id="pcl_page_{$nextCount}"><span class="next"><i class="material-icons">chevron_right</i></span></li>
      </ul>
    {/if}
  </div>
  {if $post_allowed && $nb_comments != 0}
    <button class="btn btn-primary btn-with-icon post-product-comment">
      <i class="material-icons edit" data-icon="edit"></i>
      {l s='Write your review' d='Modules.Productcomments.Shop'}
    </button>
  {/if}
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
