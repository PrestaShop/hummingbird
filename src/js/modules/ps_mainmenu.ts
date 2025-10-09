/**
 * Accessible desktop mega menu behavior
 *
 * Keyboard interactions:
 * - Tab / Shift+Tab: native focus navigation
 * - Enter / Space (on toggle button): open/close submenu
 * - Enter / Space (on link): keep native link navigation
 * - ArrowDown: open submenu and focus first link
 * - ArrowUp: close submenu
 * - ArrowLeft / ArrowRight: move between top-level menu items
 * - Escape: close submenu and return focus to toggle
 */

const initDesktopMenu = () => {
  const headerBottom = document.querySelector<HTMLElement>('.header-bottom');

  const toggles = Array.from(document.querySelectorAll<HTMLButtonElement>('.ps-mainmenu__toggle-dropdown'));
  const menuItemsFirstLevel = Array.from(document.querySelectorAll<HTMLElement>('.ps-mainmenu__tree__item'));
  const navLinksBtn = Array.from(document.querySelectorAll<HTMLElement>('.nav-link'));

  const isActivationKey = (e: KeyboardEvent) => e.key === 'Enter' || e.key === ' ' || e.key === 'Spacebar' || e.code === 'Space';

  /**
   * Helper to set submenu expanded/collapsed state
   */
  const setSubmenuState = (submenuDiv: HTMLElement, btn: HTMLButtonElement, newExpanded: boolean) => {
    if (newExpanded) {
      submenuDiv.classList.remove('d-none');
      submenuDiv.setAttribute('aria-hidden', 'false');
    } else {
      submenuDiv.classList.add('d-none');
      submenuDiv.setAttribute('aria-hidden', 'true');
    }

    btn.setAttribute('aria-expanded', String(newExpanded));

    // Synchronize aria-expanded with the labeled link if any
    const labelledBy = submenuDiv.getAttribute('aria-labelledby');

    if (labelledBy) {
      const linkedMenuItem = document.getElementById(labelledBy);

      if (linkedMenuItem) linkedMenuItem.setAttribute('aria-expanded', String(newExpanded));
    }

    // Update arrow icon direction (up/down)
    const icon = btn.querySelector<HTMLElement>('.ps-mainmenu_dropdown');

    if (icon) {
      icon.classList.toggle('ps-mainmenu_dropdown-up', newExpanded);
      icon.classList.toggle('ps-mainmenu_dropdown-down', !newExpanded);
    }
  };

  /**
   * Utility: close all open submenus
   */
  const closeAllSubmenus = () => {
    toggles.forEach((btn) => {
      const submenuId = btn.getAttribute('aria-controls');
      const submenuDiv = submenuId ? document.getElementById(submenuId) : null;

      if (submenuDiv) setSubmenuState(submenuDiv, btn, false);
    });
  };

  /**
   * Move focus horizontally (left/right) among top-level items,
   * including both links and toggle buttons
   */
  const moveHorizontalFocus = (current: HTMLElement, direction: 'left' | 'right') => {
    const focusableElements: HTMLElement[] = [];
    menuItemsFirstLevel.forEach((item) => {
      const link = item.querySelector<HTMLElement>('.ps-mainmenu__tree__link');
      const toggle = item.querySelector<HTMLButtonElement>('.ps-mainmenu__toggle-dropdown');

      if (link) focusableElements.push(link);
      if (toggle) focusableElements.push(toggle);
    });

    const index = focusableElements.indexOf(current);

    if (index === -1) return;

    const dir = direction === 'right' ? 1 : -1;
    const next = focusableElements[(index + dir + focusableElements.length) % focusableElements.length];
    next.focus();
  };

  /**
   * Handle toggle button interactions
   */
  toggles.forEach((btn) => {
    btn.addEventListener('click', (e) => {
      e.stopPropagation();

      const submenuId = btn.getAttribute('aria-controls');

      if (!submenuId) return;

      const submenuDiv = document.getElementById(submenuId);

      if (!submenuDiv) return;

      const expanded = btn.getAttribute('aria-expanded') === 'true';
      const newExpanded = !expanded;

      const parentLi = btn.closest('li');
      const siblingToggles = parentLi?.parentElement?.querySelectorAll<HTMLButtonElement>(
        '.ps-mainmenu__toggle-dropdown',
      );

      siblingToggles?.forEach((otherBtn) => {
        if (otherBtn === btn) return;
        const otherId = otherBtn.getAttribute('aria-controls');
        const otherDiv = otherId ? document.getElementById(otherId) : null;

        if (otherDiv) setSubmenuState(otherDiv, otherBtn, false);
      });

      setSubmenuState(submenuDiv, btn, newExpanded);
    });

    btn.addEventListener('keydown', (e) => {
      const submenuId = btn.getAttribute('aria-controls');
      const submenuDiv = submenuId ? document.getElementById(submenuId) : null;
      const isExpanded = btn.getAttribute('aria-expanded') === 'true';

      // Enter / Space / ArrowDown = open submenu and focus first item
      if (e.key === 'ArrowDown' || isActivationKey(e)) {
        if (submenuDiv) {
          e.preventDefault();

          if (!isExpanded) {
            btn.click();

            const first = submenuDiv.querySelector<HTMLElement>('.submenu__link, .nav-link, a, button');
            first?.focus();
          } else if (e.key !== 'ArrowDown') {
            btn.click();
            btn.focus();
          }
        }
      } else if (e.key === 'ArrowUp' && isExpanded) { // ✅ FIXED brace-style
        e.preventDefault();
        btn.click();
        btn.focus();
      } else if (e.key === 'ArrowRight') { // ✅ FIXED brace-style
        e.preventDefault();
        moveHorizontalFocus(btn, 'right');
      } else if (e.key === 'ArrowLeft') { // ✅ FIXED brace-style
        e.preventDefault();
        moveHorizontalFocus(btn, 'left');
      } else if (e.key === 'Escape' && submenuDiv) { // ✅ FIXED brace-style
        e.preventDefault();
        setSubmenuState(submenuDiv, btn, false);
        btn.focus();
      }
    });
  });

  /**
   * Close submenu on Escape from any submenu link/button
   */
  const submenuLinks = Array.from(
    document.querySelectorAll<HTMLElement>('.submenu__link, .nav-link, .ps-mainmenu__tree__item button'),
  );

  submenuLinks.forEach((el) => {
    el.addEventListener('keydown', (e) => {
      if (e.key === 'Escape') {
        const submenuDiv = el.closest<HTMLElement>('.submenu');

        if (!submenuDiv) return;

        const labelledBy = submenuDiv.getAttribute('aria-labelledby');
        const toggleBtn = labelledBy ? (document.getElementById(labelledBy) as HTMLButtonElement) : null;

        if (toggleBtn) {
          setSubmenuState(submenuDiv, toggleBtn, false);
          toggleBtn.focus();
        }
        e.stopPropagation();
        e.preventDefault();
      }
    });
  });

  /**
   * Enable Left/Right navigation
   */
  menuItemsFirstLevel.forEach((menuItem) => {
    const link = menuItem.querySelector<HTMLElement>('.ps-mainmenu__tree__link');
    const toggle = menuItem.querySelector<HTMLButtonElement>('.ps-mainmenu__toggle-dropdown');

    if (!link) return;

    link.addEventListener('keydown', (e) => {
      if (e.key === 'ArrowRight') {
        e.preventDefault();
        if (toggle) toggle.focus();
        else moveHorizontalFocus(link, 'right');
      } else if (e.key === 'ArrowLeft') {
        e.preventDefault();
        moveHorizontalFocus(link, 'left');
      }
    });
  });

  /**
   * Hover behavior on first-level items (desktop)
   */
  menuItemsFirstLevel.forEach((menuItem) => {
    const toggle = menuItem.querySelector<HTMLButtonElement>('.ps-mainmenu__toggle-dropdown');

    if (!toggle) return;

    menuItem.addEventListener('mouseenter', (evt) => {
      evt.stopPropagation();

      const submenuId = toggle.getAttribute('aria-controls');
      const submenuDiv = submenuId ? document.getElementById(submenuId) : null;

      if (!submenuDiv) return;

      const siblingToggles = menuItem.parentElement?.querySelectorAll<HTMLButtonElement>(
        '.ps-mainmenu__toggle-dropdown',
      );
      siblingToggles?.forEach((otherBtn) => {
        if (otherBtn === toggle) return;
        const otherId = otherBtn.getAttribute('aria-controls');
        const otherDiv = otherId ? document.getElementById(otherId) : null;

        if (otherDiv) setSubmenuState(otherDiv, otherBtn, false);
      });

      setSubmenuState(submenuDiv, toggle, true);
    });
  });

  navLinksBtn.forEach((btn) => {
    btn.addEventListener('mouseover', () => {
      (btn as HTMLElement).click();
    });
  });

  document.addEventListener('click', (e) => {
    if (!(e.target as HTMLElement).closest('.ps-mainmenu')) {
      closeAllSubmenus();
    }
  });

  document.addEventListener('focusin', (e) => {
    if (!(e.target as HTMLElement).closest('.ps-mainmenu')) {
      closeAllSubmenus();
    }
  });

  headerBottom?.addEventListener('mouseleave', () => {
    closeAllSubmenus();
  });
};

export default initDesktopMenu;
