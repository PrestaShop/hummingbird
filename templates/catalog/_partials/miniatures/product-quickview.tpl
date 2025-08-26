{block name='quick_view'}
  <button class="{$componentName}__quickview-button btn btn-tertiary btn-square-icon js-quickview" data-ps-action="open-quickview" data-ps-ref="quickview-button" aria-label="{l s='Quick view' d='Shop.Theme.Actions'} {$product.name}">
    <i class="material-icons" aria-hidden="true">&#xE417;</i>
    {l s='Quick view' d='Shop.Theme.Actions'}
  </button>
{/block}

{block name='quick_view_touch'}
  <button class="{$componentName}__quickview-touch btn btn-tertiary btn-square-icon js-quickview" data-ps-action="open-quickview" aria-label="{l s='Quick view' d='Shop.Theme.Actions'} {$product.name}">
    <i class="material-icons">&#xE417;</i>
  </button>
{/block}
