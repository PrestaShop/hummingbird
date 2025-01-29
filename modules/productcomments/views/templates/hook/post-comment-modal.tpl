{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<script type="text/javascript">
  var productCommentPostErrorMessage = '{l s='Sorry, your review cannot be posted.' d='Modules.Productcomments.Shop' js=1}';
  var productCommentMandatoryMessage = '{l s='Please choose a rating for your review.' d='Modules.Productcomments.Shop' js=1}';
  var ratingChosen = false;  
</script>

<div id="post-product-comment-modal" class="modal fade product-comment-modal" role="dialog" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <form class="modal-content" id="post-product-comment-form" action="{$post_comment_url nofilter}" method="POST">
      <div class="modal-header">
        <p class="h4 mb-0">{l s='Write your review' d='Modules.Productcomments.Shop'}</p>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <div class="modal-body">
        <div class="row">
          <div class="col-12 col-sm-2 mb-4">
            {if isset($product) && $product}
              {block name='product_cover'}
                <div class="product__cover">
                  {if !empty($product.cover)}
                    <picture>
                      {if isset($product.cover.bySize.default_xs.sources.avif)}
                        <source 
                          srcset="
                            {$product.cover.bySize.default_xs.sources.avif},
                            {$product.cover.bySize.default_m.sources.avif} 2x"
                          type="image/avif"
                        >
                      {/if}

                      {if isset($product.cover.bySize.default_xs.sources.webp)}
                        <source 
                          srcset="
                            {$product.cover.bySize.default_xs.sources.webp},
                            {$product.cover.bySize.default_m.sources.webp} 2x"
                          type="image/webp"
                        >
                      {/if}

                      <img
                        class="js-qv-product-cover rounded img-fluid"
                        srcset="
                          {$product.cover.bySize.default_xs.url},
                          {$product.cover.bySize.default_m.url} 2x"
                        loading="lazy"
                        width="{$product.cover.bySize.default_xs.width}"
                        height="{$product.cover.bySize.default_xs.height}"
                        alt="{$product.cover.legend}"
                        title="{$product.cover.legend}"
                      >
                    </picture>
                  {else}
                    <picture>
                      {if isset($urls.no_picture_image.bySize.default_xs.sources.avif)}
                        <source 
                          srcset="
                            {$urls.no_picture_image.bySize.default_xs.sources.avif},
                            {$urls.no_picture_image.bySize.default_m.sources.avif} 2x"
                          type="image/avif"
                        >
                      {/if}

                      {if isset($urls.no_picture_image.bySize.default_xs.sources.webp)}
                        <source 
                          srcset="
                            {$urls.no_picture_image.bySize.default_xs.sources.webp},
                            {$urls.no_picture_image.bySize.default_m.sources.webp} 2x"
                          type="image/webp"
                        >
                      {/if}

                      <img
                        class="rounded img-fluid"
                        srcset="
                          {$urls.no_picture_image.bySize.default_xs.url},
                          {$urls.no_picture_image.bySize.default_m.url} 2x"
                        width="{$urls.no_picture_image.bySize.default_xs.width}"
                        height="{$urls.no_picture_image.bySize.default_xs.height}"
                        loading="lazy"
                      >
                    </picture>
                  {/if}
                </div>
              {/block}
            {/if}
          </div>

          <div class="col-12 col-sm-10">
            <p class="product__title">{$product.name}</p>
            {block name='product_description_short'}
              <div class="product__description" itemprop="description">{$product.description_short nofilter}</div>
            {/block}
          </div>

          <div class="col-12">
            {if $criterions|@count > 0}
              <ul id="criterions_list">
                {foreach from=$criterions item='criterion'}
                  <li class="mb-2">
                    <div class="criterion-rating">
                      <label>
                        {$criterion.name|escape:'html':'UTF-8'}<sup class="required text-danger">*</sup>
                      </label>
                      
                      <div
                        class="grade-stars"
                        data-grade="3"
                        data-input="criterion[{$criterion.id_product_comment_criterion}]">
                      </div>
                    </div>
                  </li>
                {/foreach}
              </ul>
            {/if}
          </div>
        </div>

        <div class="row">
          {if !$logged}
            <div class="col-sm-8 mb-3">
              <label class="form-label" for="comment_title">{l s='Title' d='Modules.Productcomments.Shop'}<sup class="required">*</sup></label>
              <input class="form-control" name="comment_title" type="text" value=""/>
            </div>
            <div class="col-sm-4 mb-3">
              <label class="form-label" for="customer_name">{l s='Your name' d='Modules.Productcomments.Shop'}<sup class="required">*</sup></label>
              <input class="form-control" name="customer_name" type="text" value=""/>
            </div>
          {else}
            <div class="mb-3">
              <label class="form-label" for="comment_title">{l s='Title' d='Modules.Productcomments.Shop'}<sup class="required">*</sup></label>
              <input class="form-control" name="comment_title" type="text" value=""/>
            </div>
          {/if}
        </div>

        <div class="mb-3">
          <label class="form-label" for="comment_content">{l s='Review' d='Modules.Productcomments.Shop'}<sup class="required">*</sup></label>
          <textarea class="form-control" name="comment_content"></textarea>
        </div>
        
        {capture name='gdprContent'}{hook h='displayGDPRConsent' mod='psgdpr' id_module=$id_module}{/capture}
        {if $smarty.capture.gdprContent != ''}
          <div class="mb-3">
            {$smarty.capture.gdprContent nofilter}
          </div>
        {/if}
      </div>

      <div class="modal-footer">
        <p><sup>*</sup> {l s='Required fields' d='Modules.Productcomments.Shop'}</p>
        <div class="d-flex flex-wrap w-100 w-md-auto">
          <button type="button" class="btn btn-outline-primary me-0 me-md-2 w-md-auto w-100" data-bs-dismiss="modal" aria-label="{l s='Cancel' d='Modules.Productcomments.Shop'}">
            {l s='Cancel' d='Modules.Productcomments.Shop'}
          </button>
          <button type="submit" class="btn btn-primary w-md-auto w-100 mb-3 mb-md-0 order-first order-md-last">
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
  modal_id='product-comment-posted-modal'
  modal_title={l s='Review sent' d='Modules.Productcomments.Shop'}
  modal_message=$comment_posted_message
}

{* Comment post error modal *}
{include file='module:productcomments/views/templates/hook/alert-modal.tpl'
  modal_id='product-comment-post-error'
  modal_title={l s='Your review cannot be sent' d='Modules.Productcomments.Shop'}
  icon='error'
}
