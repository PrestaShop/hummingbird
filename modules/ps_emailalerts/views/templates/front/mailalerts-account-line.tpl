{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$componentName = 'mailalerts-account-line'}

<div class="{$componentName} d-flex flex-column position-relative"> 
  <a href="{$mailAlert.link}" class="text-center">
    <img src="{$mailAlert.cover_url}" alt="" />
  </a>
  <a class="mt-2" href="{$mailAlert.link}">
    <div class="{$componentName}__product d-flex flex-column">
      <span class="{$componentName}__product__name">{$mailAlert.name}</span>
      <span class="{$componentName}__product__attributes mt-1">{$mailAlert.attributes_small}</span>
    </div>
  </a>
  <a href="#"
    title="{l s='Remove mail alert' d='Modules.Emailalerts.Shop'}"
    class="js-remove-email-alert btn btn-link {$componentName}__remove"
    rel="js-id-emailalerts-{$mailAlert.id_product|intval}-{$mailAlert.id_product_attribute|intval}"
    data-url="{url entity='module' name='ps_emailalerts' controller='actions' params=['process' => 'remove']}">
    <i class="material-icons" aria-label="{l s='Delete' d='Modules.Emailalerts.Shop'}">delete</i>
  </a>
</div>
