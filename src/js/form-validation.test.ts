/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */
import selectorsMap from '@constants/selectors-map';
import initFormValidation from './form-validation';

const setUp = (markup: string) => {
  document.body.innerHTML = markup;

  window.Theme = {
    ...window.Theme,
    selectors: selectorsMap,
  };

  initFormValidation();
};

describe('Form validation', () => {
  it('binds the submit button nested inside the form', () => {
    setUp(`
      <form id="f" data-ps-action="form-validation">
        <input name="a" required>
        <button type="submit" data-ps-action="form-validation-submit">Send</button>
      </form>
    `);

    const form = document.querySelector('#f') as HTMLFormElement;
    const button = document.querySelector('button') as HTMLButtonElement;
    button.click();

    expect(form.classList.contains('was-validated')).toBe(true);
  });

  it('binds a submit button attached through the form attribute', () => {
    // WHY: the checkout address step keeps its submit button outside the form element, because
    // the step also renders address <form> elements that must not be nested inside it.
    setUp(`
      <form id="f" data-ps-action="form-validation"></form>
      <input name="a" form="f" required>
      <button type="submit" form="f" data-ps-action="form-validation-submit">Send</button>
    `);

    const form = document.querySelector('#f') as HTMLFormElement;
    const button = document.querySelector('button') as HTMLButtonElement;
    button.click();

    expect(form.classList.contains('was-validated')).toBe(true);
  });

  it('does not throw when the form has no submit button', () => {
    expect(() => setUp('<form id="f" data-ps-action="form-validation"></form>')).not.toThrow();
  });
});
