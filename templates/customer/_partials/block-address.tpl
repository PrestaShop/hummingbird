{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$componentName = 'address-card'}

{block name='address_block_item'}
  <article id="address-{$address.id}" class="{$componentName}" data-id-address="{$address.id}">
    <div class="{$componentName}__container">
      <div class="{$componentName}__header">
        <span class="{$componentName}__alias">{$address.alias}</span>
      </div>

      <address class="{$componentName}__content">{$address.formatted nofilter}</address>

      {capture name='displayAdditionalCustomerAddressFields'}{hook h='displayAdditionalCustomerAddressFields' address=$address}{/capture}
      {if $smarty.capture.displayAdditionalCustomerAddressFields}
        <div class="{$componentName}__extra">
          {$smarty.capture.displayAdditionalCustomerAddressFields}
        </div>
      {/if}

      {block name='address_block_item_actions'}
        <div class="{$componentName}__actions">
          <a 
            class="{$componentName}__edit link-body-emphasis"
            href="{url entity=address id=$address.id}"
            data-link-action="edit-address"
            aria-label="{l s='Edit %addressAlias%' sprintf=['%addressAlias%' => $address.alias|lower] d='Shop.Theme.Actions'}"
            role="button"
          >
            {l s='Edit' d='Shop.Theme.Actions'}
          </a>

          <a 
            class="{$componentName}__delete link-danger"
            href="{url entity=address id=$address.id params=['delete' => 1, 'token' => $token]}"
            data-link-action="delete-address"
            aria-label="{l s='Delete %addressAlias%' sprintf=['%addressAlias%' => $address.alias|lower] d='Shop.Theme.Actions'}"
            role="button"
          >
            {l s='Delete' d='Shop.Theme.Actions'}
          </a>
        </div>
      {/block}
    </div>
  </article>
{/block}
