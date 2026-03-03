{**
 * Multi-column form field row
 *
 * Renders an explicit set of form fields side by side on desktop, stacked on
 * mobile. The grid column count is derived from the number of fields passed.
 *
 * This partial is intentionally "dumb": it only handles layout. The caller is
 * responsible for deciding which fields belong together in the same row and for
 * ensuring all passed fields actually exist before including this template.
 *
 *
 * @param array $fields - Explicit list of form field objects to render in a row
 *                        (2 or 3 items — matches CSS modifiers --2 and --3)
 *}

<div class="form-fields-row form-fields-row--{$fields|count}">
  {foreach from=$fields item="field"}
    {form_field field=$field}
  {/foreach}
</div>
