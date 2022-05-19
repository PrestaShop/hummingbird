/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

const initVisiblePassword = () => {
  const {Theme} = window;
  const {visiblePassword: visiblePasswordMap} = Theme.selectors;
  const visiblePasswordList = document.querySelectorAll(visiblePasswordMap.visiblePassword) as NodeListOf<HTMLElement>;

  if (visiblePasswordList.length > 0) {
    visiblePasswordList.forEach((visiblePasswordInput: HTMLInputElement) => {
      const visiblePasswordBtn = visiblePasswordInput?.nextElementSibling;
      visiblePasswordBtn?.addEventListener('click', () => {
        const visiblePasswordIcon = visiblePasswordBtn.firstElementChild;
        let type = visiblePasswordInput.getAttribute('type');
        let typeIcon = 'visibility';

        if (type === 'password') {
          type = 'text';
          typeIcon = 'visibility_off';
        } else {
          type = 'password';
        }

        visiblePasswordInput.setAttribute('type', type);

        if (visiblePasswordIcon) {
          visiblePasswordIcon.innerHTML = typeIcon;
        }
      });
    });
  }
};

export default initVisiblePassword;
