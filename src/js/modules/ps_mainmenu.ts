const initDesktopMenu = () => {
  const headerBottom = document.querySelector<HTMLElement>('.header-bottom');
  const toggles = document.querySelectorAll<HTMLButtonElement>('.ps-mainmenu__toggle-dropdown');
  const menuItemsFirstLevel = document.querySelectorAll<HTMLElement>('.ps-mainmenu__tree__item');
  const navLinksBtn = document.querySelectorAll<HTMLElement>('.nav-link');

  toggles.forEach((btn) => {
    btn.addEventListener('click', (e) => {
      e.stopPropagation();

      const submenuId = btn.getAttribute('aria-controls');

      if (!submenuId) return;

      const submenuDiv = document.getElementById(submenuId);

      if (!submenuDiv) return;

      const expanded = btn.getAttribute('aria-expanded') === 'true';
      const newExpanded = !expanded;

      // Synchronize linked menu item (anchor) if aria-labelledby is defined
      const linkedMenuItemId = btn.getAttribute('aria-labelledby');
      const linkedMenuItem = linkedMenuItemId ? document.getElementById(linkedMenuItemId) : null;

      if (linkedMenuItem) {
        linkedMenuItem.setAttribute('aria-expanded', String(newExpanded));
      }

      // Close sibling submenus at the same hierarchy level
      const parentLi = btn.closest('li');
      const siblingToggles = parentLi?.parentElement?.querySelectorAll<HTMLButtonElement>(
        '.ps-mainmenu__toggle-dropdown',
      );

      siblingToggles?.forEach((otherBtn) => {
        if (otherBtn === btn) return;

        const otherId = otherBtn.getAttribute('aria-controls');
        const otherDiv = otherId ? document.getElementById(otherId) : null;

        if (!otherDiv) return;

        otherDiv.classList.add('d-none');
        otherDiv.setAttribute('aria-hidden', 'true');
        otherBtn.setAttribute('aria-expanded', 'false');

        const otherLinkedItemId = otherBtn.getAttribute('aria-labelledby');
        const otherLinkedItem = otherLinkedItemId ? document.getElementById(otherLinkedItemId) : null;

        if (otherLinkedItem) {
          otherLinkedItem.setAttribute('aria-expanded', 'false');
        }

        const icon = otherBtn.querySelector<HTMLElement>('.ps-mainmenu_dropdown');

        if (icon) {
          icon.classList.remove('ps-mainmenu_dropdown-up');
          icon.classList.add('ps-mainmenu_dropdown-down');
        }
      });

      // Toggle visibility for submenu container
      submenuDiv.classList.toggle('d-none', expanded);
      submenuDiv.setAttribute('aria-hidden', String(expanded));

      // Toggle visibility for inner <ul> if present
      const submenuUL = submenuDiv.querySelector<HTMLUListElement>('.submenu__level');

      if (submenuUL) {
        submenuUL.classList.toggle('d-none', expanded);
        submenuUL.setAttribute('aria-hidden', String(expanded));
      }

      btn.setAttribute('aria-expanded', String(newExpanded));

      // Toggle chevron icon direction
      const icon = btn.querySelector<HTMLElement>('.ps-mainmenu_dropdown');

      if (icon) {
        icon.classList.toggle('ps-mainmenu_dropdown-up', newExpanded);
        icon.classList.toggle('ps-mainmenu_dropdown-down', !newExpanded);
      }
    });

    // Keyboard accessibility: Enter or Space triggers the toggle
    btn.addEventListener('keydown', (e) => {
      if (e.key === 'Enter' || e.key === ' ') {
        e.preventDefault();
        btn.click();
      }
    });
  });

  menuItemsFirstLevel.forEach((menuItem) => {
    const menuItemBtn = menuItem.querySelector<HTMLButtonElement>('.ps-mainmenu__toggle-dropdown');

    menuItem.addEventListener('mouseenter', (e: Event) => {
      e.stopPropagation();

      if (!menuItemBtn) return;

      const submenuId = menuItemBtn.getAttribute('aria-controls');

      if (!submenuId) return;

      const submenuDiv = document.getElementById(submenuId);

      if (!submenuDiv) return;

      // const expanded = menuItemBtn.getAttribute('aria-expanded') === 'true';
      const newExpanded = true;

      // Synchronize linked menu item (anchor) if aria-labelledby is defined
      const linkedMenuItemId = menuItemBtn.getAttribute('aria-labelledby');
      const linkedMenuItem = linkedMenuItemId ? document.getElementById(linkedMenuItemId) : null;

      if (linkedMenuItem) {
        linkedMenuItem.setAttribute('aria-expanded', String(newExpanded));
      }

      // Close sibling submenus at the same hierarchy level
      const siblingToggles = menuItem.parentElement?.querySelectorAll<HTMLButtonElement>(
        '.ps-mainmenu__toggle-dropdown',
      );

      siblingToggles?.forEach((otherBtn) => {
        if (otherBtn === menuItemBtn) return;

        const otherId = otherBtn.getAttribute('aria-controls');
        const otherDiv = otherId ? document.getElementById(otherId) : null;

        if (!otherDiv) return;

        otherDiv.classList.add('d-none');
        otherDiv.setAttribute('aria-hidden', 'true');
        otherBtn.setAttribute('aria-expanded', 'false');

        const otherLinkedItemId = otherBtn.getAttribute('aria-labelledby');
        const otherLinkedItem = otherLinkedItemId ? document.getElementById(otherLinkedItemId) : null;

        if (otherLinkedItem) {
          otherLinkedItem.setAttribute('aria-expanded', 'false');
        }

        const icon = otherBtn.querySelector<HTMLElement>('.ps-mainmenu_dropdown');

        if (icon) {
          icon.classList.remove('ps-mainmenu_dropdown-up');
          icon.classList.add('ps-mainmenu_dropdown-down');
        }
      });

      // Toggle visibility for submenu container
      submenuDiv.classList.remove('d-none');
      submenuDiv.setAttribute('aria-hidden', String(!newExpanded));

      // Toggle visibility for inner <ul> if present
      const submenuUL = submenuDiv.querySelector<HTMLUListElement>('.submenu__level');

      if (submenuUL) {
        submenuUL.classList.remove('d-none');
        submenuUL.setAttribute('aria-hidden', String(!newExpanded));
      }

      menuItemBtn.setAttribute('aria-expanded', String(newExpanded));

      // Toggle chevron icon direction
      const icon = menuItemBtn.querySelector<HTMLElement>('.ps-mainmenu_dropdown');

      if (icon) {
        icon.classList.add('ps-mainmenu_dropdown-up');
        icon.classList.remove('ps-mainmenu_dropdown-down');
      }
    });

    // Keyboard accessibility: Enter or Space triggers the toggle
    menuItemBtn?.addEventListener('keydown', (e) => {
      if (e.key === 'Enter' || e.key === ' ') {
        e.preventDefault();
        menuItemBtn.click();
      }
    });
  });

  navLinksBtn.forEach((btn) => {
    btn.addEventListener('mouseover', () => {
      btn.click();
    });
  });

  /**
   * Closes all open submenus and resets ARIA attributes
   */
  const closeAllSubmenus = () => {
    toggles.forEach((btn) => {
      const submenuId = btn.getAttribute('aria-controls');

      if (!submenuId) return;

      const submenuDiv = document.getElementById(submenuId);

      if (!submenuDiv) return;

      submenuDiv.classList.add('d-none');
      submenuDiv.setAttribute('aria-hidden', 'true');
      btn.setAttribute('aria-expanded', 'false');

      const linkedMenuItemId = btn.getAttribute('aria-labelledby');
      const linkedMenuItem = linkedMenuItemId ? document.getElementById(linkedMenuItemId) : null;

      if (linkedMenuItem) {
        linkedMenuItem.setAttribute('aria-expanded', 'false');
      }

      const icon = btn.querySelector<HTMLElement>('.ps-mainmenu_dropdown');

      if (icon) {
        icon.classList.remove('ps-mainmenu_dropdown-up');
        icon.classList.add('ps-mainmenu_dropdown-down');
      }
    });
  };

  /**
   * Closes all submenus when clicking or focusing outside the main menu
   */
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

  // Keyboard navigation
  const focusableItems = document.querySelectorAll<HTMLElement>('.ps-mainmenu__tree__link, .submenu__link, ps-mainmenu__toggle-dropdown');

  focusableItems.forEach((item, idx) => {
    item.addEventListener('keydown', (e) => {
      const total = focusableItems.length;

      switch (e.key) {
        case 'ArrowRight':
          e.preventDefault();
          focusableItems[(idx + 1) % total].focus();
          break;

        case 'ArrowLeft':
          e.preventDefault();
          focusableItems[(idx - 1 + total) % total].focus();
          break;

        case 'ArrowDown': {
          e.preventDefault();
          const submenu = item.closest('li')?.querySelector<HTMLElement>('.submenu__level li .submenu__link');

          if (submenu) submenu.focus();
          break;
        }

        case 'ArrowUp': {
          e.preventDefault();
          const prev = item.closest('li')?.previousElementSibling?.querySelector<HTMLElement>('.submenu__link');

          if (prev) prev.focus();
          break;
        }

        case 'Escape': {
          // Close current submenu and return focus to parent toggle
          const parentSubmenu = item.closest<HTMLElement>('.submenu__level');
          const parentToggle = parentSubmenu?.closest('li')?.querySelector<HTMLButtonElement>(
            '.ps-mainmenu__toggle-dropdown',
          );

          if (parentToggle && parentSubmenu) {
            parentSubmenu.setAttribute('aria-hidden', 'true');
            parentSubmenu.classList.add('d-none');
            parentToggle.setAttribute('aria-expanded', 'false');

            const icon = parentToggle.querySelector<HTMLElement>('.ps-mainmenu_dropdown');

            if (icon) {
              icon.classList.remove('ps-mainmenu_dropdown-up');
              icon.classList.add('ps-mainmenu_dropdown-down');
            }

            parentToggle.focus();
          }
          break;
        }

        default:
          break;
      }
    });
  });
};

export default initDesktopMenu;
