{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
{$componentName = 'checkout-steps'}

{if !isset($notifications)}
  {$hasNotifications = $notifications.warning|@count > 0 || $notifications.error|@count > 0 || $notifications.success|@count > 0 || $notifications.info|@count > 0}
{/if}

{block name='checkout_steps'}
  <div class="{$componentName} {if isset($notifications) && isset($hasNotifications) && $hasNotifications} {$componentName}--has-notifications{/if}">
    <div class="{$componentName}__desktop">
      <ul class="{$componentName}__list" role="tablist">
        {foreach from=$checkout_steps item="step" key="index"}
          {include file='checkout/_partials/checkout-navigation-step.tpl' number=($index + 1) step=$step.identifier title=$step.title virtual="{if $step.identifier == 'checkout-delivery-step'}{$cart.is_virtual}{else}0{/if}"}
        {/foreach}
      </ul>
    </div>

    <div class="{$componentName}__mobile">
      <div class="{$componentName}__left">
        {include file='components/progress-circle.tpl' classes="text-success" size=74 stroke=4}
      </div>

      <div class="{$componentName}__right">
        {foreach from=$checkout_steps item="step" key="index"}
          {$next_step_title = ''}
          {if isset($checkout_steps[$index + 1])}
            {if $cart.is_virtual && $checkout_steps[$index + 1].identifier == 'checkout-delivery-step' && isset($checkout_steps[$index + 2])}
              {$next_step = $checkout_steps[$index + 2]}
            {else}
              {$next_step = $checkout_steps[$index + 1]}
            {/if}
            {$next_step_title = $next_step.title}
            {$subtitle = {l s='Next: %step_name%' d='Shop.Theme.Checkout' sprintf=['%step_name%' => $next_step_title]}}
          {else}
            {$subtitle = ''}
          {/if}

          {include file='checkout/_partials/checkout-navigation-step-mobile.tpl' step=$step.identifier title=$step.title subtitle=$subtitle}
        {/foreach}
      </div>
    </div>
  </div>
{/block}
