{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<div id="_desktop_ps_contactinfo">
  <div class="ps-contactinfo">
    {if $contact_infos.phone}
      <a class="ps-contactinfo__phone" href="tel:{$contact_infos.phone}" aria-label="{l s='Call us at: %phone%' sprintf=['%phone%' => $contact_infos.phone] d='Shop.Theme.Global'}">
        {l s='Call us: %phone%' sprintf=['%phone%' => $contact_infos.phone] d='Shop.Theme.Global'}
      </a>
    {elseif $contact_infos.fax}
      <div class="ps-contactinfo__fax">
        <i class="material-icons" aria-hidden="true">&#xE8AD;</i>
        <a href="fax:{$contact_infos.fax}"
           aria-label="{l s='Send a fax to %fax%' sprintf=['%fax%' => $contact_infos.fax] d='Shop.Theme.Global'}">
          {$contact_infos.fax}
        </a>
        <span class="visually-hidden">
          ({l s='Fax number' d='Shop.Theme.Global'})
        </span>
      </div>
    {else}
      <a class="ps-contactinfo__email" href="{$urls.pages.contact}">
        {l s='Contact us' d='Shop.Theme.Global'}
      </a>
    {/if}
  </div>
</div>
