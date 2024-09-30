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
import {sprintf} from 'sprintf-js';
import {Popover} from 'bootstrap';

const {passwordPolicy: PasswordPolicyMap} = selectorsMap;

export interface PasswordPolicyReturn {
  element?: HTMLElement
  error?: Error
}

const PASSWORD_POLICY_ERROR = 'The password policy elements are undefined.';

const getPasswordStrengthFeedback = (
  strength: number,
) => {
  switch (strength) {
    case 0:
      return {
        color: 'bg-danger',
      };

    case 1:
      return {
        color: 'bg-danger',
      };

    case 2:
      return {
        color: 'bg-warning',
      };

    case 3:
      return {
        color: 'bg-success',
      };

    case 4:
      return {
        color: 'bg-success',
      };

    default:
      throw new Error('Invalid password strength indicator.');
  }
};

const watchPassword = async (
  elementInput: HTMLInputElement,
  feedbackContainer: HTMLElement,
  hints: Record<string, string>,
) => {
  const {prestashop} = window;
  const passwordValue = elementInput.value;
  const elementIcon = feedbackContainer.querySelector(PasswordPolicyMap.requirementScoreIcon);
  const result = await prestashop.checkPasswordScore(passwordValue);
  const feedback = getPasswordStrengthFeedback(result.score);
  const passwordLength = passwordValue.length;
  const popoverContent:string[] = [];
  const previousPopover = Popover.getInstance(elementInput);

  if (previousPopover) {
    previousPopover.dispose();
  }

  feedbackContainer.classList.toggle('d-none', passwordValue === '');

  if (result.feedback.warning !== '') {
    if (result.feedback.warning in hints) {
      popoverContent.push(hints[result.feedback.warning]);
    }
  }

  result.feedback.suggestions.forEach((suggestion: string) => {
    if (suggestion in hints) {
      popoverContent.push(hints[suggestion]);
    }
  });

  const popover = new Popover(
    elementInput,
    {
      html: true,
      placement: 'top',
      content: popoverContent.join('<br/>'),
    },
  );
  popover.show();

  const passwordLengthValid = passwordLength >= parseInt(<string>elementInput.dataset.minlength, 10)
    && passwordLength <= parseInt(<string>elementInput.dataset.maxlength, 10);
  const passwordScoreValid = parseInt(<string>elementInput.dataset.minscore, 10) <= result.score;

  feedbackContainer.querySelector(PasswordPolicyMap.requirementLengthIcon)?.classList.toggle(
    'text-success',
    passwordLengthValid,
  );

  elementIcon?.classList.toggle(
    'text-success',
    passwordScoreValid,
  );

  // Change input border color depending on the validity
  elementInput
    .classList.remove('border-success', 'border-danger');
  elementInput
    .classList.add(passwordScoreValid && passwordLengthValid ? 'border-success' : 'border-danger');
  elementInput
    .classList.add('form-control', 'border');

  const percentage = (result.score * 20) + 20;
  const progressBar = feedbackContainer.querySelector<HTMLElement>(PasswordPolicyMap.progressBar);

  // increase and decrease progress bar
  if (progressBar) {
    progressBar.style.width = `${percentage}%`;
    progressBar.classList.remove('bg-success', 'bg-danger', 'bg-warning');
    progressBar.classList.add(feedback.color);
  }
};

// Not testable because it manipulates SVG elements, unsupported by JSDom
const usePasswordPolicy = (selector: string): PasswordPolicyReturn => {
  const element = document.querySelector<HTMLElement>(selector);
  const elementInput = element?.querySelector<HTMLInputElement>('input');
  const templateElement = document.createElement('div');
  const feedbackTemplate = document.querySelector<HTMLTemplateElement>(PasswordPolicyMap.template);

  if (feedbackTemplate && element && elementInput) {
    templateElement.innerHTML = feedbackTemplate.innerHTML;
    element.append(templateElement);
    const feedbackContainer = element.querySelector<HTMLElement>(PasswordPolicyMap.container);

    if (feedbackContainer) {
      const hintElement = document.querySelector(PasswordPolicyMap.hint);

      if (hintElement) {
        const hints = ((content) => {
          try {
            return JSON.parse(content);
          } catch {
            return false;
          }
        })(hintElement.innerHTML);

        if (hints) {
          // eslint-disable-next-line max-len
          const passwordRequirementsLength = feedbackContainer.querySelector<HTMLElement>(PasswordPolicyMap.requirementLength);
          // eslint-disable-next-line max-len
          const passwordRequirementsScore = feedbackContainer.querySelector<HTMLElement>(PasswordPolicyMap.requirementScore);
          const passwordLengthText = passwordRequirementsLength?.querySelector<HTMLElement>('span');
          const passwordRequirementsText = passwordRequirementsScore?.querySelector<HTMLElement>('span');

          if (passwordLengthText && passwordRequirementsLength && passwordRequirementsLength.dataset.translation) {
            passwordLengthText.innerText = sprintf(
              passwordRequirementsLength.dataset.translation,
              elementInput.dataset.minlength,
              elementInput.dataset.maxlength,
            );
          }

          if (passwordRequirementsText && passwordRequirementsScore && passwordRequirementsScore.dataset.translation) {
            passwordRequirementsText.innerText = sprintf(
              passwordRequirementsScore.dataset.translation,
              hints[<string>elementInput.dataset.minscore],
            );
          }

          // eslint-disable-next-line max-len, @typescript-eslint/no-non-null-assertion
          elementInput.addEventListener('keyup', () => watchPassword(elementInput, feedbackContainer, hints));
          elementInput.addEventListener('blur', () => {
            const previousPopover = Popover.getInstance(elementInput);

            if (previousPopover) {
              previousPopover.dispose();
            }
          });
        }
      }
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

export default usePasswordPolicy;
