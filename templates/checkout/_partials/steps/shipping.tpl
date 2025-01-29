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
        <div class="delivery-options__container">
          {block name='delivery_options'}
            <div class="delivery-options__list bg-light rounded-3 p-3 mb-4">
              {foreach from=$delivery_options item=carrier key=carrier_id name=delivery_options}
                <div class="delivery-options__item js-delivery-option">
                  <label for="delivery_option_{$carrier.id}" class="col-12">
                    <div class="row">
                      <div class="delivery-option__left col-6 col-sm-4 mb-2 mb-sm-0 order-0">
                        <div class="row align-items-center">
                          <span class="custom-radio col-2">
                            <input type="radio" class="form-check-input" name="delivery_option[{$id_address}]" id="delivery_option_{$carrier.id}" value="{$carrier_id}"{if $delivery_option == $carrier_id} checked{/if}>
                            <i class="form-check-round"></i>
                          </span>

                          <div class="carrier col-10{if $carrier.logo} carrier--hasLogo{/if}">
                            <div class="row align-items-center">
                              {if $carrier.logo}
                                <div class="col-md-4 carrier__logo">
                                    <img src="{$carrier.logo}" class="rounded img-fluid" alt="{$carrier.name}" loading="lazy" />
                                </div>
                              {/if}

                              <div class="carriere-name-container{if $carrier.logo} col-md-8{else}col{/if}">
                                <span class="h6 carrier-name">{$carrier.name}</span>
                              </div>
                            </div>
                          </div>
                        </div> 
                      </div>

                      <span class="delivery-option__center col-6 col-sm-4 order-2 order-sm-1 d-flex align-items-center">
                        {$carrier.delay}
                      </span>

                      <span class="delivery-option__right col-6 col-sm-4 order-1 order-sm-2 d-flex align-items-center">
                        {$carrier.price}
                      </span>
                    </div>
                  </label>

                  <div class="carrier__extra-content-wrapper {if $delivery_option == $carrier_id} carrier__extra-content-wrapper--active {/if} js-carrier-extra-content" {if $delivery_option !== $carrier_id}style="max-height:0px"{/if}>
                    <div class="carrier__extra-content">
                      {$carrier.extraContent nofilter}
                    </div>
                  </div>

                  {if !$smarty.foreach.delivery_options.last}
                    <hr />
                  {/if}
                </div>
              {/foreach}
            </div>
          {/block}

        <div class="order-options{if $recyclablePackAllowed || $gift.allowed} mb-4{/if}">
            <div id="delivery" class="mb-4">
              <label for="delivery_message" class="form-label fw-bold">{l s='Write a comment about this order' d='Shop.Theme.Checkout'}</label>
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
              <div class="form-check mb-3">
                <label class="form-check-label" for="input_gift" data-bs-toggle="collapse" data-bs-target="#gift">
                  <input class="form-check-input js-gift-checkbox" id="input_gift" name="gift" type="checkbox" value="1" {if $gift.isGift}checked="checked"{/if}/>
                  {$gift.label}
                </label>
              </div>

              <div id="gift" class="collapse{if $gift.isGift} show{/if}">
                <label for="gift_message" class="form-label fw-bold">{l s='If you\'d like, you can add a note to the gift:' d='Shop.Theme.Checkout'}</label>
                <textarea class="form-control" rows="2" cols="120" id="gift_message" name="gift_message">{$gift.message}</textarea>
              </div>
            {/if}
          </div>
        </div>

        <div class="shipping__actions d-flex flex-wrap justify-content-between">
          <button class="btn btn-outline-primary btn-with-icon w-100 w-md-auto mb-3 mb-md-0 js-back" data-step="checkout-addresses-step">
            <div class="material-icons rtl-flip" aria-hidden="true">arrow_backward</div>
            {l s='Back to Addresses' d='Shop.Theme.Actions'}
          </button>

          <button type="submit" class="btn btn-primary btn-with-icon w-100 w-md-auto" name="confirmDeliveryOption" value="1">
            {l s='Continue to Payment' d='Shop.Theme.Actions'}
            <div class="material-icons rtl-flip" aria-hidden="true">arrow_forward</div>
          </button>
        </div>
      </form>
    {else}
      <p class="alert alert-danger">{l s='Unfortunately, there are no carriers available for your delivery address.' d='Shop.Theme.Checkout'}</p>
    {/if}
  </div>

  <div id="hook-display-after-carrier">
    {$hookDisplayAfterCarrier nofilter}
  </div>

  <div id="extra_carrier"></div>
{/block}
