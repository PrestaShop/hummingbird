/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

const initFormValidation = (selector?: string) => {
  const {Theme} = window;
  const {formValidation: formValidationMap} = Theme.selectors;
  const formValidationList = document.querySelectorAll<HTMLFormElement>(selector ?? formValidationMap.default);

  formValidationList.forEach((formElement: HTMLFormElement) => {
    formElement.addEventListener('submit', (event) => {
      if (!formElement.checkValidity()) {
        event.preventDefault();
        event.stopPropagation();
      }

      formElement.classList.add('was-validated');
    }, false);
  });
};

export default initFormValidation;
