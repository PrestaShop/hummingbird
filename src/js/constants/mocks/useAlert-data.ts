/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
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
