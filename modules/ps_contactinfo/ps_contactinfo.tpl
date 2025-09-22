{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<section
  class="ps-contactinfo footer-block col-md-6 col-lg-3"
  aria-labelledby="footer_contactinfo_title"
>
  <p
    id="footer_contactinfo_title"
    class="footer-block__title footer-block__title--toggle"
  >
    {l s='Store information' d='Shop.Theme.Global'}
    <button
      class="stretched-link collapsed d-md-none"
      type="button"
      data-bs-toggle="collapse"
      data-bs-target="#footer_contactinfo"
      aria-expanded="false"
      aria-controls="footer_contactinfo"
    >
      <span class="visually-hidden">
        {l s='Toggle store information' d='Shop.Theme.Global'}
      </span>
      <i class="material-icons" aria-hidden="true">&#xE313;</i>
    </button>
  </p>

  <div class="footer-block__content collapse" id="footer_contactinfo">

    {if $contact_infos.address.formatted}
      <address class="ps-contactinfo__infos">
        {$contact_infos.address.formatted nofilter}
      </address>
    {/if}

    {if $contact_infos.phone}
      <div class="ps-contactinfo__phone">
        <i class="material-icons" aria-hidden="true">&#xE0CD;</i>
        <a href="tel:{$contact_infos.phone}"
           aria-label="{l s='Call us at: %phone%' sprintf=['%phone%' => $contact_infos.phone] d='Shop.Theme.Global'}">
          {$contact_infos.phone}
        </a>
      </div>
    {/if}

    {if $contact_infos.fax}
      <div class="ps-contactinfo__fax">
        <i class="material-icons" aria-hidden="true">&#xE8AD;</i>
        <a href="tel:{$contact_infos.fax}"
           aria-label="{l s='Send us a fax to: %fax%' sprintf=['%fax%' => $contact_infos.fax] d='Shop.Theme.Global'}">
          {$contact_infos.fax}
        </a>
      </div>
    {/if}

    {if $contact_infos.email && $display_email}
      <div class="ps-contactinfo__email">
        <i class="material-icons" aria-hidden="true">&#xE158;</i>
        <a href="mailto:{$contact_infos.email}"
           aria-label="{l s='Send us an email to: %email%' sprintf=['%email%' => $contact_infos.email] d='Shop.Theme.Global'}">
          {$contact_infos.email}
        </a>
      </div>
    {/if}

  </div>
</section>
