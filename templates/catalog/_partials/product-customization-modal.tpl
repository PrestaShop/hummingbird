
{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$componentName = 'product-customization-modal'}

<div class="{$componentName}__content">
  {assign var=customization_modal_id value="{$componentName}--{$product.id_customization|intval}"}

  <div class="modal fade" id="{$customization_modal_id}" tabindex="-1" aria-hidden="true" aria-labelledby="customizations-modal-{$product.id_customization}-title">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
      <div class="modal-content">
        <div class="modal-header">
          <p class="h2 modal-title" id="customizations-modal-{$product.id_customization}-title">{l s='Product customization' d='Shop.Theme.Checkout'}</p>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{l s='Close' d='Shop.Theme.Global'}"></button>
        </div>

        <div class="modal-body">
          {assign var=image_modals value=[]}

          {foreach from=$product.customizations item="customization"}
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

  <button type="button" class="btn btn-sm btn-outline-primary"
    data-bs-toggle="modal"
    data-bs-target="#{$customization_modal_id}"
    aria-label="{l s='View my customization' d='Shop.Theme.Checkout'}"
  >
    {l s='Customized' d='Shop.Theme.Checkout'}
  </button>
</div>
