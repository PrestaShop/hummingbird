/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

const initVisiblePassword = () => {
  const {Theme} = window;
  const {visiblePassword: visiblePasswordMap} = Theme.selectors;
  const visiblePasswordList = document.querySelectorAll(visiblePasswordMap.visiblePassword);

  visiblePasswordList.forEach((visiblePasswordInput: HTMLInputElement) => {
    const visiblePasswordBtn = visiblePasswordInput?.nextElementSibling;

    visiblePasswordBtn?.addEventListener('click', () => {
      const newType = visiblePasswordInput.getAttribute('type') === 'text' ? 'password' : 'text';
      visiblePasswordInput.setAttribute('type', newType);

      const visiblePasswordIcon = visiblePasswordBtn.firstElementChild;
      if (visiblePasswordIcon) {
        visiblePasswordIcon.innerHTML = newType === 'text' ? 'visibility_off' : 'visibility';
      }
    });
  });
};

export default initVisiblePassword;
