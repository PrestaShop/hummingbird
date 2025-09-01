{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
 
{if !$configuration.is_catalog}
  <section class="product__customization product-customization js-product-customization">
    <p class="product-customization__title h4">{l s='Product customization' d='Shop.Theme.Catalog'}</p>
    {block name='product_customization_form'}
      <form method="post" action="{$product.url}" enctype="multipart/form-data" class="mb-0">
        {foreach from=$customizations.fields item="field"}
          <div class="product-customization__item">
            <label class="product-customization__label form-label {if $field.required}required{/if}" for="field-{$field.id_customization_field}">{$field.label}</label>

            <div class="product-customization__field">
              {if $field.type === 'text'}
                <textarea placeholder="{l s='Your message here' d='Shop.Forms.Help'}" class="form-control product-message" maxlength="250" {if $field.required} required {/if} name="{$field.input_name}" id="field-{$field.id_customization_field}"></textarea>

                {if $field.text !== ''}
                  <div class="product-customization__message">
                    <b>{l s='Your customization:' d='Shop.Theme.Catalog'}</b> {$field.text}
                  </div>
                {/if}
              {elseif $field.type === 'image'}
                <input class="form-control file-input js-file-input" {if $field.required} required {/if} type="file" name="{$field.input_name}" id="field-{$field.id_customization_field}">

                {if $field.is_customized}
                  <div class="product-customization__image-wrapper">
                    <img src="{$field.image.small.url}" class="product-customization__image img-fluid" loading="lazy">

                    <a class="product-customization__image-remove link-danger" href="{$field.remove_image_url}" rel="nofollow" role="button">
                      {l s='Remove Image' d='Shop.Theme.Actions'}
                    </a>
                  </div>
                {/if}
              {/if}
            </div>

            <div class="product-customization__field-footer">
              {if $field.type === 'text'}
                <small class="form-text">{l s='250 char. max' d='Shop.Forms.Help'}</small>
              {elseif $field.type === 'image'}
                <small class="form-text">{l s='.png .jpg .gif' d='Shop.Forms.Help'}</small>
              {/if}

              {if !$field.required}
                <small class="form-text">{l s='Optional' d='Shop.Forms.Help'}</small>
              {/if}
            </div>
          </div>
        {/foreach}

        <div class="product-customization__action">
          <button class="btn btn-primary" type="submit" name="submitCustomizedData">{l s='Save Customization' d='Shop.Theme.Actions'}</button>
        </div>
      </form>
    {/block}
  {/if}
</section>
