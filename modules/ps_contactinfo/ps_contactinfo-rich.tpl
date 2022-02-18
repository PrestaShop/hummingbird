{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 *}
<div class="contact__details">
  <h2 class="contact__title">{l s='Store information' d='Shop.Theme.Global'}</h4>
  <div class="contact__item">
    <i class="material-icons">&#xE55F;</i>
    <div class="contact__info">{$contact_infos.address.formatted nofilter}</div>
  </div>
  {if $contact_infos.phone}
    <hr/>
    <div class="contact__item">
      <i class="material-icons">&#xE0CD;</i>
      <div class="contact__info"><a href="tel:{$contact_infos.phone}">{$contact_infos.phone}</a></div>
    </div>
  {/if}
  {if $contact_infos.fax}
    <hr/>
    <div class="contact__item">
      <i class="material-icons">&#xE0DF;</i>
      <div class="contact__info">{$contact_infos.fax}</div>
    </div>
  {/if}
  {if $contact_infos.email && $display_email}
    <hr/>
    <div class="contact__item">
      <i class="material-icons">&#xE158;</i>
      <div class="contact__info contact__info--email">{mailto address=$contact_infos.email encode="javascript"}</div>
    </div>
  {/if}
  {if !empty($contact_infos.details)}
    <hr/>
    <div class="contact__item">
      <i class="material-icons">&#xE88E;</i>
      <div class="contact__info">{$contact_infos.details|nl2br nofilter}</div>
    </div>
  {/if}
</div>
