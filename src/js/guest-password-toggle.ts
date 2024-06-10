/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

const initGuestPasswordToggle = () => {
  const {Theme} = window;
  const {guestPasswordToggle: GuestPasswordToggleMap} = Theme.selectors;
  const guestCheckbox = document.querySelector(GuestPasswordToggleMap.checkbox);
  const guestPasswordWrapper = document.querySelector(GuestPasswordToggleMap.passwordWrapper);

  if (guestCheckbox && guestPasswordWrapper) {
    guestCheckbox.addEventListener('change', () => {
      const passwordInput = guestPasswordWrapper.querySelector('input[type="password"]');

      if (guestCheckbox.checked) {
        guestPasswordWrapper.classList.remove('d-none');
      } else {
        guestPasswordWrapper.classList.add('d-none');

        if (passwordInput) {
          const feedbackContainer = document.querySelector(Theme.selectors.passwordPolicy.container);

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
