
{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$componentName = 'product-customization-modal'}

<div class="{$componentName}__content">
  {assign var=customization_modal_id value="{$componentName}--{$product.id_customization|intval}"}

  <button type="button" class="btn btn-sm btn-outline-primary mb-2"
    data-bs-toggle="modal"
    data-bs-target="#{$customization_modal_id}"
  >
    {l s='Customized' d='Shop.Theme.Checkout'}
  </button>

  <div class="modal fade" id="{$customization_modal_id}" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-fullscreen-sm-down">
      <div class="modal-content">
        <div class="modal-header">
          <p class="h5 modal-title">{l s='Product customization' d='Shop.Theme.Checkout'}</p>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{l s='Close' d='Shop.Theme.Global'}"></button>
        </div>

        <div class="modal-body">
          {assign var=image_modals value=[]}

          {foreach from=$product.customizations item="customization"}
            {foreach from=$customization.fields item="field"}
              <div class="{$componentName}__line{if !$field@last} mb-3{/if}">
                <p class="mb-2 text-dark">{$field.label}</p>

                {if $field.type == 'text'}
                  <p class="mb-0">
                    {if $field.id_module|intval}
                      {$field.text nofilter}
                    {else}
                      {$field.text}
                    {/if}
                  </p>
                {elseif $field.type == 'image'}
                  {assign var=image_modal_id value="{$componentName}_image--{mt_rand()}"}

                  <a href="#{$image_modal_id}" data-bs-toggle="modal" data-bs-dismiss="modal" >
                    <img class="rounded-3" src="{$field.image.small.url}">
                  </a>
                  {append var='image_modals'
                    value=[
                      "id"=>$image_modal_id,
                      "title"=>$field.label,
                      "image_url"=>$field.image.large.url,
                      "image_info"=>getimagesize($field.image.large.url),
                      "back_id"=>$customization_modal_id
                    ]
                  }
                {/if}
              </div>
            {/foreach}
          {/foreach}
        </div>
      </div>
    </div>
  </div>
</div>

{if isset($image_modals) && count($image_modals)}
  <div class="{$componentName}__popup">
    {foreach from=$image_modals item="image_modal"}
      <div class="modal fade" id="{$image_modal['id']}" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable modal-fullscreen-sm-down">
          <div class="modal-content">
            <div class="modal-header">
              <p class="h5 modal-title">{$image_modal['title']}</p>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{l s='Close' d='Shop.Theme.Global'}"></button>
            </div>

            <div class="modal-body">
              <img class="img-fluid" src="{$image_modal['image_url']}">
            </div>

            <div class="modal-footer border-1 d-flex flex-wrap justify-content-between w-100">
                <div class="d-inline-flex">
                  <span>{$image_modal['image_info'][0]} x {$image_modal['image_info'][1]}</span>
                  <span class="text-muted ms-2">({$image_modal['image_info']['mime']})</span>
                </div>
                <button type="button" class="btn btn-primary"
                  data-bs-target="#{$image_modal['back_id']}"
                  data-bs-toggle="modal"
                  data-bs-dismiss="modal"
                >
                  {l s='Back' d='Shop.Theme.Global'}
                </button>
            </div>
          </div>
        </div>
      </div>
    {/foreach}
  </div>
{/if}
