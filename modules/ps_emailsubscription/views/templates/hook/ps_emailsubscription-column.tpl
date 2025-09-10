{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<section class="ps-emailsubscription ps-emailsubscription--column left-block" id="emailsubscription_anchor_{$hookName}">
  <p class="left-block__title">
    {l s='Get our latest news and special sales' d='Shop.Theme.Global'}
  </p>

  <form action="{$urls.current_url}#emailsubscription_anchor_{$hookName}" method="post">
    {if $msg}
      <div class="alert {if $nw_error}alert-danger{else}alert-success{/if} alert-dismissible fade show mb-2" role="alert" tabindex="0">
        {$msg}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
    {/if}
    <input class="form-control mb-2" type="email" name="email" value="{$value}" placeholder="{l s='Your email address' d='Modules.Emailsubscription.Shop'}" aria-label="{l s='Your email address' d='Modules.Emailsubscription.Shop'}" autocomplete="email" required />
    <input class="btn btn-primary mb-2 w-100" type="submit" name="submitNewsletter" value="{l s='Subscribe' d='Shop.Theme.Actions'}" aria-label="{l s='Subscribe to our newsletter' d='Modules.Emailsubscription.Shop'}" id="alert-email-subscription" />
    {capture name="display_gdpr_consent"}{hook h='displayGDPRConsent' id_module=$id_module}{/capture}
    {if isset($smarty.capture.display_gdpr_consent) && $smarty.capture.display_gdpr_consent}
      <div class="fs-6 mb-2">
        {$smarty.capture.display_gdpr_consent nofilter}
      </div>
    {/if}

    {if $conditions}
      <p class="fs-6 text-body-secondary mb-0">{$conditions}</p>
    {/if}

    {hook h='displayNewsletterRegistration'}

    <input type="hidden" value="{$hookName}" name="blockHookName" />
    <input type="hidden" name="action" value="0" />
  </form>
</section>
