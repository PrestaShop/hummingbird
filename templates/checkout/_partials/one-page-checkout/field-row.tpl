{**
 * One Page Checkout - Multi-column field row
 *
 * Renders form fields side by side on desktop, stacked on mobile.
 * Column count adapts to the number of fields passed.
 *
 * @param array $fields - Array of form field objects to render in a row
 *}

<div class="one-page-checkout__row one-page-checkout__row--{$fields|count}">
  {foreach from=$fields item="field"}
    {form_field field=$field}
  {/foreach}
</div>
