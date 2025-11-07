{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file='checkout/_partials/steps/checkout-step.tpl'}

{block name='step_content'}
  <div id="delivery-options__hook">
    {$hookDisplayBeforeCarrier nofilter}
  </div>

  <div class="delivery-options__container">
    {if $delivery_options|count}
      <form
        id="js-delivery"
        data-url-update="{url entity='order' params=['ajax' => 1, 'action' => 'selectDeliveryOption']}"
        method="post"
        class="delivery-options__form"
      >
        {block name='delivery_options'}
          <div class="delivery-options__list">
            {foreach from=$delivery_options item=carrier key=carrier_id name=delivery_options}
              <div class="delivery-option__item js-delivery-option">
                <label class="delivery-option__label" for="delivery_option_{$carrier.id}">
                  <div class="delivery-option__left">
                    <span class="delivery-option__check form-check">
                      <input type="radio" class="form-check-input" name="delivery_option[{$id_address}]" id="delivery_option_{$carrier.id}" value="{$carrier_id}"{if $delivery_option == $carrier_id} checked{/if}>
                    </span>

                    <div class="delivery-option__carrier {if $carrier.logo} delivery-option__carrier--hasLogo{/if}">
                      {if $carrier.logo}
                        <img class="delivery-option__carrier-logo" src="{$carrier.logo}" class="img-fluid" alt="{$carrier.name}" loading="lazy" aria-hidden="true" />
                      {/if}

                      <span class="delivery-option__carrier-name">{$carrier.name}</span>
                    </div>
                  </div>

                  <div class="delivery-option__content">
                    {$carrier.delay}
                  </div>

                  <div class="delivery-option__price">
                    {$carrier.price}
                  </div>
                </label>

                <div class="delivery-option__extra js-carrier-extra" {if $delivery_option == $carrier_id}data-active{/if}>
                  {capture name='delivery_option_extra_content'}{$carrier.extraContent nofilter}{/capture}
                  {if !empty($smarty.capture.delivery_option_extra_content)}
                    <div class="delivery-option__extra-content js-carrier-extra-content">
                      {$smarty.capture.delivery_option_extra_content nofilter}
                    </div>
                  {/if}
                </div>
              </div>
            {/foreach}
          </div>
        {/block}

        <div class="order-options">
          <div id="delivery" class="mb-4">
            <label for="delivery_message" class="form-label">{l s='Write a comment about this order' d='Shop.Theme.Checkout'}</label>
            <textarea class="form-control" rows="2" cols="120" id="delivery_message" placeholder="{l s='Write your comment...' d='Shop.Theme.Checkout'}" name="delivery_message">{$delivery_message}</textarea>
          </div>

          {if $recyclablePackAllowed}
            <div class="form-check" for="input_recyclable">
              <label class="form-check-label">
                <input class="form-check-input" type="checkbox" id="input_recyclable" name="recyclable" value="1" {if $recyclable} checked {/if}/>
                {l s='I would like to receive my order in recycled packaging.' d='Shop.Theme.Checkout'}
              </label>
            </div>
          {/if}

          {if $gift.allowed}
            <div class="form-check mb-4">
              <label class="form-check-label" for="input_gift" data-bs-toggle="collapse" data-bs-target="#gift">
                <input class="form-check-input js-gift-checkbox" id="input_gift" name="gift" type="checkbox" value="1" {if $gift.isGift}checked="checked"{/if}/>
                {$gift.label}
              </label>
            </div>

            <div id="gift" class="collapse{if $gift.isGift} show{/if}">
              <label for="gift_message" class="form-label">{l s='If you\'d like, you can add a note to the gift:' d='Shop.Theme.Checkout'}</label>
              <textarea class="form-control" rows="2" cols="120" id="gift_message" name="gift_message">{$gift.message}</textarea>
            </div>
          {/if}
        </div>

        <div class="buttons-wrapper buttons-wrapper--split buttons-wrapper--invert-mobile mt-3">
          <button class="btn btn-outline-primary w-100 w-md-auto mb-3 mb-md-0 js-back" data-step="checkout-addresses-step">
            <div class="material-icons rtl-flip" aria-hidden="true">&#xE5C4;</div>
            {l s='Back to Addresses' d='Shop.Theme.Actions'}
          </button>

          <button type="submit" class="btn btn-primary w-100 w-md-auto" name="confirmDeliveryOption" value="1">
            {l s='Continue to Payment' d='Shop.Theme.Actions'}
            <div class="material-icons rtl-flip" aria-hidden="true">&#xE5C8;</div>
          </button>
        </div>
      </form>
    {else}
      <p class="alert alert-danger">{l s='Unfortunately, there are no carriers available for your delivery address.' d='Shop.Theme.Checkout'}</p>
    {/if}
  </div>

  <div class="delivery-options__display-after-carrier" id="hook-display-after-carrier">
    {$hookDisplayAfterCarrier nofilter}
  </div>

  <div class="delivery-options__extra-carrier" id="extra_carrier"></div>
{/block}
