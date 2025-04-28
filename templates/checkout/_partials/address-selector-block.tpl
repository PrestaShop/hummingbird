{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$componentName = 'address-card'}

{block name='address_selector_blocks'}
  {foreach $addresses as $address}
    <article id="{$name|classname}-address-{$address.id}" class="{$componentName} {$componentName}--radio js-address-item{if $address.id == $selected} selected{/if}" data-id-address="{$address.id}">
      <label class="{$componentName}__container">
        <div class="{$componentName}__header">
          <span class="custom-radio">
            <input
              type="radio"
              class="form-check-input"
              name="{$name}"
              value="{$address.id}"
              {if $address.id == $selected}checked{/if}
            >
            <i class="form-check-round"></i>
          </span>

          <span class="{$componentName}__alias">
            {$address.alias}
          </span>
        </div>

        <address class="{$componentName}__content">{$address.formatted nofilter}</address>

        {block name='address_block_item_actions'}
          {if $interactive}
            <div class="{$componentName}__actions">
              <a
                class="{$componentName}__edit link-body-emphasis"
                data-link-action="edit-address"
                href="{url entity='order' params=['id_address' => $address.id, 'editAddress' => $type, 'token' => $token]}"
              >
                {l s='Edit' d='Shop.Theme.Actions'}
              </a>

              <a
                class="{$componentName}__delete link-danger"
                data-link-action="delete-address"
                href="{url entity='order' params=['id_address' => $address.id, 'deleteAddress' => true, 'token' => $token]}"
              >
                {l s='Delete' d='Shop.Theme.Actions'}
              </a>
            </div>
          {/if}
        {/block}
      </label>
    </article>
  {/foreach}

  {if $interactive}
    <div class="d-none">
      <button class="ps-hidden-by-js form-control-submit center-block" type="submit">{l s='Save' d='Shop.Theme.Actions'}</button>
    </div>
  {/if}
{/block}
