{*
* 2007-2015 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
* @author    PrestaShop SA <contact@prestashop.com>
* @copyright 2007-2015 PrestaShop SA
* @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
* International Registered Trademark & Property of PrestaShop SA
*}

<div class="ps-emailalerts ps-emailalerts--product"
  data-ps-ref="emailalerts"
  data-ps-component="gdpr"
  data-url="{url entity='module' name='ps_emailalerts' controller='actions' params=['process' => 'add']}">
  <div class="ps-emailalerts__content" data-ps-ref="emailalerts-content">
    <p class="h4 mb-0">
      {l s='Notify me when available' d='Modules.Emailalerts.Shop'}
    </p>

    {if isset($email) AND $email}
      <p class="mb-0">
        {l s='Interested in this product? Drop us an email and we will let you know when it\'s available for order.' d='Modules.Emailalerts.Shop'}
      </p>

      <input class="form-control"
        type="email"
        name="email"
        data-ps-ref="emailalerts-email"
        placeholder="{l s='Your email address' d='Modules.Emailalerts.Shop'}"
        aria-label="{l s='Your email address' d='Modules.Emailalerts.Shop'}"
        autocomplete="email"
      >
    {else}
      <p class="mb-0">
        {l s='Interested in this product? Click below and we will let you know when it\'s available for order.' d='Modules.Emailalerts.Shop'}
      </p>
    {/if}

    {capture name='subscribeData'}{strip}{ldelim}
      "product_id": "{$product.id_product|intval}",
      "product_attribute_id": "{$product.id_product_attribute|intval}"
    {rdelim}{/strip}{/capture}

    <button data-ps-action="emailalerts-subscribe"
      data-ps-ref="gdpr-submit"
      data-ps-data="{$smarty.capture.subscribeData}"
      class="btn btn-primary"
      rel="nofollow"
      role="button"
    >
      {l s='Notify me when available' d='Modules.Emailalerts.Shop'}
    </button>

    {if !empty($id_module)}
      {capture name='gdprContent'}{hook h='displayGDPRConsent' id_module=$id_module}{/capture}

      {if $smarty.capture.gdprContent}
        <div class="fs-6 text-body-secondary">
          {$smarty.capture.gdprContent nofilter}
        </div>
      {/if}
    {/if}
  </div>

  <div class="d-none" data-ps-target="emailalerts-alerts" aria-live="assertive"></div>
</div>
