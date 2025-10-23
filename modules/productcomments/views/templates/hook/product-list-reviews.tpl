{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<div class="product-list-review" data-ps-ref="product-list-review" data-id="{$product.id}" data-url="{$product_comment_grade_url nofilter}">
  <div class="grade-stars small-stars" data-ps-ref="grade-stars"></div>
  <div class="product-list-comments-number" data-ps-ref="product-list-comments-number">
    <span class="visually-hidden">
      {l s='Rated' d='Modules.Productcomments.Shop'} <span data-ps-ref="grade-value"></span> {l s='out of 5 stars based on ' d='Modules.Productcomments.Shop'}
    </span>
    <span data-ps-ref="number-value"></span> {l s='review(s)' d='Modules.Productcomments.Shop'}
  </div>
</div>
