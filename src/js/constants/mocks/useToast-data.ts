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

import * as Toaster from '@constants/useToast-data';

export const TestMarkupMessage = 'My <b>test</b> message.';
export const TestTypeOption: Toaster.Options = {type: 'success'};
export const TestClassListOption: Toaster.Options = {type: 'warning', classlist: 'text-warning bg-dark border-1'};
export const TestAutoHideOption: Toaster.Options = {type: 'danger', autohide: false};

export const ExpectedTypeClassList = Toaster.Theme[TestTypeOption.type];

export const DefaultToastType = Toaster.Default.type;
export const FallbackContainerClass = 'toast-container--fallback';
export const OverriddenContainerClass = 'toast-container--override';
export const OverriddenToastSelector = '.toast--override';

export const OverrideTemplate = `
  <div class="toast-container toast-container--override position-fixed bottom-0 end-0 p-3" id="js-toast-container">
    <template class="js-toast-template">
      <div class="toast toast--override" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
          <strong class="me-auto">Override</strong>
          <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
        <div class="toast-body"></div>
      </div>
    </template>
  </div>
`;
export const TestTemplateOption: Toaster.Options = {type: 'info', template: OverrideTemplate};

export const WithoutContainer = '';
export const WithContainerWithoutTemplate = `
  <div class="toast-container position-fixed top-0 end-0 p-3" id="js-toast-container"></div>
`;
export const WithContainerWithTemplate = `
  <div class="toast-container position-fixed top-0 end-0 p-3" id="js-toast-container">
    <template class="js-toast-template">
      <div class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
          <div class="toast-body"></div>
          <button type="button" class="btn-close me-2 m-auto d-none" data-bs-dismiss="toast"></button>
        </div>
      </div>
    </template>
  </div>
`;
