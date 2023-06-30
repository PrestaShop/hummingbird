{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{block name='address_block_item'}
  <article id="address-{$address.id}" class="address card" data-id-address="{$address.id}">
    <div class="card-body">
      <p class="address__alias h4 card-title">{$address.alias}</p>
      <address class="address__content">{$address.formatted nofilter}</address>
      {* Display the extra field values added in an address from using hook 'additionalCustomerAddressFields' *}
      {hook h='displayAdditionalCustomerAddressFields' address=$address}
    </div> 

    {block name='address_block_item_actions'}
      <div class="address__actions card-footer">
        <a href="{url entity=address id=$address.id}" data-link-action="edit-address" 
        class="address__edit">{l s='Edit' d='Shop.Theme.Actions'}</a>
        <a href="{url entity=address id=$address.id params=['delete' => 1, 'token' => $token]}" data-link-action="delete-address" 
        class="address__delete">{l s='Delete' d='Shop.Theme.Actions'}</a>
      </div>
    {/block}
  </article>
{/block}
