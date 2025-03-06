{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<section class="ps-emailsubscription bg-body-tertiary py-3 py-lg-4" id="emailsubscription_anchor_{$hookName}">
  <div class="container">
    <div class="row justify-content-center">
      <p class="h3 col-lg-4">
        {l s='Get our latest news and special sales' d='Shop.Theme.Global'}
      </p>

      <form class="col-lg-6" action="{$urls.current_url}#emailsubscription_anchor_{$hookName}" method="post">
        <div class="d-flex gap-2 align-items-center mb-2">
          <input class="form-control flex-grow-1" type="email" name="email" value="{$value}" placeholder="{l s='Your email address' d='Modules.Emailsubscription.Shop'}" aria-label="{l s='Your email address' d='Modules.Emailsubscription.Shop'}" required />
          <input class="btn btn-primary" type="submit" name="submitNewsletter" value="{l s='Subscribe' d='Shop.Theme.Actions'}" />
        </div>

        {if $msg}
          <div class="alert {if $nw_error}alert-danger{else}alert-success{/if} alert-dismissible fade show mb-2" role="alert">
            {$msg}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
          </div>
        {/if}

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
    </div>
  </div>
</section>
