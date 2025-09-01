{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{if isset($groups) && $groups}
  <div class="product__variants js-product-variants">
    {foreach from=$groups key=id_attribute_group item=group}
      {if !empty($group.attributes)}
        <fieldset class="product-variant">
          <div class="product-variant__label">
            <legend class="form-label product-variant__legend" id="legend_{$product.id}_{$id_attribute_group}">{$group.name}</legend>
            <span class="selected-value product-variant__selected" aria-hidden="true">
              {l s=': ' d='Shop.Theme.Catalog'}
              {foreach from=$group.attributes key=id_attribute item=group_attribute}
                {if $group_attribute.selected}{$group_attribute.name}{/if}
              {/foreach}
            </span>
          </div>

          {if $group.group_type == 'select'}
            <select
              class="form-select"
              id="group_{$product.id}_{$id_attribute_group}"
              aria-labelledby="legend_{$product.id}_{$id_attribute_group}"
              data-product-attribute="{$id_attribute_group}"
              name="group[{$id_attribute_group}]">
              {foreach from=$group.attributes key=id_attribute item=group_attribute}
                <option value="{$id_attribute}" {if $group_attribute.selected} selected="selected"{/if}>{$group_attribute.name}</option>
              {/foreach}
            </select>
          {elseif $group.group_type == 'color'}
            <div id="group_{$product.id}_{$id_attribute_group}" class="product-variant__colors" role="radiogroup" aria-labelledby="legend_{$product.id}_{$id_attribute_group}">
              {foreach from=$group.attributes key=id_attribute item=group_attribute}
                {assign var=optionId value="group_{$product.id}_{$id_attribute_group}_{$id_attribute}"}
                {assign var=labelId value="label_{$product.id}_{$id_attribute_group}_{$id_attribute}"}
                <div class="product-variant__color input-color">
                  <input 
                    class="input-color__input"
                    type="radio"
                    id="{$optionId}"
                    data-product-attribute="{$id_attribute_group}"
                    name="group[{$id_attribute_group}]"
                    value="{$id_attribute}"
                    aria-labelledby="{$labelId}"
                    {if $group_attribute.selected} checked="checked" aria-checked="true"{/if}
                  >
                  <label
                    class="input-color__label{if $group_attribute.texture} input-color__label--texture{/if}{if $group_attribute.selected} input-color__label--active{/if}"
                    for="{$optionId}"
                  >
                    <span id="{$labelId}"
                      {if $group_attribute.texture}
                        class="color texture {if $group_attribute.selected}active{/if}" style="background-image: url({$group_attribute.texture})"
                      {elseif $group_attribute.html_color_code}
                        class="color {if $group_attribute.selected}active{/if}" style="background-color: {$group_attribute.html_color_code}"
                      {/if}
                    >
                      <span class="visually-hidden">{$group.group_name} - {$group_attribute.name}</span>
                    </span>
                  </label>
                </div>
              {/foreach}
            </div>
          {elseif $group.group_type == 'radio'}
            <div id="group_{$product.id}_{$id_attribute_group}" class="product-variant__radios" role="radiogroup" aria-labelledby="legend_{$product.id}_{$id_attribute_group}">
              {foreach from=$group.attributes key=id_attribute item=group_attribute}
                {assign var=optionId value="group_{$product.id}_{$id_attribute_group}_{$id_attribute}"}
                {assign var=labelId value="label_{$product.id}_{$id_attribute_group}_{$id_attribute}"}
                <div class="product-variant__radio form-check">
                  <input
                    class="form-check-input"
                    type="radio"
                    id="{$optionId}"
                    data-product-attribute="{$id_attribute_group}"
                    name="group[{$id_attribute_group}]"
                    value="{$id_attribute}"
                    aria-labelledby="{$labelId}"
                    {if $group_attribute.selected} checked="checked" aria-checked="true"{/if}
                  >
                  <label for="{$optionId}">
                    <span class="form-check-label" id="{$labelId}"><span class="visually-hidden">{$group.group_name} - </span>{$group_attribute.name}</span>
                  </label>
                </div>
              {/foreach}
            </div>
          {/if}
        </fieldset>
      {/if}
    {/foreach}
  </div>
{/if}
