{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<div class="contact__details">
  <p class="h2 contact__title">{l s='Store information' d='Shop.Theme.Global'}</p>
  <div class="contact__item">
    <i class="material-icons" aria-hidden="true">&#xE55F;</i>
    <div class="contact__info">{$contact_infos.address.formatted nofilter}</div>
  </div>
  {if $contact_infos.phone}
    <hr/>
    <div class="contact__item">
      <i class="material-icons" aria-hidden="true">&#xE0CD;</i>
      <div class="contact__info"><a href="tel:{$contact_infos.phone}">{$contact_infos.phone}</a></div>
    </div>
  {/if}
  {if $contact_infos.fax}
    <hr/>
    <div class="contact__item">
      <i class="material-icons" aria-hidden="true">&#xE0DF;</i>
      <div class="contact__info">{$contact_infos.fax}</div>
    </div>
  {/if}
  {if $contact_infos.email && $display_email}
    <hr/>
    <div class="contact__item">
      <i class="material-icons" aria-hidden="true">&#xE158;</i>
      <div class="contact__info contact__info--email">{mailto address=$contact_infos.email encode="javascript"}</div>
    </div>
  {/if}
  {if !empty($contact_infos.details)}
    <hr/>
    <div class="contact__item">
      <i class="material-icons" aria-hidden="true">&#xE88E;</i>
      <div class="contact__info">{$contact_infos.details|nl2br nofilter}</div>
    </div>
  {/if}
</div>
