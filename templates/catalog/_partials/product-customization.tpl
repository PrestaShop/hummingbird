{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<section class="product-customization js-product-customization">
  {if !$configuration.is_catalog}
    <div class="card card-body bg-light">
      <p class="h4 card-title">{l s='Product customization' d='Shop.Theme.Catalog'}</p>

      {block name='product_customization_form'}
        <form method="post" action="{$product.url}" enctype="multipart/form-data">
          {foreach from=$customizations.fields item="field"}
            <div class="product-customization__item mb-3">
              {if $field.type == 'text'}
                <textarea placeholder="{l s='Your message here' d='Shop.Forms.Help'}" class="form-control product-message" maxlength="250" {if $field.required} required {/if} name="{$field.input_name}"></textarea>
                <div class="form-text">{l s='250 char. max' d='Shop.Forms.Help'}</div>
                {if $field.text !== ''}
                  <div class="card card-body mt-2">
                    <h6 class="product-customization__message">{l s='Your customization:' d='Shop.Theme.Catalog'}</h6>
                    <p>{$field.text}</p>
                  </div>
                {/if}
              {elseif $field.type == 'image'}
                {if $field.is_customized}
                  <br>
                  <img src="{$field.image.small.url}" loading="lazy">
                  <a class="remove-image" href="{$field.remove_image_url}" rel="nofollow">{l s='Remove Image' d='Shop.Theme.Actions'}</a>
                {/if}
                <input class="form-control file-input js-file-input" {if $field.required} required {/if} type="file" name="{$field.input_name}">
                <div class="form-text">{l s='.png .jpg .gif' d='Shop.Forms.Help'}</div>
              {/if}
            </div>
          {/foreach}
          <div>
            <button class="btn btn-primary" type="submit" name="submitCustomizedData">{l s='Save Customization' d='Shop.Theme.Actions'}</button>
          </div>
        </form>
      {/block}
    </div>
  {/if}
</section>
