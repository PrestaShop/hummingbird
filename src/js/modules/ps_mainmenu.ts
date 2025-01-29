/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import {Dropdown} from 'bootstrap';

const ESCAPE_KEY = 'Escape';
const ARROW_UP_KEY = 'ArrowUp';
const ARROW_DOWN_KEY = 'ArrowDown';
const ARROW_LEFT_KEY = 'ArrowLeft';
const ARROW_RIGHT_KEY = 'ArrowRight';

const initDesktopMenu = () => {
  const {Theme} = window;
  const {desktopMenu: desktopMenuMap} = Theme.selectors;

  /**
   * Handle submenu position
   */
  const menuItemsLvl0 = document.querySelectorAll(desktopMenuMap.menuItemsLvl0);

  if (menuItemsLvl0) {
    menuItemsLvl0.forEach((element: HTMLElement) => {
      element.addEventListener('mouseenter', () => {
        const subMenuTopPosition = element.offsetHeight + element.offsetTop;
        const subMenu = element.querySelector(desktopMenuMap.subMenu) as HTMLElement;
        subMenu.style.top = `${subMenuTopPosition}px`;
      });
    });
  }

  /**
   * Handle Mouse and Keyboard events for Submenus.
   * Find all dropdown toggles with [data-depth: ^2]
   */
  const dropdownToggles = document.querySelectorAll(desktopMenuMap.dropdownToggles);
  dropdownToggles.forEach((dropdownToggleElement: HTMLElement) => {
    const dropdown = new Dropdown(dropdownToggleElement, {
      popperConfig: () => ({placement: 'auto-end'}),
    });

    /* Control Submenu display for Mouse events inside the menu container */
    const dropdownElement = dropdownToggleElement.parentElement;
    dropdownElement?.addEventListener('mouseover', () => {
      dropdown.show();
      // Revert auto-focus by BS on dropdown toggle to controll Keyboard events for Submenu
      dropdownToggleElement.blur();
    });
    dropdownElement?.addEventListener('mouseout', () => {
      dropdown.hide();
    });

    /* Control Submenu display for Keyboard events inside the menu container */
    dropdownToggleElement.addEventListener('keydown', (event: KeyboardEvent) => {
      // Open the submenu when Arrow Right or Arrow Left key is selected
      if (event.key === ARROW_LEFT_KEY || event.key === ARROW_RIGHT_KEY) {
        dropdown.show();
      }

      // Hide the submenu when Escape key is pressed
      if (event.key === ESCAPE_KEY) {
        dropdown.hide();
      }
    });
  });

  /**
   * Handle Keyboard events for main menu links
   * Find all links with [data-depth: 0]
   */
  const mainMenuLinks = document.querySelectorAll(desktopMenuMap.dropdownItemAnchor(0));
  mainMenuLinks.forEach((mainMenuLinkElement: HTMLElement) => {
    const menuContainerElement = mainMenuLinkElement.nextElementSibling;

    /* Open the menu container when Arrow Up or Arrow Down key is pressed */
    mainMenuLinkElement.addEventListener('keydown', (event: KeyboardEvent) => {
      if (event.key === ARROW_UP_KEY || event.key === ARROW_DOWN_KEY) {
        // Need to add a temporary selector to be able to focus on first or last link
        menuContainerElement?.classList.add('focusing');

        // Focus on first link with Arrow Down or last link with Arrow Up inside the menu container
        const menuContainerLinks = menuContainerElement?.querySelectorAll<HTMLElement>(
          desktopMenuMap.dropdownItemAnchor(1),
        );

        if (menuContainerLinks && menuContainerLinks.length) {
          const targetIndex = (event.key === ARROW_DOWN_KEY) ? 0 : menuContainerLinks.length - 1;
          menuContainerLinks.item(targetIndex).focus();
        }

        // Now the menu container display will be control by :focus-within CSS pseudo-class
        menuContainerElement?.classList.remove('focusing');
        event.stopPropagation();
        event.preventDefault();
      }
    });

    /* Hide the menu container and focus to the parent element when Escape key is pressed */
    menuContainerElement?.addEventListener('keydown', (event: KeyboardEvent) => {
      if (event.key === ESCAPE_KEY) {
        mainMenuLinkElement.focus();
      }
    });
  });
};

export default initDesktopMenu;
