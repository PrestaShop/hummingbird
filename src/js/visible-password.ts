/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

const initVisiblePassword = () => {
  const {Theme} = window;
  const {visiblePassword: visiblePasswordMap} = Theme.selectors;
  const visiblePasswordList = document.querySelectorAll(visiblePasswordMap.visiblePassword);

  visiblePasswordList.forEach((input: HTMLInputElement) => {
    const button = input?.nextElementSibling as HTMLElement;

    button?.addEventListener('click', () => {
      const newType = input.getAttribute('type') === 'text' ? 'password' : 'text';
      input.setAttribute('type', newType);
      button.setAttribute('aria-expanded', newType === 'text' ? 'true' : 'false');

      const icon = button.firstElementChild;

      if (icon) {
        icon.innerHTML = newType === 'text' ? 'visibility_off' : 'visibility';

        const {textHide, textShow} = button.dataset;

        if (textShow && textHide) {
          button.setAttribute('aria-label', newType === 'text' ? textHide : textShow);
        }
      }
    });
  });
};

export default initVisiblePassword;
