/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import * as Toaster from '@constants/useToast-data';

export const TestMarkupMessage = 'My <b>test</b> message.';
export const TestTypeOption: Theme.Toast.Options = {type: 'success'};
export const TestClassListOption: Theme.Toast.Options = {type: 'warning', classlist: 'text-warning bg-dark border-1'};
export const TestAutoHideOption: Theme.Toast.Options = {type: 'danger', autohide: false};

export const ExpectedTypeClassList = Toaster.Theme[TestTypeOption.type];

export const DefaultToastType = Toaster.Default.type;
export const FallbackContainerClass = 'toast-container--fallback';
export const FallbackToastClass = 'toast--fallback';
export const OverrideToastClass = 'toast--override';

export const OverrideTemplate = `
  <div class="toast toast--override">
    <div class="toast-header"></div>
    <div class="toast-body"></div>
  </div>
`;
export const TestTemplateOption: Theme.Toast.Options = {type: 'info', template: OverrideTemplate};

export const WithoutContainer = '';
export const WithContainerWithoutTemplate = `
  <div class="toast-container" id="js-toast-container"></div>
`;
export const WithContainerWithTemplate = `
  <div class="toast-container" id="js-toast-container">
    <template class="js-toast-template">
      <div class="toast">
        <div class="toast-body"></div>
        <button type="button" class="btn-close me-2 m-auto d-none" data-bs-dismiss="toast"></button>
      </div>
    </template>
  </div>
`;
