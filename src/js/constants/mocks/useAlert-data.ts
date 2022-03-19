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

import * as Alerter from '@constants/useAlert-data';

export const TestMarkupMessage = 'My <b>test</b> message.';
export const TestMarkupTitle = 'My <b>test</b> title.';
export const TestIconCodepoint = '\ue420';
export const TestTypeOption: Alerter.Options = {type: 'primary'};
export const TestClassListOption: Alerter.Options = {type: 'warning', classlist: 'text-warning bg-dark border-1'};
export const TestDismissOption: Alerter.Options = {type: 'danger', dismissible: false};
export const TestHeaderOption: Alerter.Options = {type: 'success', title: TestMarkupTitle, dismissible: true};
export const TestIconOption: Alerter.Options = {type: 'info', icon: TestIconCodepoint};

export const ExpectedTypeClassList = Alerter.Theme[TestTypeOption.type];

export const DefaultAlertType = Alerter.Default.type;

export const LandingContainerClass = 'landing';
export const LandingSelector = `#notifications--alert .${LandingContainerClass}`;
export const LandingContainer = `
  <div id="notifications--alert">
    <div class="${LandingContainerClass}"></div>
  </div>
`;
export const TestSelectorOption: Alerter.Options = {type: 'info', selector: LandingSelector};

export const NotificationsContainer = `
  <div id="notifications">
    <div class="container"></div>
  </div>
`;
