{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{if $nb_comments != 0 || $post_allowed}
  {if $nb_comments > 0}
    <div class="product-comments-additional-info">
      <a class="js-scroll-to-reviews" href="#product-comments-list-header">
        {include file='module:productcomments/views/templates/hook/average-grade-stars.tpl' grade=$average_grade showGradeAverage=true}
      </a>
    </div>
  {else}
    {if $post_allowed}
      <button class="btn btn-outline-primary post-product-comment">
        {l s='Write your review' d='Modules.Productcomments.Shop'}
      </button>
    {/if}
  {/if}
{/if}
