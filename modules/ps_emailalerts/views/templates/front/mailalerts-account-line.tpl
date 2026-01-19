{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<li class="ps-emailalerts__product" data-ps-ref="emailalerts-product"> 
  <a href="{$mailAlert.link}" class="ps-emailalerts__product-image-link" rel="nofollow">
    <img class="ps-emailalerts__product-image img-fluid" src="{$mailAlert.cover_url}" alt="{$mailAlert.name}" loading="lazy">
  </a>

  <div class="ps-emailalerts__product-content">
    <a href="{$mailAlert.link}">
      <span class="ps-emailalerts__product-name">{$mailAlert.name}</span>
    </a>

    {if $mailAlert.attributes_small}
      <span class="ps-emailalerts__product-attributes">
        {l s='Attributes: %attributes%' sprintf=['%attributes%' => $mailAlert.attributes_small] d='Modules.Emailalerts.Shop'}
      </span>
    {/if}

    <button type="button"
      aria-label="{l s='Delete %productName% mail alert' sprintf=['%productName%' => $mailAlert.name] d='Modules.Emailalerts.Shop'}"
      class="link-danger ps-emailalerts__product-remove"
      data-ps-action="emailalerts-remove"
      data-ps-data='{ldelim}"productId":"{$mailAlert.id_product|intval}","productAttributeId":"{$mailAlert.id_product_attribute|intval}","url":"{url entity='module' name='ps_emailalerts' controller='actions' params=['process' => 'remove']}"{rdelim}'
    >
      {l s='Delete' d='Modules.Emailalerts.Shop'}
    </button>
  </div>
</li>
