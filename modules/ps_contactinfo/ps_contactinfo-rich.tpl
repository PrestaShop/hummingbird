{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<div class="ps-contactinfo">
  <p class="h2 ps-contactinfo__title">{l s='Store information' d='Shop.Theme.Global'}</p>

  <div class="ps-contactinfo__item">
    <i class="material-icons" aria-hidden="true">&#xF00F;</i>
    <address class="ps-contactinfo__info">
      {$contact_infos.address.formatted nofilter}
    </address>
  </div>

  {if $contact_infos.phone}
    <hr>
    <div class="ps-contactinfo__item">
      <i class="material-icons" aria-hidden="true">&#xE0CD;</i>
      <div class="ps-contactinfo__info">
        <a href="tel:{$contact_infos.phone}"
           aria-label="{l s='Call us at: %phone%' sprintf=['%phone%' => $contact_infos.phone] d='Shop.Theme.Global'}">
          {$contact_infos.phone}
        </a>
      </div>
    </div>
  {/if}

  {if $contact_infos.fax}
    <hr>
    <div class="ps-contactinfo__item">
      <i class="material-icons" aria-hidden="true">&#xE8AD;</i>
      <div class="ps-contactinfo__info">
        <a href="fax:{$contact_infos.fax}"
           aria-label="{l s='Send a fax to %fax%' sprintf=['%fax%' => $contact_infos.fax] d='Shop.Theme.Global'}">
          {$contact_infos.fax}
        </a>
        <span class="visually-hidden">
          ({l s='Fax number' d='Shop.Theme.Global'})
        </span>
      </div>
    </div>
  {/if}

  {if $contact_infos.email && $display_email}
    <hr>
    <div class="ps-contactinfo__item">
      <i class="material-icons" aria-hidden="true">&#xE158;</i>
      <div class="ps-contactinfo__info ps-contactinfo__info--email">
        <a href="mailto:{$contact_infos.email}"
           aria-label="{l s='Send an email to %email%' sprintf=['%email%' => $contact_infos.email] d='Shop.Theme.Global'}">
          {$contact_infos.email}
        </a>
      </div>
    </div>
  {/if}

  {if !empty($contact_infos.details)}
    <hr>
    <div class="ps-contactinfo__item">
      <i class="material-icons" aria-hidden="true">&#xE88E;</i>
      <div class="ps-contactinfo__info">
        {$contact_infos.details|nl2br nofilter}
      </div>
    </div>
  {/if}
</div>
