{**
 * 2007-2020 PrestaShop and Contributors
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2020 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}

{if $status == 'ok'}
    <p>
      {l s='Your order on %s is complete.' sprintf=[$shop_name] d='Modules.Wirepayment.Shop'}<br/>
      {l s='Please send us a bank wire with:' d='Modules.Wirepayment.Shop'}
    </p>
    {include file='module:ps_wirepayment/views/templates/hook/_partials/payment_infos.tpl'}

    <p>
      {l s='Please specify your order reference %s in the bankwire description.' sprintf=[$reference] d='Modules.Wirepayment.Shop'}<br/>
      {l s='We\'ve also sent you this information by e-mail.' d='Modules.Wirepayment.Shop'}
    </p>
    <strong>{l s='Your order will be sent as soon as we receive payment.' d='Modules.Wirepayment.Shop'}</strong>
    <p>
      {l s='If you have questions, comments or concerns, please contact our [1]expert customer support team[/1].' d='Modules.Wirepayment.Shop' sprintf=['[1]' => "<a href='{$contact_url}'>", '[/1]' => '</a>']}
    </p>
{else}
    <p class="warning">
      {l s='We noticed a problem with your order. If you think this is an error, feel free to contact our [1]expert customer support team[/1].' d='Modules.Wirepayment.Shop' sprintf=['[1]' => "<a href='{$contact_url}'>", '[/1]' => '</a>']}
    </p>
{/if}
