/**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 */

const initVisiblePassword = () => {
  const {prestashop} = window;
  const {visiblePassword: visiblePasswordMap} = prestashop.themeSelectors;
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
