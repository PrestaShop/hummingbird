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
/* eslint-disable */
// @ts-ignore
//import $ from "expose-loader?exposes=$,jQuery!jquery";

import './prestashop';
import 'bootstrap-input-spinner/src/bootstrap-input-spinner';
import './responsive-toggler';
import initQuantityInput from './qty-input';
import initQuickview from './quickview';
import './modules/blockcart';
import initProductBehavior from './product';
import './mobile-menu';
import './modules/ps_searchbar';
import './modules/facetedsearch';
import SelectorsMap from './selectors-map';
/* eslint-enable */

prestashop.themeSelectors = SelectorsMap;

$(document).ready(() => {
  initProductBehavior();
  initQuantityInput();
  initQuickview();
});
