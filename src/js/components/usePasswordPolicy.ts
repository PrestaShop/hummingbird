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
import debounce from '@helpers/debounce';
import {sprintf} from 'sprintf-js';

const {passwordPolicy: PasswordPolicyMap} = selectorsMap;

export interface PasswordPolicyReturn {
  element?: HTMLElement
  error?: Error
  cleanup?: () => void
}

// Utility function to safely parse JSON
const safeParseJSON = (jsonString: string): Record<string, string> => {
  try {
    return JSON.parse(jsonString);
  } catch {
    return {};
  }
};

// Utility function to update requirement icons
const updateRequirementIcons = (
  feedbackContainer: HTMLElement,
  elementInput: HTMLInputElement,
  strengthValid: boolean,
): void => {
  const lengthIcon = feedbackContainer.querySelector(PasswordPolicyMap.requirementLengthIcon);
  const scoreIcon = feedbackContainer.querySelector(PasswordPolicyMap.requirementScoreIcon);

  // Password length validation
  const lengthValid = !elementInput.validity.tooShort && !elementInput.validity.tooLong;

  if (lengthIcon) {
    lengthIcon.classList.toggle('text-success', lengthValid);
    lengthIcon.classList.toggle('text-danger', !lengthValid);
  }

  // Password strength validation
  if (scoreIcon) {
    scoreIcon.classList.toggle('text-success', strengthValid);
    scoreIcon.classList.toggle('text-danger', !strengthValid);
  }
};

// Utility function to update progress bar
const updateProgressBar = (
  feedbackContainer: HTMLElement,
  strength: number,
): void => {
  const strengthFeedback = getProgressBarInfo(strength);
  const progressBar = feedbackContainer.querySelector<HTMLElement>(PasswordPolicyMap.progressBar);

  if (progressBar) {
    progressBar.style.width = `${strengthFeedback.percentage}%`;
    progressBar.classList.remove('bg-success', 'bg-danger');
    progressBar.classList.add(strengthFeedback.color);
  }
};

// Utility function to build validation message
const buildValidationMessage = (
  feedbackContainer: HTMLElement,
  result: {feedback: {warning: string, suggestions: string[]}},
  hints: Record<string, string>,
  lengthValid: boolean,
  strengthValid: boolean,
): string => {
  let message = '';

  // Get base message
  if (!lengthValid) {
    const invalidElement = feedbackContainer.querySelector(PasswordPolicyMap.lengthMessage) as HTMLElement;
    message = `${invalidElement?.dataset?.psData}\n` || 'Your password length is invalid \n';
  } else if (!strengthValid) {
    const invalidElement = feedbackContainer.querySelector(PasswordPolicyMap.invalidMessage) as HTMLElement;
    message = `${invalidElement?.dataset?.psData}\n` || 'Your password is too weak \n';
  }

  // Get hints suggestions
  if (result.feedback.warning && result.feedback.warning in hints) {
    message += `\n${hints[result.feedback.warning]}\n`;
  }

  if (result.feedback.suggestions) {
    result.feedback.suggestions.forEach((suggestion: string) => {
      if (suggestion && suggestion in hints) {
        message += message ? `\n${hints[suggestion]}` : hints[suggestion];
      }
    });
  }

  return message;
};

// Utility function to get password strength feedback
const getProgressBarInfo = (strength: number) => {
  const strengthLevels = {
    0: {color: 'bg-danger', percentage: 20},
    1: {color: 'bg-danger', percentage: 40},
    2: {color: 'bg-danger', percentage: 60},
    3: {color: 'bg-success', percentage: 80},
    4: {color: 'bg-success', percentage: 100},
  };

  const validKeys = Object.keys(strengthLevels).map(Number);
  const safeStrength = validKeys.includes(strength) ? strength : 0;

  return strengthLevels[safeStrength as keyof typeof strengthLevels];
};

const passwordValidation = async (
  elementInput: HTMLInputElement,
  feedbackContainer: HTMLElement,
  hints: Record<string, string>,
): Promise<void> => {
  const passwordValue = elementInput.value;

  if (passwordValue === '') {
    feedbackContainer.classList.add('d-none');
    return;
  }

  try {
    const {prestashop} = window;
    const result = await prestashop.checkPasswordScore(passwordValue);
    const minScore = parseInt(elementInput.dataset.minscore || '3', 10);

    // Show feedback container
    feedbackContainer.classList.remove('d-none');

    // Calculate validation states
    const lengthValid = !elementInput.validity.tooShort && !elementInput.validity.tooLong;
    const scoreValid = minScore <= result.score;

    // Update UI components
    updateRequirementIcons(feedbackContainer, elementInput, scoreValid);
    updateProgressBar(feedbackContainer, result.score);

    // Set custom validity
    const announceValidity = feedbackContainer.querySelector<HTMLElement>(PasswordPolicyMap.announceValidity);
    const validMessage = feedbackContainer.querySelector<HTMLElement>(PasswordPolicyMap.validMessage);

    if (scoreValid && lengthValid) {
      elementInput.setCustomValidity('');
      elementInput.reportValidity();

      if (announceValidity && validMessage) {
        const message = validMessage.dataset.psData;

        if (message && message !== '') {
          announceValidity.textContent = message;
        }
      }
    } else {
      const message = buildValidationMessage(feedbackContainer, result, hints, lengthValid, scoreValid);
      elementInput.setCustomValidity(message);

      if (announceValidity) {
        announceValidity.textContent = message;
      }
    }
  } catch (error) {
    console.error('Password validation error:', error);
  }
};

