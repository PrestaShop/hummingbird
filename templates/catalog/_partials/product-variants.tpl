{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<div class="product__variants js-product-variants">
  {foreach from=$groups key=id_attribute_group item=group}
    {if !empty($group.attributes)}
    <div class="variant">
      <label for="group_{$id_attribute_group}" class="form-label">{$group.name}{l s=': ' d='Shop.Theme.Catalog'}
          {foreach from=$group.attributes key=id_attribute item=group_attribute}
            {if $group_attribute.selected}{$group_attribute.name}{/if}
          {/foreach}
      </label>

      {if $group.group_type == 'select'}
        <select
          class="form-select"
          id="group_{$id_attribute_group}"
          aria-label="{$group.name}"
          data-product-attribute="{$id_attribute_group}"
          name="group[{$id_attribute_group}]">
          {foreach from=$group.attributes key=id_attribute item=group_attribute}
            <option value="{$id_attribute}" title="{$group_attribute.name}"{if $group_attribute.selected} selected="selected"{/if}>{$group_attribute.name}</option>
          {/foreach}
        </select>
      {elseif $group.group_type == 'color'}
        <ul id="group_{$id_attribute_group}" class="color-variants">
          {foreach from=$group.attributes key=id_attribute item=group_attribute}
            <li class="color-variant">
              <label aria-label="{$group_attribute.name}">
                <input class="input-color" type="radio" data-product-attribute="{$id_attribute_group}" name="group[{$id_attribute_group}]" value="{$id_attribute}" title="{$group_attribute.name}"{if $group_attribute.selected} checked="checked"{/if}>
                <span
                  {if $group_attribute.texture}
                    class="color texture {if $group_attribute.selected}active{/if}" style="background-image: url({$group_attribute.texture})"
                  {elseif $group_attribute.html_color_code}
                    class="color {if $group_attribute.selected}active{/if}" style="background-color: {$group_attribute.html_color_code}"
                  {/if}
               ><span class="attribute-name visually-hidden">{$group_attribute.name}</span></span>
              </label>
            </li>
          {/foreach}
        </ul>
      {elseif $group.group_type == 'radio'}
        <ul id="group_{$id_attribute_group}" class="radio-variants">
          {foreach from=$group.attributes key=id_attribute item=group_attribute}
            <li class="radio-variant form-check">
              <label>
                <input class="form-check-input input-radio" type="radio" data-product-attribute="{$id_attribute_group}" name="group[{$id_attribute_group}]" value="{$id_attribute}" title="{$group_attribute.name}"{if $group_attribute.selected} checked="checked"{/if}>
                <span class="form-check-label radio-label">{$group_attribute.name}</span>
              </label>
            </li>
          {/foreach}
        </ul>
      {/if}
    </div>
    {/if}
  {/foreach}
</div>
