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

namespace Toaster {
  export enum Templates {
    container = '<div class="toast-container position-fixed top-0 end-0 p-3" id="js-toast-container"></div>',
    toast     = '<div class="toast" role="alert" aria-live="assertive" aria-atomic="true"><div class="toast-body"></div></div>',
  }

  export enum Themes {
    light     = 'bg-light text-dark border-1',
    dark      = 'bg-dark text-light',
    primary   = 'bg-primary text-white',
    secondary = 'bg-secondary text-black',
    info      = 'bg-info text-black',
    success   = 'bg-success text-white',
    warning   = 'bg-warning text-black',
    danger    = 'bg-danger text-white',
  }

  export interface Options {
    type: keyof typeof Themes;
    autohide?: boolean;
    delay?: number;
    classlist?: string;
  }

  export const defaults: Options = {
    type: 'info',
    autohide: true,
    delay: 3000,
  }
}

export default Toaster;