// Set custom validity announce for accessibility
const debouncedAnnounce = debounce(async (...args) => {
  const element = args[0] as HTMLElement;

  if (element) element.setAttribute('aria-live', 'polite');
}, 250);

// Function to setup requirement text translations
const setupRequirementTexts = (
  feedbackContainer: HTMLElement,
  elementInput: HTMLInputElement,
  hints: Record<string, string>,
): void => {
  const passwordRequirementsLength = feedbackContainer.querySelector<HTMLElement>(
    PasswordPolicyMap.requirementLength,
  );
  const passwordRequirementsScore = feedbackContainer.querySelector<HTMLElement>(
    PasswordPolicyMap.requirementScore,
  );
  const passwordLengthMessage = feedbackContainer.querySelector<HTMLElement>(
    PasswordPolicyMap.requirementLengthMessage,
  );
  const passwordRequirementsMessage = feedbackContainer.querySelector<HTMLElement>(
    PasswordPolicyMap.requirementScoreMessage,
  );

  if (passwordLengthMessage && passwordRequirementsLength?.dataset.translation) {
    const minLength = elementInput.getAttribute('minlength') || '8';
    const maxLength = elementInput.getAttribute('maxlength') || '72';
    passwordLengthMessage.innerText = sprintf(
      passwordRequirementsLength.dataset.translation,
      minLength,
      maxLength,
    );
  }

  if (passwordRequirementsMessage && passwordRequirementsScore?.dataset.translation) {
    const minScore = elementInput.dataset.minscore || '3';
    const scoreText = hints[minScore] || 'Strong';
    passwordRequirementsMessage.innerText = sprintf(
      passwordRequirementsScore.dataset.translation,
      scoreText,
    );
  }
};

// Validates and retrieves DOM elements, throwing error if not found
const queryElement = <T extends HTMLElement>(
  selector: string,
  errorMessage: string,
  parent: Element | null = null,
): T => {
  const element = (parent?.querySelector(selector) as T) ?? document.querySelector(selector);

  if (!element) {
    throw new Error(errorMessage);
  }
  return element;
};

// Helper function to setup validation event listeners
const setupValidationListeners = (
  elementInput: HTMLInputElement,
  feedbackContainer: HTMLElement,
  hints: Record<string, string>,
) => {
  const inputHandler = () => passwordValidation(elementInput, feedbackContainer, hints);
  elementInput.addEventListener('input', inputHandler);

  const form = elementInput.closest('form');
  let formSubmitHandler: ((event: Event) => Promise<void>) | null = null;

  if (form) {
    formSubmitHandler = async () => {
      await passwordValidation(elementInput, feedbackContainer, hints);
    };
    form.addEventListener('submit', formSubmitHandler);
  }

  const announceValidity = feedbackContainer.querySelector<HTMLElement>(PasswordPolicyMap.announceValidity);

  if (announceValidity) {
    debouncedAnnounce(announceValidity);
  }

  return {inputHandler, formSubmitHandler, form};
};

const usePasswordPolicy = (selector: string): PasswordPolicyReturn => {
  const element = queryElement(
    selector,
    `The element "${selector}" for password policy is not found.`,
  );
  const elementInput = queryElement<HTMLInputElement>(
    PasswordPolicyMap.input,
    `The input element "${PasswordPolicyMap.input}" for password policy is not found.`,
    element,
  );
  const targetElement = queryElement<HTMLElement>(
    PasswordPolicyMap.feedbackTarget,
    `The target element "${PasswordPolicyMap.feedbackTarget}" for password policy is not found.`,
    element,
  );
  const feedbackTemplate = queryElement<HTMLTemplateElement>(
    PasswordPolicyMap.template,
    `The feedback template "${PasswordPolicyMap.template}" for password policy is not found.`,
  );

  // Create feedback container
  let feedbackContainer: HTMLElement | null = null;

  if (targetElement) {
    targetElement.innerHTML = feedbackTemplate!.innerHTML;
    feedbackContainer = targetElement.querySelector<HTMLElement>(PasswordPolicyMap.feedbackContainer);
  }

  const hintElement = element?.querySelector<HTMLElement>(PasswordPolicyMap.hint);
  const hints = safeParseJSON(hintElement!.innerHTML);

  // Setup requirement texts
  setupRequirementTexts(feedbackContainer!, elementInput!, hints);

  // Setup event listeners
  const {inputHandler, formSubmitHandler, form} = setupValidationListeners(elementInput!, feedbackContainer!, hints);

  // Initial validation if field has content
  if (elementInput!.value !== '') {
    passwordValidation(elementInput!, feedbackContainer!, hints);
  }

  // Return cleanup function
  const cleanup = () => {
    elementInput!.removeEventListener('input', inputHandler);
    if (form && formSubmitHandler) {
      form.removeEventListener('submit', formSubmitHandler);
    }
  };

  return {element: element || undefined, cleanup};
};

export default usePasswordPolicy;
