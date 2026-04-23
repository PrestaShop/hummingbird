{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}

{**
 * OPC — Carrier list partial (AJAX refresh)
 * Variables: $delivery_options, $delivery_option
 *}

{if $delivery_options|count}
  <div class="delivery-options__list">
    {foreach from=$delivery_options item=carrier key=carrier_id name=delivery_options}
      <div class="delivery-option__item js-delivery-option">
        <label class="delivery-option__label" for="opc_delivery_option_{$carrier.id}">
          <div class="delivery-option__left">
            <span class="delivery-option__check form-check">
              <input
                type="radio"
                class="form-check-input"
                name="delivery_option"
                id="opc_delivery_option_{$carrier.id}"
                value="{$carrier_id}"
                {if $delivery_option == $carrier_id}checked{/if}
              >
            </span>

            <div class="delivery-option__carrier {if $carrier.logo}delivery-option__carrier--hasLogo{/if}">
              {if $carrier.logo}
                <img class="delivery-option__carrier-logo" src="{$carrier.logo}" alt="{$carrier.name}" loading="lazy" aria-hidden="true">
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
          {capture name='extra'}{$carrier.extraContent nofilter}{/capture}
          {if !empty($smarty.capture.extra)}
            <div class="delivery-option__extra-content js-carrier-extra-content">
              {$smarty.capture.extra nofilter}
            </div>
          {/if}
        </div>
      </div>
    {/foreach}
  </div>
{else}
  <p class="alert alert-warning mb-0">
    {l s='Unfortunately, there are no carriers available for your delivery address.' d='Shop.Theme.Checkout'}
  </p>
{/if}
