{**
 * 2007-2020 PrestaShop and Contributors
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2020 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}

{block name='gdpr_checkbox'}
  <div class="gdpr-consent"
    data-ps-ref="gdpr-consent"
    data-module-id="{$psgdpr_id_module|escape:'htmlall':'UTF-8'}"
    data-front-controller="{$psgdpr_front_controller|escape:'htmlall':'UTF-8'}"
    data-id-customer="{$psgdpr_id_customer|escape:'htmlall':'UTF-8'}"
    data-customer-token="{$psgdpr_customer_token|escape:'htmlall':'UTF-8'}"
    data-id-guest="{$psgdpr_id_guest|escape:'htmlall':'UTF-8'}"
    data-guest-token="{$psgdpr_guest_token|escape:'htmlall':'UTF-8'}"
  >
    <span class="form-check">
      <input id="psgdpr_consent_checkbox_{$psgdpr_id_module|escape:'htmlall':'UTF-8'}"
        name="psgdpr_consent_checkbox"
        type="checkbox"
        value="1"
        class="form-check-input"
        data-ps-ref="gdpr-checkbox">
      <label class="form-check-label" for="psgdpr_consent_checkbox_{$psgdpr_id_module|escape:'htmlall':'UTF-8'}">
        {$psgdpr_consent_message nofilter}{* html data *}
      </label>
    </span>
  </div>
{/block}
