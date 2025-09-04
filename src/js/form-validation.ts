/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

const initFormValidation = (selector?: string) => {
  const {Theme} = window;
  const {formValidation: formValidationMap} = Theme.selectors;
  const formValidationList = document.querySelectorAll<HTMLFormElement>(selector ?? formValidationMap.default);

  formValidationList.forEach((formElement: HTMLFormElement) => {
    const submitButton = formElement.querySelector<HTMLButtonElement>(formValidationMap.submitButton);

    if (submitButton) {
      submitButton.addEventListener('click', (event) => {
        formElement.classList.add('was-validated');

        if (!formElement.checkValidity()) {
          event.preventDefault();
          formElement.reportValidity();
        }
      });
    }
  });
};

export default initFormValidation;
