{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<script type="text/javascript">
  var productCommentPostErrorMessage = '{l s='Sorry, your review cannot be posted.' d='Modules.Productcomments.Shop' js=1}';
  var productCommentMandatoryMessage = '{l s='Please choose a rating for your review.' d='Modules.Productcomments.Shop' js=1}';
  var ratingChosen = false;
</script>

<div id="post-product-comment-modal" class="modal fade product-comment-modal" tabindex="-1" aria-labelledby="product-post-review-modal-title" aria-hidden="true" data-ps-ref="product-post-review-modal">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
    <form class="modal-content" id="post-product-comment-form" action="{$post_comment_url nofilter}" method="POST" data-ps-ref="product-post-review-form" data-ps-action="form-validation">
      <div class="modal-header">
        <p class="h2 modal-title" id="product-post-review-modal-title">{l s='Write your review' d='Modules.Productcomments.Shop'}</p>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <div class="modal-body">
        <div class="row">
          <div class="col-12 col-sm-2 mb-4">
            {if isset($product) && $product}
              {block name='product_cover'}
                <div class="product-cover">
                  {if !empty($product.cover)}
                    <picture>
                      {if isset($product.cover.bySize.default_xs.sources.avif)}
                        <source srcset="
                           {$product.cover.bySize.default_xs.sources.avif},
                           {$product.cover.bySize.default_md.sources.avif} 2x"
                          type="image/avif">
                      {/if}

                      {if isset($product.cover.bySize.default_xs.sources.webp)}
                        <source srcset="
                           {$product.cover.bySize.default_xs.sources.webp},
                           {$product.cover.bySize.default_md.sources.webp} 2x"
                          type="image/webp">
                      {/if}

                      <img class="js-qv-product-cover rounded img-fluid" srcset="
                         {$product.cover.bySize.default_xs.url},
                         {$product.cover.bySize.default_md.url} 2x" loading="lazy"
                        width="{$product.cover.bySize.default_xs.width}"
                        height="{$product.cover.bySize.default_xs.height}"
                        alt="{$product.cover.legend}"
                        title="{$product.cover.legend}">
                    </picture>
                  {else}
                    <picture>
                      {if isset($urls.no_picture_image.bySize.default_xs.sources.avif)}
                        <source srcset="
                           {$urls.no_picture_image.bySize.default_xs.sources.avif},
                           {$urls.no_picture_image.bySize.default_md.sources.avif} 2x"
                          type="image/avif">
                      {/if}

                      {if isset($urls.no_picture_image.bySize.default_xs.sources.webp)}
                        <source srcset="
                           {$urls.no_picture_image.bySize.default_xs.sources.webp},
                           {$urls.no_picture_image.bySize.default_md.sources.webp} 2x"
                          type="image/webp">
                      {/if}

                      <img class="rounded img-fluid" srcset="
                         {$urls.no_picture_image.bySize.default_xs.url},
                         {$urls.no_picture_image.bySize.default_md.url} 2x"
                        width="{$urls.no_picture_image.bySize.default_xs.width}"
                        height="{$urls.no_picture_image.bySize.default_xs.height}" loading="lazy">
                    </picture>
                  {/if}
                </div>
              {/block}
            {/if}
          </div>

          <div class="col-12 col-sm-10">
            <p class="h5">{$product.name}</p>
            {block name='product_description_short'}
              <div itemprop="description">{$product.description_short nofilter}</div>
            {/block}
          </div>

          <div class="col-12">
            {if $criterions|@count > 0}
              <ul id="criterions_list" data-ps-ref="criterions-list">
                {foreach from=$criterions item='criterion'}
                  <li {if !$criterion@last}class="mb-2"{/if}>
                    <fieldset class="star-rating-group" aria-labelledby="rating-label-{$criterion.id_product_comment_criterion}">
                      <legend id="rating-label-{$criterion.id_product_comment_criterion}" class="form-label required">
                        <span class="visually-hidden">{l s='Rating for ' d='Modules.Productcomments.Shop'}</span>
                        {$criterion.name|escape:'html':'UTF-8'}
                      </legend>

                      <div class="form-check stars-selector" aria-labelledby="rating-label-{$criterion.id_product_comment_criterion}">
                        {for $i=1 to 5 step 1}
                          <input
                            class="stars-selector__input visually-hidden"
                            type="radio"
                            id="star-{$i}-criterion-{$criterion.id_product_comment_criterion}" 
                            name="criterion[{$criterion.id_product_comment_criterion}]"
                            value="{$i}"
                            {if $i == 1}
                              aria-label="{l s='%s star out of 5' sprintf=[$i] d='Modules.Productcomments.Shop'}"
                            {else}
                              aria-label="{l s='%s stars out of 5' sprintf=[$i] d='Modules.Productcomments.Shop'}"
                            {/if}
                            required
                          >
                          <label class="stars-selector__input-label" for="star-{$i}-criterion-{$criterion.id_product_comment_criterion}" aria-hidden="true"></label>
                        {/for}
                        <div class="invalid-feedback">{l s='Please choose a rating for your review.' d='Modules.Productcomments.Shop'}</div>
                      </div>
                    </fieldset>
                  </li>
                {/foreach}
              </ul>
            {/if}
          </div>
        </div>

        <div class="row">
          {if !$logged}
            <div class="col-sm-8 mb-3">
              <label class="form-label required" for="comment_title">{l s='Title of your review' d='Modules.Productcomments.Shop'} </label>
              <input class="form-control" name="comment_title" id="comment_title" type="text" value="" required>
            </div>

            <div class="col-sm-4 mb-3">
              <label class="form-label required" for="customer_name">{l s='Your name' d='Modules.Productcomments.Shop'} </label>
              <input class="form-control" name="customer_name" id="customer_name" type="text" value="" required>
            </div>
          {else}
            <div class="mb-3">
              <label class="form-label required" for="comment_title">{l s='Title of your review' d='Modules.Productcomments.Shop'} </label>
              <input class="form-control" name="comment_title" id="comment_title" type="text" value="" required>
            </div>
          {/if}
        </div>

        <div class="mb-3">
          <label class="form-label required" for="comment_content">{l s='Your review' d='Modules.Productcomments.Shop'} </label>
          <textarea class="form-control" name="comment_content" id="comment_content" required></textarea>
        </div>

        {capture name='gdprContent'}{hook h='displayGDPRConsent' mod='psgdpr' id_module=$id_module}{/capture}
        {if $smarty.capture.gdprContent != ''}
          <div class="mb-3">
            {$smarty.capture.gdprContent nofilter}
          </div>
        {/if}
      </div>

      <div class="modal-footer">
        <p class="required">
          <sup class="text-danger">*</sup> {l s='Required fields' d='Modules.Productcomments.Shop'}
        </p>

        <div class="post-comment-buttons d-flex flex-wrap gap-2 w-100 w-md-auto">
          <button type="button" class="btn btn-outline-primary w-md-auto w-100" data-bs-dismiss="modal"
            aria-label="{l s='Cancel' d='Modules.Productcomments.Shop'}">
            {l s='Cancel' d='Modules.Productcomments.Shop'}
          </button>

          <button type="submit" class="btn btn-primary w-100 w-md-auto order-first order-md-last" aria-label="{l s='Send review' d='Modules.Productcomments.Shop'}" data-ps-action="form-validation-submit">
            {l s='Send' d='Modules.Productcomments.Shop'}
          </button>
        </div>
      </div>
    </form>
  </div>
</div>

{* Comment posted modal *}
{if $moderation_active}
  {assign var='comment_posted_message' value={l s='Your comment has been submitted and will be available once approved by a moderator.' d='Modules.Productcomments.Shop'}}
{else}
  {assign var='comment_posted_message' value={l s='Your comment has been added!' d='Modules.Productcomments.Shop'}}
{/if}

{include file='module:productcomments/views/templates/hook/alert-modal.tpl'
  modal_id='product-post-review-posted-modal'
  modal_title={l s='Review sent' d='Modules.Productcomments.Shop'}
  modal_message=$comment_posted_message
}

{* Comment post error modal *}
{include file='module:productcomments/views/templates/hook/alert-modal.tpl'
  modal_id='product-post-review-error-modal'
  modal_title={l s='Your review cannot be sent' d='Modules.Productcomments.Shop'}
  icon='error'
}
