{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{if $nb_comments != 0 || $post_allowed}
  <div class="product-comments-additional-info">
    {if $nb_comments == 0}
      {if $post_allowed}
        <button class="btn btn-outline-primary btn-with-icon post-product-comment">
          <i class="material-icons edit" data-icon="edit"></i>
          {l s='Write your review' d='Modules.Productcomments.Shop'}
        </button>
      {/if}
    {else}
      {include file='module:productcomments/views/templates/hook/average-grade-stars.tpl' grade=$average_grade showGradeAverage=true}
      <div class="additional-links">
        <a class="link-comment" href="#product-comments-list-header">
          <i class="material-icons chat" data-icon="chat"></i>
          {l s='Read user reviews' d='Modules.Productcomments.Shop'} ({$nb_comments})
        </a>
        {if $post_allowed}
          <a class="link-comment post-product-comment" href="#product-comments-list-header">
            <i class="material-icons edit" data-icon="edit"></i>
            {l s='Write your review' d='Modules.Productcomments.Shop'}
          </a>
        {/if}
      </div>
    {/if}
  </div>
{/if}
