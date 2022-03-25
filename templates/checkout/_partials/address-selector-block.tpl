{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
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
              <h4 class="address__alias card-title">{$address.alias}</h4>
              <address class="address__content">{$address.formatted nofilter}</address>

              {block name='address_block_item_actions'}
                {if $interactive}
                  <div class="address__actions">
                    <a
                      class="address__edit text-muted ps-0"
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
