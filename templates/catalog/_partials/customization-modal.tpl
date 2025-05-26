{$componentName = 'product-customization-modal'}

<div id="product-customizations-modal-{$customization.id_customization}" class="modal fade product-customization-modal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <p class="h2 modal-title">{l s='Product customization' d='Shop.Theme.Checkout'}</p>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{l s='Close' d='Shop.Theme.Global'}"></button>
      </div>

      <div class="modal-body">
        {foreach from=$customization.fields item="field"}
          <div class="{$componentName}__line">
            <p class="{$componentName}__label">{$field.label}</p>

            {if $field.type == 'text'}
              <div class="{$componentName}__text">
                {if $field.id_module|intval}
                  {$field.text nofilter}
                {else}
                  {$field.text}
                {/if}
              </div>
            {elseif $field.type == 'image'}
              {assign var=image_modal_id value="{$componentName}_image--{mt_rand()}"}

              <a href="#{$image_modal_id}" data-bs-toggle="modal" data-bs-dismiss="modal" >
                <img class="{$componentName}__img" src="{$field.image.small.url}">
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
      </div>
    </div>
  </div>
</div>

{if isset($image_modals) && count($image_modals)}
  <div class="{$componentName}__popup">
    {foreach from=$image_modals item="image_modal"}
      <div class="modal fade" id="{$image_modal['id']}" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
          <div class="modal-content">
            <div class="modal-header">
              <p class="h2 modal-title">{$image_modal['title']}</p>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{l s='Close' d='Shop.Theme.Global'}"></button>
            </div>

            <div class="modal-body">
              <img class="{$componentName}__img-popup img-fluid" src="{$image_modal['image_url']}">
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-primary"
                  data-bs-target="#product-customizations-modal-{$customization.id_customization}"
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
