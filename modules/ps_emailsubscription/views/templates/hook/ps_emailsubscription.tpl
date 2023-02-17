{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{$componentName = 'email-subscription'}

<div class="{$componentName} px-0 py-4">
  <div class="container px-1">
    <div class="{$componentName}__content row">
      <div class="{$componentName}__content__left col-md-5">
        <p id="block-newsletter-label-{$hookName}" class="{$componentName}__label">{l s='Get our latest news and special sales' d='Shop.Theme.Global'}</p>
      </div>

      <div class="{$componentName}__content__right col-md-7">
        <form action="{$urls.current_url}#blockEmailSubscription_{$hookName}" method="post">
          <div class="{$componentName}__content__inputs inline-items">
            <input
              name="email"
              type="email"
              class="form-control"
              value="{$value}"
              placeholder="{l s='Your email address' d='Shop.Forms.Labels'}"
              aria-labelledby="block-newsletter-label-{$hookName}"
              required
           >

            <input
              class="btn btn-primary"
              name="submitNewsletter"
              type="submit"
              value="{l s='Subscribe' d='Shop.Theme.Actions'}"
           >
          </div>

          <div class="{$componentName}__content__infos">
            {if $conditions}
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

          <input type="hidden" name="blockHookName" value="{$hookName}" />
          <input type="hidden" name="action" value="0">
        </form>
      </div>
    </div>
  </div>
</div>
