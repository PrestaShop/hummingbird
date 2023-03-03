{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<div class="block_newsletter" id="blockEmailSubscription_{$hookName}">
  <form action="{$urls.current_url}#blockEmailSubscription_{$hookName}" method="post">
    <p id="block-newsletter-label-{$hookName}">{l s='Get our latest news and special sales' d='Shop.Theme.Global'}</p>
    <div class="mb-1">
      <input
        class="btn btn-primary float-end"
        name="submitNewsletter"
        type="submit"
        value="{l s='OK' d='Shop.Theme.Actions'}"
      >
      <div class="input-wrapper">
        <input
          name="email"
          type="email"
          value="{$value}"
          placeholder="{l s='Your email address' d='Shop.Forms.Labels'}"
          aria-labelledby="block-newsletter-label-{$hookName}"
          required
        >
      </div>
      <input type="hidden" name="blockHookName" value="{$hookName}" />
      <input type="hidden" name="action" value="0">
      <div></div>
    </div>
    <div>
      {if !empty($conditions)}
        <p>{$conditions}</p>
      {/if}
      {if $msg}
        <p class="alert {if $nw_error}alert-danger{else}alert-success{/if}">
          {$msg}
        </p>
      {/if}
      {hook h='displayNewsletterRegistration'}
      {if isset($id_module)}
        {hook h='displayGDPRConsent' id_module=$id_module}
      {/if}
    </div>
  </form>
</div>
