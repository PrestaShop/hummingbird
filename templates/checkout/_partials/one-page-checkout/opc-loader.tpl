{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}

{**
 * OPC — Loader / spinner
 * Intended to be embedded as a <template> element so JS can clone it.
 *
 * Variables:
 *   $message (optional) — text displayed below the spinner
 *}
<div class="d-flex flex-column justify-content-center align-items-center h-100 gap-2 py-3">
  <div class="spinner-border text-primary" role="status">
    <span class="visually-hidden">{l s='Loading...' d='Shop.Theme.Checkout'}</span>
  </div>
  {if isset($message) && $message}
    <p class="text-muted small mb-0">{$message|escape:'html'}</p>
  {/if}
</div>
