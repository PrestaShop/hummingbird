{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$componentName = 'product-customization-modal'}

<div class="{$componentName}__wrapper">
  <button class="btn btn-sm btn-outline-primary mb-2"
    data-bs-toggle="modal"
    data-bs-target="#{$componentName}--{$product.id_customization|intval}"
  >
    {l s='Customized' d='Shop.Theme.Checkout'}
  </button>

  <div class="modal fade"
    id="{$componentName}--{$product.id_customization|intval}"
    tabindex="-1"
    aria-hidden="true"
  >
    <div class="modal-dialog modal-dialog-scrollable modal-fullscreen-md-down">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">{l s='Product customization' d='Shop.Theme.Checkout'}</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div class="container-fluid">
            {foreach from=$product.customizations item="customization"}
              <div class="row row-cols-1">
                {foreach from=$customization.fields item="field"}
                <div class="d-flex flex-column mb-3">
                  <span class="mb-1 text-dark">{$field.label}</span>
                  {if $field.type == 'text'}
                    <p class="mb-0">
                      {if (int)$field.id_module}
                        {$field.text nofilter}
                      {else}
                        {$field.text}
                      {/if}
                    </p>
                  {elseif $field.type == 'image'}
                    <img class="align-self-start rounded-3" src="{$field.image.small.url}">
                  {/if}
                </div>
                {/foreach}
              </div>
            {/foreach}
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
