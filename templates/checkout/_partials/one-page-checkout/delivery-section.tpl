{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}

{**
 * OPC — Delivery method section
 * Included by one-page-checkout.tpl.
 * Also renderable standalone for AJAX refresh.
 *
 * Variables:
 *   $delivery_options         - available carriers (may be empty on first load)
 *   $delivery_option          - currently selected carrier key
 *   $id_address_delivery      - current cart delivery address ID
 *   $hookDisplayBeforeCarrier
 *   $hookDisplayAfterCarrier
 *}

<section class="one-page-checkout__section js-opc-delivery-section">
  <h2 class="one-page-checkout__title">{l s='Delivery method' d='Shop.Theme.Checkout'}</h2>

  <div id="delivery-options__hook">
    {if isset($hookDisplayBeforeCarrier)}
      {$hookDisplayBeforeCarrier nofilter}
    {else}
      {hook h='displayBeforeCarrier'}
    {/if}
  </div>

  <div class="one-page-checkout__placeholder" id="opc-delivery-methods" data-id-address="{$id_address_delivery|intval}"
    data-url-update="{url entity='order' params=['ajax' => 1, 'action' => 'opcSelectCarrier']}"
    data-msg-no-carriers="{l s='Unfortunately, there are no carriers available for your delivery address.' d='Shop.Theme.Checkout'}"
  >
    {if $delivery_options|count}
      {include file='checkout/_partials/one-page-checkout/carriers.tpl'
        delivery_options=$delivery_options
        delivery_option=$delivery_option
      }
    {else}
      <div class="card card-body bg-light">
        {l s='You will see the available delivery methods once you\'ve entered your delivery address.' d='Shop.Theme.Checkout'}
      </div>
    {/if}
  </div>

  <div class="delivery-options__display-after-carrier" id="hook-display-after-carrier">
    {if isset($hookDisplayAfterCarrier)}
      {$hookDisplayAfterCarrier nofilter}
    {else}
      {hook h='displayAfterCarrier'}
    {/if}
  </div>

  <div class="delivery-options__extra-carrier" id="extra_carrier"></div>

  {include file='checkout/_partials/one-page-checkout/order-options.tpl'
    delivery_message=$delivery_message|default:''
    recyclablePackAllowed=$recyclablePackAllowed|default:false
    recyclable=$recyclable|default:false
    gift=$gift|default:[]
  }

  <template id="opc-template-loader">
    {include file='checkout/_partials/one-page-checkout/opc-loader.tpl'
      message={l s='Loading delivery methods...' d='Shop.Theme.Checkout'}
    }
  </template>

  <template id="opc-template-carriers-error">
    {include file='checkout/_partials/one-page-checkout/opc-error.tpl'
      message={l s='An error occurred while loading carriers. Please try again.' d='Shop.Theme.Checkout'}
      retry_label={l s='Retry' d='Shop.Theme.Checkout'}
    }
  </template>
</section>
