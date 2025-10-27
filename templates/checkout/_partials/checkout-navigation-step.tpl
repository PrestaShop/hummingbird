{$componentName = 'checkout-steps'}

<li 
  class="{$componentName}__step js-step-item" 
  data-step="{$step}" 
  role="presentation" 
>
  <span class="{$componentName}__number">
    {$number}
  </span> 
  <button 
    class="{$componentName}__btn btn btn-link"
    data-bs-toggle="tab" 
    data-bs-target="#{$step}"
    role="tab"
    data-ps-ref="step-button"
    {if isset($virtual) && $virtual}
      disabled
    {/if}
  >
    {$title}
  </button>
</li>
