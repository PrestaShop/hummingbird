{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<div class="ps-contactinfo footer-block col-md-6 col-lg-3">
  <h2 class="footer-block__title footer-block__title--toggle">
    {l s='Store information' d='Shop.Theme.Global'}
    <button class="stretched-link collapsed d-md-none"
            aria-expanded="true"
            data-bs-target="#footer_contactinfo"
            data-bs-toggle="collapse">
      <i class="material-icons" aria-hidden="true">&#xE313;</i>
    </button>
  </h2>

  <div class="footer-block__content collapse" id="footer_contactinfo">
    <address class="ps-contactinfo__infos">
      {$contact_infos.address.formatted nofilter}
    </address>

    {if $contact_infos.phone}
      <div class="ps-contactinfo__phone">
        <i class="material-icons" aria-hidden="true">&#xE0CD;</i>
        <a href="tel:{$contact_infos.phone}"
           aria-label="{l s='Call %phone%' sprintf=['%phone%' => $contact_infos.phone] d='Shop.Theme.Global'}">
          {$contact_infos.phone}
        </a>
      </div>
    {/if}

    {if $contact_infos.fax}
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
    {/if}

    {if $contact_infos.email && $display_email}
      <div class="ps-contactinfo__email">
        <i class="material-icons" aria-hidden="true">&#xE158;</i>
        <a href="mailto:{$contact_infos.email}"
           aria-label="{l s='Send an email to %email%' sprintf=['%email%' => $contact_infos.email] d='Shop.Theme.Global'}">
          {$contact_infos.email}
        </a>
      </div>
    {/if}
  </div>
</div>
