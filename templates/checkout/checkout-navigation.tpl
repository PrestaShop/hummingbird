{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$componentName = 'checkout-steps'}

{if !isset($notifications)}
  {$hasNotifications = $notifications.warning|@count > 0 || $notifications.error|@count > 0 || $notifications.success|@count > 0 || $notifications.info|@count > 0}
{/if}

{block name='checkout_steps'}
  <div class="{$componentName} {if isset($notifications) && isset($hasNotifications) && $hasNotifications} {$componentName}--has-notifications{/if}">
    <div class="{$componentName}__desktop">
      <ul class="{$componentName}__list" role="tablist">
        {* Personal Information *}
        {include file='checkout/_partials/checkout-navigation-step.tpl' number="{l s='1' d='Shop.Theme.Checkout'}"
        step="checkout-personal-information-step" title="{l s='Personal Information' d='Shop.Theme.Checkout'}"}

        {* Addresses *}
        {include file='checkout/_partials/checkout-navigation-step.tpl' number="{l s='2' d='Shop.Theme.Checkout'}"
        step="checkout-addresses-step" title="{l s='Addresses' d='Shop.Theme.Checkout'}"}

        {* Shipping method *}
        {include file='checkout/_partials/checkout-navigation-step.tpl' number="{l s='3' d='Shop.Theme.Checkout'}"
        step="checkout-delivery-step" title="{l s='Shipping method' d='Shop.Theme.Checkout'}"}

        {* Payment *}
        {include file='checkout/_partials/checkout-navigation-step.tpl' number="{l s='4' d='Shop.Theme.Checkout'}"
        step="checkout-payment-step" title="{l s='Payment' d='Shop.Theme.Checkout'}"}
      </ul>
    </div>

    <div class="{$componentName}__mobile">
      <div class="{$componentName}__left">
        {include file='components/progress-circle.tpl' classes="text-success" size=74 stroke=4}
      </div>

      <div class="{$componentName}__right">
        {* Personal Information *}
        {include file='checkout/_partials/checkout-navigation-step-mobile.tpl' step="checkout-personal-information-step" title="{l s='Personal Information' d='Shop.Theme.Checkout'}"
        subtitle="{l s='Next: Addresses' d='Shop.Theme.Checkout'}"}

        {* Addresses *}
        {include file='checkout/_partials/checkout-navigation-step-mobile.tpl' step="checkout-addresses-step" title="{l s='Addresses' d='Shop.Theme.Checkout'}"
        subtitle="{l s='Next: Shipping Method' d='Shop.Theme.Checkout'}"}

        {* Shipping Method *}
        {include file='checkout/_partials/checkout-navigation-step-mobile.tpl' step="checkout-delivery-step" title="{l s='Shipping Method' d='Shop.Theme.Checkout'}"
        subtitle="{l s='Next: Payment' d='Shop.Theme.Checkout'}"}

        {* Payment *}
        {include file='checkout/_partials/checkout-navigation-step-mobile.tpl' step="checkout-payment-step" title="{l s='Payment' d='Shop.Theme.Checkout'}"}
      </div>
    </div>
  </div>
{/block}
