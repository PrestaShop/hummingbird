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

<div class="footer__block block-contact col-md-6 col-lg-3">

  <p class="footer__block__title hidden-on-mobile">{l s='Store information' d='Shop.Theme.Global'}</p>

  <div class="footer__block__toggle hidden-on-desktop collapsed" data-bs-target="#contact-infos" data-bs-toggle="collapse" aria-expanded="false">
    <span class="footer__block__title">{l s='Store information' d='Shop.Theme.Global'}</span>
    <i class="material-icons">arrow_drop_down</i>
  </div>

  <div id="contact-infos" class="footer__block__content footer__block__content-contact collapse">

    <div class="contact__infos">
      {$contact_infos.address.formatted nofilter}
    </div>

    {if $contact_infos.phone}
      <div class="contact__phone">
        <i class="material-icons">phone</i>
        <a href="tel:{$contact_infos.phone}">{$contact_infos.phone}</a>
      </div>
    {/if}

    {if $contact_infos.fax}
      <div class="contact__fax">
        <i class="material-icons">fax</i>
        <a href="fax:{$contact_infos.fax}">{$contact_infos.fax}</a>
      </div>
    {/if}

    {if $contact_infos.email && $display_email}
      <div class="contact__email">
        <i class="material-icons">mail</i>
        {mailto address=$contact_infos.email encode="javascript"}
      </div>
    {/if}

  </div>
</div>
