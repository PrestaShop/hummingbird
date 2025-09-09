
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

<template data-ps-ref="password-feedback-template">
  <div
    class="my-3 d-none"
    data-ps-ref="password-feedback-container"
  >
    <div class="progress-container">
      <div class="progress mb-3" aria-hidden="true">
        <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" data-ps-ref="password-strength-progress-bar"></div>
      </div>
    </div>

    <script type="text/javascript" data-ps-ref="password-strength-hints">
      {if !empty($page['password-policy']['feedbacks'])}
        {$page['password-policy']['feedbacks']|@json_encode nofilter}
      {/if}
    </script>

    <div 
      class="password-invalid-message"
      data-ps-ref="password-invalid-message"
      data-ps-data="{l s='Your password is too weak' d='Shop.Theme.Customeraccount'}"
    ></div>
    <div 
      class="password-valid-message"
      data-ps-ref="password-valid-message"
      data-ps-data="{l s='Your password is valid' d='Shop.Theme.Customeraccount'}"
    ></div>
    <div 
      class="password-length-message"
      data-ps-ref="password-length-message"
      data-ps-data="{l s='Your password length is invalid' d='Shop.Theme.Customeraccount'}"
    ></div>
    <div 
      class="password-announce-validity visually-hidden"
      data-ps-target="password-announce-validity"
      aria-live="off"
      aria-atomic="true"
    ></div>

    <div class="password-requirements">
      <p class="password-requirements__length" data-translation="{l s='Enter a password between %s and %s characters' d='Shop.Theme.Customeraccount'}" data-ps-ref="password-requirements-length">
        <i class="password-requirements__icon material-icons" aria-hidden="true" data-ps-ref="password-requirements-length-icon">&#xE86C;</i>
        <span data-ps-ref="password-requirements-length-message"></span>
      </p>

      <p class="password-requirements__score" data-translation="{l s='The minimum score must be: %s' d='Shop.Theme.Customeraccount'}" data-ps-ref="password-requirements-score">
        <i class="password-requirements__icon material-icons" aria-hidden="true" data-ps-ref="password-requirements-score-icon">&#xE86C;</i>
        <span data-ps-ref="password-requirements-score-message"></span>
      </p>
    </div>
  </div>
</template>
