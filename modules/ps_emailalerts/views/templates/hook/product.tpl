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

<div class="card card-body text-center js-mailalert mb-3 mt-3 bg-light" data-url="{url entity='module' name='ps_emailalerts' controller='actions' params=['process' => 'add']}">
    {if isset($email) AND $email}
        <p>{l s='Interested in this product? Drop us an email and we will let you know when it\'s available for order.' d='Modules.Emailalerts.Shop'}</p>
        <input class="form-control" type="email" placeholder="{l s='your@email.com' d='Modules.Emailalerts.Shop'}"/>
    {else}
        <p>{l s='Interested in this product? Click below and we will let you know when it\'s available for order.' d='Modules.Emailalerts.Shop'}</p>
    {/if}

    {if !empty($id_module)}
        {capture name='gdprContent'}{hook h='displayGDPRConsent' id_module=$id_module}{/capture}
        {if $smarty.capture.gdprContent != ''}
          <div class="gdpr_consent_wrapper mt-1">{$smarty.capture.gdprContent nofilter}</div>
        {/if}       
    {/if}

    <button
        data-product="{$product.id_product}"
        data-product-attribute="{$product.id_product_attribute}"
        class="btn btn-primary js-mailalert-add mt-1"
        rel="nofollow">
        {l s='Notify me when available' d='Modules.Emailalerts.Shop'}
    </button>
    <div class="js-mailalert-alerts d-none"></div>
</div>
