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
    {else}
      <a class="ps-contactinfo__email" href="{$urls.pages.contact}">
        {l s='Contact us' d='Shop.Theme.Global'}
      </a>
    {/if}
  </div>
</div>
