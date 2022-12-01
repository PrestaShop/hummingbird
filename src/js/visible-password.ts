/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

const initVisiblePassword = () => {
  const {Theme} = window;
  const {visiblePassword: visiblePasswordMap} = Theme.selectors;
  const visiblePasswordList = document.querySelectorAll(visiblePasswordMap.visiblePassword);

  visiblePasswordList.forEach((input: HTMLInputElement) => {
    const button = input?.nextElementSibling;

    button?.addEventListener('click', () => {
      const newType = input.getAttribute('type') === 'text' ? 'password' : 'text';
      input.setAttribute('type', newType);

      const icon = button.firstElementChild;

      if (icon) {
        icon.innerHTML = newType === 'text' ? 'visibility_off' : 'visibility';
      }
    });
  });
};

export default initVisiblePassword;
