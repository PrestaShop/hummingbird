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
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 *}
 {extends file='customer/page.tpl'}

 {block name='page_title'}
    {l s='GDPR - Personal data' mod='psgdpr'}
 {/block}
 
 {block name='page_content'}
  <div class="mb-4">
    <h2 class="h5">{l s='Access to my data' mod='psgdpr'}</h2>
    <p>{l s='At any time, you have the right to retrieve the data you have provided to our site. Click on "Get my data" to automatically download a copy of your personal data on a pdf or csv file.' mod='psgdpr'}</p>
    <a id="exportDataToCsv" class="btn btn-outline-primary d-block d-sm-inline-block mx-0 mb-2 mb-sm-0" target="_blank" href="{$psgdpr_csv_controller|escape:'htmlall':'UTF-8'}"><i class="material-icons" aria-hidden="true">download</i> {l s='Get my data to CSV' mod='psgdpr'}</a>
    <a id="exportDataToPdf" class="btn btn-outline-primary d-block d-sm-inline-block mx-0 mx-sm-2" target="_blank" href="{$psgdpr_pdf_controller|escape:'htmlall':'UTF-8'}"><i class="material-icons" aria-hidden="true">download</i> {l s='Get my data to PDF' mod='psgdpr'}</a>
  </div>

  <h2 class="h5">{l s='Rectification & Erasure requests' mod='psgdpr'}</h2>
  <p>{l s='You have the right to modify all the personal information found in the "My Account" page. For any other request you might have regarding the rectification and/or erasure of your personal data, please contact us through our' mod='psgdpr'} <a href="{$psgdpr_contactUrl|escape:'htmlall':'UTF-8'}">{l s='contact page' mod='psgdpr'}</a>. {l s='We will review your request and reply as soon as possible.' mod='psgdpr'}</p>

 {literal}
 <script type="text/javascript">
     var psgdpr_front_controller = "{/literal}{$psgdpr_front_controller|escape:'htmlall':'UTF-8'}{literal}";
     var psgdpr_id_customer = "{/literal}{$psgdpr_front_controller|escape:'htmlall':'UTF-8'}{literal}";
     var psgdpr_ps_version = "{/literal}{$psgdpr_ps_version|escape:'htmlall':'UTF-8'}{literal}";
 </script>
 {/literal}
 {/block}
 
 