{block name='quick_view_touch'}
  <button class="{$componentName}__quickview-touch btn btn-tertiary btn-square-icon js-quickview" data-link-action="quickview">
    <i class="material-icons">&#xE417;</i>
  </button>
{/block}

{block name='quick_view'}
  <button class="{$componentName}__quickview-button btn btn-tertiary btn-square-icon js-quickview" data-link-action="quickview">
    <i class="material-icons" aria-hidden="true">&#xE417;</i>
    {l s='Quick view' d='Shop.Theme.Actions'}
  </button>
{/block}
