{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$componentName = 'checkout__steps'}

{if isset($notifications)}
  {$hasNotifications = $notifications.warning|@count > 0 || $notifications.error|@count > 0 || $notifications.success|@count > 0 || $notifications.info|@count > 0}
{/if}

{block name='checkout_steps'}
<div class="{$componentName} bg-light py-2 {if isset($notifications) && $hasNotifications}mb-2 mb-lg-4{else}mb-3 mb-lg-5{/if} py-md-4">
    <ul class="{$componentName}__list nav nav-tabs border-0 row mb-0 d-none d-md-flex" role="tablist">
      <li 
        class="{$componentName}__item nav-item js-step-item text-center col-3" 
        data-step="checkout-personal-information-step" 
        role="presentation" 
      >
        <span class="{$componentName}__number mb-1">
          {l s='1' d='Shop.Theme.Checkout'}
        </span> 
        <button 
          class="{$componentName}__text nav-link w-100 bg-transparent btn p-0 border-0 mb-0"
          data-bs-toggle="tab" 
          data-bs-target="#checkout-personal-information-step"
          role="tab"
        >
          {l s='Personal Information' d='Shop.Theme.Checkout'}
        </button>
      </li>

      <li 
        class="{$componentName}__item nav-item js-step-item text-center col-3" 
        data-step="checkout-addresses-step"
        role="presentation" 
      >
        <span class="{$componentName}__number mb-1">
          {l s='2' d='Shop.Theme.Checkout'}
        </span> 
        <button 
          class="{$componentName}__text nav-link w-100 bg-transparent btn p-0 border-0 mb-0"
          data-bs-toggle="tab" 
          data-bs-target="#checkout-addresses-step"
          role="tab"
        >
          {l s='Addresses' d='Shop.Theme.Checkout'}
        </button>
      </li>

      <li 
        class="{$componentName}__item nav-item js-step-item text-center col-3" 
        data-step="checkout-delivery-step"
        role="presentation" 
      >
        <span class="{$componentName}__number mb-1">
          {l s='3' d='Shop.Theme.Checkout'}
        </span> 
        <button 
          class="{$componentName}__text nav-link w-100 bg-transparent btn p-0 border-0 mb-0"
          data-bs-toggle="tab" 
          data-bs-target="#checkout-delivery-step"
          role="tab"
        >
          {l s='Shipping method' d='Shop.Theme.Checkout'}
        </button>
      </li>

      <li 
        class="{$componentName}__item nav-item js-step-item text-center col-3" 
        data-step="checkout-payment-step"
        role="presentation" 
      >
        <span class="{$componentName}__number mb-1">
          {l s='4' d='Shop.Theme.Checkout'}
        </span> 
        <button 
          class="{$componentName}__text nav-link w-100 bg-transparent btn p-0 border-0 mb-0"
          data-bs-toggle="tab" 
          data-bs-target="#checkout-payment-step"
          role="tab"
        >
          {l s='Payment' d='Shop.Theme.Checkout'}
        </button>
      </li>
    </ul>

    <div class="{$componentName}__mobile mb-0 d-flex align-items-center d-md-none">
      <div class="{$componentName}__left mx-3">
        {include file='components/progress-circle.tpl' classes="text-success col-4" size=74 stroke=4}
      </div>

      <div class="{$componentName}__step d-none" data-step="checkout-personal-information-step">
        <p class="fw-bold fs-5 mb-0">
          {l s='Personal Information' d='Shop.Theme.Checkout'}
        </p>
        <p class="{$componentName}__subtitle mb-0 mt-1">
          {l s='Next: Addresses' d='Shop.Theme.Checkout'}
        </p>
      </div>

      <div class="{$componentName}__step d-none" data-step="checkout-addresses-step">
        <p class="fw-bold fs-5 mb-0">
          {l s='Addresses' d='Shop.Theme.Checkout'}
        </p>
        <p class="{$componentName}__subtitle mb-0 mt-1">
          {l s='Next: Shipping Method' d='Shop.Theme.Checkout'}
        </p>
      </div>

      <div class="{$componentName}__step d-none" data-step="checkout-delivery-step">
        <p class="fw-bold fs-5 mb-0">
          {l s='Shipping Method' d='Shop.Theme.Checkout'}
        </p>
        <p class="{$componentName}__subtitle mb-0 mt-1">
          {l s='Next: Payment' d='Shop.Theme.Checkout'}
        </p>
      </div>

      <div class="{$componentName}__step d-none" data-step="checkout-payment-step">
        <p class="fw-bold fs-5 mb-0">
          {l s='Payment' d='Shop.Theme.Checkout'}
        </p>
      </div>
    </div>
  </div>
{/block}
