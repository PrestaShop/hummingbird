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
{$componentName = 'checkout__steps'}

{block name='checkout_steps'}
  <div class="{$componentName} bg-light border-top border-bottom d-flex justify-content-center py-4 mb-5">
    <ul class="{$componentName}__list d-flex align-items-start justify-content-between mb-0">
      <li class="{$componentName}__item {$componentName}--current text-center">
        <span class="{$componentName}__number mb-1">
          {l s='1' d='Shop.Theme.Checkout'}
        </span> 
        <p class="{$componentName}__text mb-0">
          {l s='Personal Information' d='Shop.Theme.Checkout'}
        </p>
      </li>

      <li class="{$componentName}__item text-center">
        <span class="{$componentName}__number mb-1">
          {l s='2' d='Shop.Theme.Checkout'}
        </span> 
        <p class="{$componentName}__text mb-0">
          {l s='Addresses' d='Shop.Theme.Checkout'}
        </p>
      </li>

      <li class="{$componentName}__item text-center">
        <span class="{$componentName}__number mb-1">
          {l s='3' d='Shop.Theme.Checkout'}
        </span> 
        <p class="{$componentName}__text mb-0">
          {l s='Shipping method' d='Shop.Theme.Checkout'}
        </p>
      </li>

      <li class="{$componentName}__item text-center">
        <span class="{$componentName}__number mb-1">
          {l s='4' d='Shop.Theme.Checkout'}
        </span> 
        <p class="{$componentName}__text mb-0">
          {l s='Payment' d='Shop.Theme.Checkout'}
        </p>
      </li>
    </li>
  </div>
{/block}
