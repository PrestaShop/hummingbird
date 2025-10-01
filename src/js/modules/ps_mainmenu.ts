const initDesktopMenu = () => {
  /**
   * Toggle button click (desktop) for all levels
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

      // Close other sibling submenus at the same level
      const parentLi = btn.closest('li');
      const siblingToggles = parentLi?.parentElement?.querySelectorAll<HTMLButtonElement>(
        '.ps-mainmenu__toggle-dropdown'
      );
      siblingToggles?.forEach((otherBtn) => {
        if (otherBtn === btn) return;
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
    if (!isClickInsideMenu) closeAllSubmenus();
  });

  /**
   * Close submenu if focus leaves menu (Tab / Shift+Tab)
   */
  document.addEventListener('focusin', (e) => {
    const isFocusInsideMenu = (e.target as HTMLElement).closest('.ps-mainmenu');
    if (!isFocusInsideMenu) closeAllSubmenus();
  });

  /**
   * Keyboard navigation for main menu and submenus
   */
  const focusableItems = document.querySelectorAll<HTMLElement>(
    '.ps-mainmenu__tree__link, .submenu__link'
  );
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
          // Focus first child submenu if exists
          const submenu = item.closest('li')?.querySelector<HTMLElement>('.submenu__level li .submenu__link');
          if (submenu) submenu.focus();
          break;
        }
        case 'ArrowUp': {
          e.preventDefault();
          // Focus previous sibling in submenu if exists
          const prev = item.closest('li')?.previousElementSibling?.querySelector<HTMLElement>('.submenu__link');
          if (prev) prev.focus();
          break;
        }
        case 'Escape': {
          // Close parent submenu if open
          const parentSubmenu = item.closest<HTMLElement>('.submenu__level');
          const parentToggle = parentSubmenu?.closest('li')?.querySelector<HTMLButtonElement>('.ps-mainmenu__toggle-dropdown');
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
