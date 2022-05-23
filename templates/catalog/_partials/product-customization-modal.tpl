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
          <h4 class="modal-title">{l s='Product customization' d='Shop.Theme.Checkout'}</h4>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{l s='Close' d='Shop.Theme.Global'}"></button>
        </div>
        <div class="modal-body">
          {foreach from=$product.customizations item="customization"}
            {foreach from=$customization.fields item="field"}
              <div class="{$componentName}__line{if !$field@last} mb-3{/if}">
                <p class="mb-1 text-dark">{$field.label}</p>
                {if $field.type == 'text'}
                  <p class="mb-0">
                    {if $field.id_module|intval}
                      {$field.text nofilter}
                    {else}
                      {$field.text}
                    {/if}
                  </p>
                {elseif $field.type == 'image'}
                  <a href="{$field.image.large.url}">
                    <img class="rounded-3" src="{$field.image.small.url}">
                  </a>
                {/if}
              </div>
            {/foreach}
          {/foreach}
        </div>
      </div>
    </div>
  </div>
</div>
