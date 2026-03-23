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
        {foreach from=$checkout_process->getSteps() item="step" key="index"}
          {include file='checkout/_partials/checkout-navigation-step.tpl' 
            number=$index + 1
            step=$step->getIdentifier() 
            title=$step->getTitle()
            virtual=($step->getIdentifier() == 'checkout-delivery-step' && $cart.is_virtual)
          }
        {/foreach}
      </ul>
    </div>

    <div class="{$componentName}__mobile">
      <div class="{$componentName}__left">
        {include file='components/progress-circle.tpl' classes="text-success" size=74 stroke=4}
      </div>

      <div class="{$componentName}__right">
        {foreach from=$checkout_process->getSteps() item="step" key="index"}
          {$steps_array = $checkout_process->getSteps()}
          {$next_step = null}
          {if isset($steps_array[$index + 1])}
            {$next_step = $steps_array[$index + 1]}
          {/if}
          
          {$subtitle = ''}
          {if $next_step}
            {$subtitle = {l s='Next: %name%' d='Shop.Theme.Checkout' sprintf=['%name%' => $next_step->getTitle()]}}
          {/if}
          
          {include file='checkout/_partials/checkout-navigation-step-mobile.tpl' 
            step=$step->getIdentifier() 
            title=$step->getTitle()
            subtitle=$subtitle
          }
        {/foreach}
      </div>
    </div>
  </div>
{/block}
