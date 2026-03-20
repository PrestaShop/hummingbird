{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
{$componentName = 'checkout-steps'}

<div class="{$componentName}__step-mobile d-none" data-step="{$step}">
  <p class="{$componentName}__title">
    {$title}
  </p>

  {if !empty($subtitle)}
    <p class="{$componentName}__subtitle">
      {$subtitle}
    </p>
  {/if}
</div>
