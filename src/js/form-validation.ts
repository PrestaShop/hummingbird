/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */

const initFormValidation = (selector?: string) => {
  const {Theme} = window;
  const {formValidation: formValidationMap} = Theme.selectors;
  const formValidationList = document.querySelectorAll<HTMLFormElement>(selector ?? formValidationMap.default);

  formValidationList.forEach((formElement: HTMLFormElement) => {
    // WHY: a control can belong to a form through the `form` attribute rather than DOM
    // containment, and querySelector only ever sees descendants. form.elements covers both,
    // which the checkout address step relies on to keep its submit button out of the
    // address <form> elements rendered inside the same step.
    const submitButton = Array.from(formElement.elements)
      .find((element): element is HTMLButtonElement => element.matches(formValidationMap.submitButton)) ?? null;

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
