{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 *}

{$componentName = 'email-subscription'}

<div class="{$componentName} py-4">
  <div class="container">
    <div class="{$componentName}-content row">
      <div class="{$componentName}-content-left col-md-5">
        <p class="{$componentName}-label">{l s='Get our latest news and special sales' d='Shop.Theme.Global'}</p>
      </div>

      <div class="{$componentName}-content-right col-md-7">
        <form action="{$urls.current_url}#blockEmailSubscription_{$hookName}" method="post">
          <div class="{$componentName}-content-inputs inline-items">
            <input
              name="email"
              type="email"
              class="form-control"
              value="{$value}"
              placeholder="{l s='Your email address' d='Shop.Forms.Labels'}"
              aria-labelledby="block-newsletter-label"
              required
           >

            <input
              class="btn btn-primary d-none d-sm-none d-md-block"
              name="submitNewsletter"
              type="submit"
              value="{l s='Subscribe' d='Shop.Theme.Actions'}"
           >

            <input
              class="btn btn-primary d-none d-sm-block d-md-none"
              name="submitNewsletter"
              type="submit"
              value="{l s='OK' d='Shop.Theme.Actions'}"
           >
          </div>

          <div class="{$componentName}-content-infos">
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
