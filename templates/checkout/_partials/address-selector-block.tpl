{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{block name='address_selector_blocks'}
  {foreach $addresses as $address}
    <div class="col-12 col-sm-6 mb-2">
      <article id="{$name|classname}-address-{$address.id}" class="address card js-address-item{if $address.id == $selected} selected{/if}" data-id-address="{$address.id}">
        <div class="card-body">
          <label class="form-check-label row">
            <span class="custom-radio col-2">
              <input
                type="radio"
                class="form-check-input"
                name="{$name}"
                value="{$address.id}"
                {if $address.id == $selected}checked{/if}
              >
              <i class="form-check-round"></i>
            </span>

            <div class="address__content col-10">
              <p class="address__alias h4 card-title">{$address.alias}</p>

              <address class="address__content">{$address.formatted nofilter}</address>

              {block name='address_block_item_actions'}
                {if $interactive}
                  <div class="address__actions">
                    <a
                      class="address__edit ps-0"
                      data-link-action="edit-address"
                      href="{url entity='order' params=['id_address' => $address.id, 'editAddress' => $type, 'token' => $token]}"
                    >
                      {l s='Edit' d='Shop.Theme.Actions'}
                    </a>
                    <a
                      class="address__delete"
                      data-link-action="delete-address"
                      href="{url entity='order' params=['id_address' => $address.id, 'deleteAddress' => true, 'token' => $token]}"
                    >
                      {l s='Delete' d='Shop.Theme.Actions'}
                    </a>
                  </div>
                {/if}
              {/block}
            </div>
          </label>
        </div> 
      </article>
    </div>
  {/foreach}

  {if $interactive}
    <p>
      <button class="ps-hidden-by-js form-control-submit center-block" type="submit">{l s='Save' d='Shop.Theme.Actions'}</button>
    </p>
  {/if}
{/block}
