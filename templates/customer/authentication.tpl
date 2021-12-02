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
{$componentName = 'login'}

{extends file='page.tpl'}

{block name="container_class"}container container--limited-sm{/block}

{block name='page_title'}
  {l s='Sign in' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  {block name='login_form_container'}
    <div class="{$componentName}">
      <section class="{$componentName}__form-wrapper">
        {render file='customer/_partials/login-form.tpl' ui=$login_form}
      </section>
      
      <hr/>

      {block name='display_after_login_form'}
        {hook h='displayCustomerLoginFormAfter'}
      {/block}

      <div class="{$componentName}__register-prompt">
        <h2 class="mb-3">{l s='No account?' d='Shop.Theme.Customeraccount'}</h2>
        <div class="d-grid">
          <a href="{$urls.pages.register}" class="btn btn-outline-primary" data-link-action="display-register-form">
            {l s='Create your account' d='Shop.Theme.Actions'}
          </a>
        </div>
      </div>
    </div>
  {/block}
{/block}
