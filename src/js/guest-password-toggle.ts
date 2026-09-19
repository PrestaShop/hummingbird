/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */

const initGuestPasswordToggle = () => {
  const {Theme} = window;
  const {guestPasswordToggle: GuestPasswordToggleMap, passwordPolicy: PasswordPolicyMap} = Theme.selectors;
  const guestCheckbox = document.querySelector(GuestPasswordToggleMap.checkbox);
  const guestPasswordWrapper = document.querySelector(GuestPasswordToggleMap.passwordWrapper);

  if (guestCheckbox && guestPasswordWrapper) {
    guestCheckbox.addEventListener('change', () => {
      const passwordInput = guestPasswordWrapper.querySelector<HTMLInputElement>(PasswordPolicyMap.input);

      if (guestCheckbox.checked) {
        guestPasswordWrapper.classList.remove('d-none');
      } else {
        guestPasswordWrapper.classList.add('d-none');

        if (passwordInput) {
          const feedbackContainer = guestPasswordWrapper.querySelector(PasswordPolicyMap.feedbackContainer);

          passwordInput.value = '';
          passwordInput.classList.remove('border-success', 'border-danger', 'border');

          if (feedbackContainer) {
            feedbackContainer.classList.add('d-none');
          }
        }
      }
    });
  }
};

export default initGuestPasswordToggle;
