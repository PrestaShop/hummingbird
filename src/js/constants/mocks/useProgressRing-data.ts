/**
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
 */

/* eslint-disable max-len */

export const Template = `
  <svg class="progress-ring text-success col-4" width="74" height="74" style="width: 74px; height: 74px;">
    <circle class="progress-ring__background-circle" stroke-width="4" fill="transparent" r="29" cx="37" cy="37"></circle>
    <circle class="progress-ring__circle" stroke="currentColor" stroke-width="4" data-percent="75" fill="transparent" r="29" cx="37" cy="37" style="stroke-dasharray: 182.212, 182.212; stroke-dashoffset: 45.5531;"></circle>
    <text x="50%" y="50%" dominant-baseline="middle" text-anchor="middle">3 / 4</text>
  </svg>
 `;

export const TemplateWithoutText = `
  <svg class="progress-ring text-success col-4" width="74" height="74" style="width: 74px; height: 74px;">
    <circle class="progress-ring__background-circle" stroke-width="4" fill="transparent" r="29" cx="37" cy="37"></circle>
    <circle class="progress-ring__circle" stroke="currentColor" stroke-width="4" data-percent="75" fill="transparent" r="29" cx="37" cy="37" style="stroke-dasharray: 182.212, 182.212; stroke-dashoffset: 45.5531;"></circle>
  </svg>
 `;

export default {
  Template,
  TemplateWithoutText,
};
