{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}

{**
 * OPC — Error state
 * Intended to be embedded as a <template> element so JS can clone it.
 *
 * Variables:
 *   $message (optional) — error message displayed to the user
 *}
<div class="alert alert-danger mb-0 d-flex flex-column flex-sm-row align-items-center gap-2">
  <p class="mb-0 flex-grow-1">
    {if isset($message) && $message}
      {$message|escape:'html'}
    {else}
      {l s='An error occurred. Please try again.' d='Shop.Theme.Checkout'}
    {/if}
  </p>
  {if isset($retry_label) && $retry_label}
    <button type="button" class="btn btn-sm btn-outline-danger flex-shrink-0" data-opc-action="{if isset($retry_action) && $retry_action}{$retry_action|escape:'html'}{else}retry-carriers{/if}">
      {$retry_label|escape:'html'}
    </button>
  {/if}
</div>
