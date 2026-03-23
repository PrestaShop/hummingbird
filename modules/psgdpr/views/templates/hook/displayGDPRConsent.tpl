{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}

{block name='gdpr_checkbox'}
  {capture name='gdprData'}{strip}{ldelim}
    "id_module": "{$psgdpr_id_module|escape:'htmlall':'UTF-8'}",
    "front_controller": "{$psgdpr_front_controller|escape:'htmlall':'UTF-8'}",
    "id_customer": "{$psgdpr_id_customer|escape:'htmlall':'UTF-8'}",
    "customer_token": "{$psgdpr_customer_token|escape:'htmlall':'UTF-8'}",
    "id_guest": "{$psgdpr_id_guest|escape:'htmlall':'UTF-8'}",
    "guest_token": "{$psgdpr_guest_token|escape:'htmlall':'UTF-8'}"
  {rdelim}{/strip}{/capture}

  <div id="gdpr_consent_{$psgdpr_id_module|escape:'htmlall':'UTF-8'}"
    class="gdpr-consent"
    data-ps-ref="gdpr-consent"
    data-ps-data="{$smarty.capture.gdprData}"
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
