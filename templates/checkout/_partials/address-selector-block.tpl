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
              aria-label="{l s='Select address: %addressAlias%' sprintf=['%addressAlias%' => $address.alias|lower] d='Shop.Theme.Actions'}"
              aria-describedby="address-{$address.id}"
            >
          </span>

          <span class="{$componentName}__alias">
            {$address.alias}
          </span>
        </div>

        <address class="{$componentName}__content" id="address-{$address.id}">
          <span class="visually-hidden">{l s='Address details:' d='Shop.Theme.Actions'}</span>
          {$address.formatted nofilter}
        </address>

        {block name='address_block_item_actions'}
          {if $interactive}
            <div class="{$componentName}__actions">
              <a
                class="{$componentName}__edit link-body-emphasis"
                data-link-action="edit-address"
                href="{url entity='order' params=['id_address' => $address.id, 'editAddress' => $type, 'token' => $token]}"
                aria-label="{l s='Edit address: %addressAlias%' sprintf=['%addressAlias%' => $address.alias|lower] d='Shop.Theme.Actions'}"
              >
                {l s='Edit' d='Shop.Theme.Actions'}
              </a>

              <a
                class="{$componentName}__delete link-danger"
                data-link-action="delete-address"
                href="{url entity='order' params=['id_address' => $address.id, 'deleteAddress' => true, 'token' => $token]}"
                aria-label="{l s='Delete address: %addressAlias%' sprintf=['%addressAlias%' => $address.alias|lower] d='Shop.Theme.Actions'}"
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
