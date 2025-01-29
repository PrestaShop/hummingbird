{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
 
<section class="product-customization js-product-customization">
  {if !$configuration.is_catalog}
    <div class="card bg-light border-1 mb-4">
      <div class="card-body px-2 px-sm-3">
        <p class="h5 card-title mb-3">{l s='Product customization' d='Shop.Theme.Catalog'}</p>

        {block name='product_customization_form'}
          <form method="post" action="{$product.url}" enctype="multipart/form-data" class="mb-0">
            {foreach from=$customizations.fields item="field"}
              <div class="product-customization__item card border-1 mb-2 mb-sm-3">
                <div class="card-header bg-transparent fw-bold border-1">{$field.label}</div>

                <div class="card-body px-2 px-sm-3">
                  <div class="row row-cols-1">
                    {if $field.type === 'text'}
                      <div>
                        <textarea placeholder="{l s='Your message here' d='Shop.Forms.Help'}" class="form-control product-message" maxlength="250" {if $field.required} required {/if} name="{$field.input_name}"></textarea>
                      </div>

                      {if $field.text !== ''}
                        <div class="mt-3">
                          <p class="h6 product-customization__message">{l s='Your customization:' d='Shop.Theme.Catalog'}</p>
                          <p class="mb-0">{$field.text}</p>
                        </div>
                      {/if}
                    {elseif $field.type === 'image'}
                      <div>
                        <input class="form-control file-input js-file-input" {if $field.required} required {/if} type="file" name="{$field.input_name}">
                      </div>

                      {if $field.is_customized}
                        <div class="mt-3">
                          <div class="d-flex align-items-end">
                            <img src="{$field.image.small.url}" class="img-fluid rounded-3" loading="lazy">
                            <a class="d-block ms-2" href="{$field.remove_image_url}" rel="nofollow">{l s='Remove Image' d='Shop.Theme.Actions'}</a>
                          </div>
                        </div>
                      {/if}
                    {/if}
                  </div>
                </div>

                <div class="card-footer bg-transparent border-1">
                  <div class="d-flex">
                    <div class="flex-grow-1">
                      {if $field.type === 'text'}
                        <small class="text-muted">{l s='250 char. max' d='Shop.Forms.Help'}</small>
                      {elseif $field.type === 'image'}
                        <small class="text-muted">{l s='.png .jpg .gif' d='Shop.Forms.Help'}</small>
                      {/if}
                    </div>
                    {if !$field.required}
                      <small class="text-muted">{l s='Optional' d='Shop.Forms.Help'}</small>
                    {/if}
                  </div>
                </div>
              </div>
            {/foreach}

            <div class="mt-3 mt-sm-0">
              <button class="btn btn-primary" type="submit" name="submitCustomizedData">{l s='Save Customization' d='Shop.Theme.Actions'}</button>
            </div>
          </form>
        {/block}
      </div>
    </div>
  {/if}
</section>
