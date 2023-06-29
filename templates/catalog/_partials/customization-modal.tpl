<div id="product-customizations-modal-{$customization.id_customization}" class="modal fade product-customization-modal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <p class="h5 modal-title" id="myModalLabel">
          {l s='Product customization' d='Shop.Theme.Catalog'}
        </p>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{l s='Close' d='Shop.Theme.Global'}"></button>
      </div>
      <div class="modal-body">
        {foreach from=$customization.fields item="field"}
          <div class="product-customization-modal__line d-flex align-items-center justify-content-between">
            <div class="label">
            {if $field.type != 'image'}
              {$field.label}
            {else}
              {l s='Image' d='Shop.Theme.Catalog'}
            {/if}
            </div>
            <div class="value">
              {if $field.type == 'text'}
                {if (int)$field.id_module}
                  {$field.text nofilter}
                {else}
                  {$field.text}
                {/if}
              {elseif $field.type == 'image'}
                <img
                  class="img-fluid"
                  src="{$field.image.medium.url}"
                  loading="lazy"
                  width="100"
                  height="100"
                >
              {/if}
            </div>
          </div>
        {/foreach}
      </div>
    </div>
  </div>
</div>
