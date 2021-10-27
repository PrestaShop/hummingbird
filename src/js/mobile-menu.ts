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

const initMobileMenu = () => {
  const openChildsButtons = document.querySelectorAll('.js-menu-open-child');
  const menuTitle = <Element>document.querySelector('.js-menu-title');
  const backButton = <Element>document.querySelector('.js-back-button');
  const defaultTitle = menuTitle.innerHTML;

  openChildsButtons.forEach((button: Element): void => {
    button.addEventListener('click', () => {
      const currentMenu = document.querySelector('.js-menu-current');

      if (currentMenu) {
        currentMenu.classList.remove('js-menu-current');
        currentMenu.classList.remove('menu--current');
        currentMenu.classList.add('menu--parent');
      }

      const child = button.nextElementSibling;

      menuTitle.innerHTML = <string>button.previousElementSibling?.innerHTML;
      backButton.classList.remove('d-none');

      if (child) {
        child.classList.add('js-menu-current');
        child.classList.add('menu--current');
        child.classList.remove('menu--child');
        child.classList.remove('js-menu-child');
      }
    });
  });

  backButton.addEventListener('click', () => {
    const currentMenu = <HTMLElement>document.querySelector('.menu--current');
    const currentDepth = Number(currentMenu.dataset.depth);
    const currentParent = document.querySelector(`.menu--parent[data-depth="${currentDepth - 1}"]`)

    if (currentDepth === 1) {
      menuTitle.innerHTML = defaultTitle;
      backButton.classList.add('d-none');
    }

    if (currentMenu) {
      currentMenu.classList.remove('js-menu-current');
      currentMenu.classList.remove('menu--current');
    }

    if (currentParent) {
      currentParent.classList.add('js-menu-current');
      currentParent.classList.add('menu--current');
      currentParent.classList.remove('menu--parent');
    }
  })
};

document.addEventListener('DOMContentLoaded', () => {
  initMobileMenu();

  prestashop.on('responsive update', () => {
    initMobileMenu();
  });
});

export default initMobileMenu;
