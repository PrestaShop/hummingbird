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

import selectorsMap from '@constants/selectors-map';

const {passwordPolicy: PasswordPolicyMap} = selectorsMap;

export interface PasswordPolicyReturn {
  element?: HTMLElement
  error?: Error
}

const PASSWORD_POLICY_ERROR = 'The password policy elements are undefined.';

const watchPassword = (element: HTMLElement, elementInput: HTMLInputElement, feedbackContainer: HTMLElement, event: Event) => {
  const hintElement = document.querySelector(PasswordPolicyMap.hint);
  const passwordValue = elementInput.value;

  if (hintElement) {
    const hint = {
      "Straight rows of keys are easy to guess": "Straight rows of keys are easy to guess",
    } 
    console.log(hint)
  }
}

// Not testable because it manipulates SVG elements, unsupported by JSDom
const useProgressRing = (selector: string): PasswordPolicyReturn => {
  const element = document.querySelector<HTMLElement>(selector);
  const elementInput = element?.querySelector<HTMLInputElement>('input');
  const templateElement = document.createElement('div');
  const feedbackTemplate = document.querySelector<HTMLTemplateElement>(PasswordPolicyMap.template);
  let feedbackContainer: HTMLElement | null;

  if (feedbackTemplate && element && elementInput) {
    templateElement.innerHTML = feedbackTemplate.innerHTML;
    element.append(templateElement)
    feedbackContainer = element.querySelector<HTMLElement>(PasswordPolicyMap.container);

    if (feedbackContainer) {
      elementInput.addEventListener('keyup', (event) => watchPassword(element, elementInput, feedbackContainer!, event))
    }
  }

  if (element) {
    return {
      element,
    };
  }

  return {
    error: new Error(PASSWORD_POLICY_ERROR),
  };
};

export default useProgressRing;
