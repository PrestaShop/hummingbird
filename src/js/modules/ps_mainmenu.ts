const initDesktopMenu = () => {
  /**
   * Toggle button click (desktop)
   */
  const toggles = document.querySelectorAll<HTMLButtonElement>('.ps-mainmenu__toggle-dropdown');

  toggles.forEach((btn) => {
    btn.addEventListener('click', (e) => {
      e.stopPropagation();

      const submenuId = btn.getAttribute('aria-controls');

      if (!submenuId) return;
      const submenu = document.getElementById(submenuId);

      if (!submenu) return;

      const expanded = btn.getAttribute('aria-expanded') === 'true';

      // Close all other submenus before toggling this one
      toggles.forEach((otherBtn) => {
        const otherId = otherBtn.getAttribute('aria-controls');

        if (!otherId) return;
        const otherSubmenu = document.getElementById(otherId);

        if (!otherSubmenu) return;

        otherBtn.setAttribute('aria-expanded', 'false');
        otherSubmenu.setAttribute('aria-hidden', 'true');
        otherSubmenu.classList.add('d-none');

        const icon = otherBtn.querySelector<HTMLElement>('.ps-mainmenu_dropdown');

        if (icon) {
          icon.classList.remove('ps-mainmenu_dropdown-up');
          icon.classList.add('ps-mainmenu_dropdown-down');
        }
      });

      // Toggle clicked submenu
      btn.setAttribute('aria-expanded', String(!expanded));
      submenu.setAttribute('aria-hidden', String(expanded));
      submenu.classList.toggle('d-none', expanded);

      // Rotate chevron icon
      const icon = btn.querySelector<HTMLElement>('.ps-mainmenu_dropdown');

      if (icon) {
        icon.classList.toggle('ps-mainmenu_dropdown-up', !expanded);
        icon.classList.toggle('ps-mainmenu_dropdown-down', expanded);
      }
    });

    // Keyboard accessibility for toggle button
    btn.addEventListener('keydown', (e) => {
      if (e.key === 'Enter' || e.key === ' ') {
        e.preventDefault();
        btn.click();
      }
    });
  });

  /**
   * Close submenu on click outside
   */
  document.addEventListener('click', (e) => {
    const isClickInsideMenu = (e.target as HTMLElement).closest('.ps-mainmenu');

    if (!isClickInsideMenu) {
      closeAllSubmenus();
    }
  });

  /**
   * Close submenu if focus leaves menu (Tab / Shift+Tab)
   */
  document.addEventListener('focusin', (e) => {
    const isFocusInsideMenu = (e.target as HTMLElement).closest('.ps-mainmenu');

    if (!isFocusInsideMenu) {
      closeAllSubmenus();
    }
  });

  /**
   * Keyboard navigation for main menu links
   */
  const menuLinks = document.querySelectorAll<HTMLElement>('.ps-mainmenu__tree__link');
  menuLinks.forEach((link, idx) => {
    link.addEventListener('keydown', (e: KeyboardEvent) => {
      const total = menuLinks.length;

      switch (e.key) {
        case 'ArrowRight': {
          e.preventDefault();
          menuLinks[(idx + 1) % total].focus();
          break;
        }
        case 'ArrowLeft': {
          e.preventDefault();
          menuLinks[(idx - 1 + total) % total].focus();
          break;
        }
        case 'ArrowDown': {
          e.preventDefault();
          const submenu = link.parentElement?.querySelector<HTMLElement>('.js-sub-menu .submenu__left-item');

          if (submenu) submenu.focus();
          break;
        }
        case 'Escape': {
          const submenuContainer = link.parentElement?.querySelector<HTMLElement>('.js-sub-menu');

          if (submenuContainer) submenuContainer.setAttribute('aria-hidden', 'true');
          link.focus();
          break;
        }
        default:
          break;
      }
    });
  });

  /**
   * Keyboard navigation for submenu items
   */
  const submenuItems = document.querySelectorAll<HTMLElement>('.submenu__left-item');
  submenuItems.forEach((item, idx) => {
    item.addEventListener('keydown', (e) => {
      const total = submenuItems.length;

      switch (e.key) {
        case 'ArrowDown': {
          e.preventDefault();
          submenuItems[(idx + 1) % total].focus();
          break;
        }
        case 'ArrowUp': {
          e.preventDefault();
          submenuItems[(idx - 1 + total) % total].focus();
          break;
        }
        case 'Escape': {
          const parentLink = item.closest('li')?.querySelector<HTMLElement>('.ps-mainmenu__tree__link');
          const submenuContainer = item.closest<HTMLElement>('.js-sub-menu');

          if (parentLink && submenuContainer) {
            submenuContainer.setAttribute('aria-hidden', 'true');
            parentLink.focus();
          }
          break;
        }
        default:
          break;
      }
    });
  });

  /**
   * Helper: close all submenus
   */
  function closeAllSubmenus() {
    toggles.forEach((btn) => {
      const submenuId = btn.getAttribute('aria-controls');

      if (!submenuId) return;
      const submenu = document.getElementById(submenuId);

      if (!submenu) return;

      btn.setAttribute('aria-expanded', 'false');
      submenu.setAttribute('aria-hidden', 'true');
      submenu.classList.add('d-none');

      const icon = btn.querySelector<HTMLElement>('.ps-mainmenu_dropdown');

      if (icon) {
        icon.classList.remove('ps-mainmenu_dropdown-up');
        icon.classList.add('ps-mainmenu_dropdown-down');
      }
    });
  }
};

export default initDesktopMenu;
