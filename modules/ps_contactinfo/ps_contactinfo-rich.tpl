{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
 <div class="ps-contactinfo">
  <p class="h2 ps-contactinfo__title">{l s='Store information' d='Shop.Theme.Global'}</p>
  <div class="ps-contactinfo__item">
    <i class="material-icons" aria-hidden="true">&#xF00F;</i>
    <div class="ps-contactinfo__info">{$contact_infos.address.formatted nofilter}</div>
  </div>
  {if $contact_infos.phone}
    <hr/>
    <div class="ps-contactinfo__item">
      <i class="material-icons" aria-hidden="true">&#xE0CD;</i>
      <div class="ps-contactinfo__info"><a href="tel:{$contact_infos.phone}">{$contact_infos.phone}</a></div>
    </div>
  {/if}
  {if $contact_infos.fax}
    <hr/>
    <div class="ps-contactinfo__item">
      <i class="material-icons" aria-hidden="true">&#xE8AD;</i>
      <div class="ps-contactinfo__info">{$contact_infos.fax}</div>
    </div>
  {/if}
  {if $contact_infos.email && $display_email}
    <hr/>
    <div class="ps-contactinfo__item">
      <i class="material-icons" aria-hidden="true">&#xE158;</i>
      <div class="ps-contactinfo__info ps-contactinfo__info--email">{mailto address=$contact_infos.email encode="javascript"}</div>
    </div>
  {/if}
  {if !empty($contact_infos.details)}
    <hr/>
    <div class="ps-contactinfo__item">
      <i class="material-icons" aria-hidden="true">&#xE88E;</i>
      <div class="ps-contactinfo__info">{$contact_infos.details|nl2br nofilter}</div>
    </div>
  {/if}
</div>
