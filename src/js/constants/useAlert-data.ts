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

import {Alert} from 'bootstrap';

export const Theme = {
  light: 'alert-light',
  dark: 'alert-dark',
  primary: 'alert-primary',
  secondary: 'alert-secondary',
  info: 'alert-info',
  success: 'alert-success',
  warning: 'alert-warning',
  danger: 'alert-danger',
};

export const Codepoint = {
  light: 'e88f',
  dark: 'e88f',
  primary: 'e88f',
  secondary: 'e88f',
  info: 'e88e',
  success: 'e5ca',
  warning: 'e002',
  danger: 'e000',
};

export const Template = `
  <div class="alert alert-dismissible fade d-flex flex-wrap align-items-center" role="alert">
    <h4 class="alert-heading w-100 d-none"></h4>
    <i class="material-icons flex-shrink-0 me-2"></i>
    <div class="alert-body flex-fill"></div>
    <button type="button" class="btn-close ms-2" data-bs-dismiss="alert"></button>
  </div>
`;

export const Default: Options = {
  type: 'info',
  dismissible: true,
};

export interface Options {
  type: keyof typeof Theme;
  icon?: string;
  title?: string;
  dismissible?: boolean;
  classlist?: string;
  selector?: string;
}

export interface Instance {
  instance: Alert | null;
  element: HTMLElement | null;
  show: () => boolean;
  hide: () => boolean;
  dispose: () => boolean;
  remove: () => boolean;
  title: (markup?: string) => string | boolean;
  message: (markup?: string) => string | boolean;
}
