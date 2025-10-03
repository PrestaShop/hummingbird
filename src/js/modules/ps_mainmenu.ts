const initDesktopMenu = () => {
  const toggles = document.querySelectorAll<HTMLButtonElement>('.ps-mainmenu__toggle-dropdown');

  toggles.forEach((btn) => {
    btn.addEventListener('click', (e) => {
      e.stopPropagation();

      const submenuId = btn.getAttribute('aria-controls');

      if (!submenuId) return;
      const submenuDiv = document.getElementById(submenuId);

      if (!submenuDiv) return;

      const submenuUL = submenuDiv.querySelector<HTMLUListElement>('.submenu__level');

      const expanded = btn.getAttribute('aria-expanded') === 'true';

      // Close other sibling submenus at the same level
      const parentLi = btn.closest('li');
      const siblingToggles = parentLi?.parentElement?.querySelectorAll<HTMLButtonElement>('.ps-mainmenu__toggle-dropdown');

      siblingToggles?.forEach((otherBtn) => {
        if (otherBtn === btn) return;
        const otherId = otherBtn.getAttribute('aria-controls');

        if (!otherId) return;
        const otherDiv = document.getElementById(otherId);

        if (!otherDiv) return;

        const otherUL = otherDiv.querySelector<HTMLUListElement>('.submenu__level');

        if (otherUL) {
          otherUL.classList.add('d-none');
          otherUL.setAttribute('aria-hidden', 'true');
        }
        otherDiv.classList.add('d-none');
        otherDiv.setAttribute('aria-hidden', 'true');

        otherBtn.setAttribute('aria-expanded', 'false');
        const icon = otherBtn.querySelector<HTMLElement>('.ps-mainmenu_dropdown');

        if (icon) {
          icon.classList.remove('ps-mainmenu_dropdown-up');
          icon.classList.add('ps-mainmenu_dropdown-down');
        }
      });

      // Toggle submenu
      btn.setAttribute('aria-expanded', String(!expanded));
      submenuDiv.setAttribute('aria-hidden', String(expanded));
      submenuDiv.classList.toggle('d-none', expanded);

      if (submenuUL) {
        submenuUL.classList.toggle('d-none', expanded);
        submenuUL.setAttribute('aria-hidden', String(expanded));
      }

      // Rotate chevron icon
      const icon = btn.querySelector<HTMLElement>('.ps-mainmenu_dropdown');

      if (icon) {
        icon.classList.toggle('ps-mainmenu_dropdown-up', !expanded);
        icon.classList.toggle('ps-mainmenu_dropdown-down', expanded);
      }
    });

    // Keyboard accessibility
    btn.addEventListener('keydown', (e) => {
      if (e.key === 'Enter' || e.key === ' ') {
        e.preventDefault();
        btn.click();
      }
    });
  });

  // Close all submenus on outside click/focus
  const closeAllSubmenus = () => {
    toggles.forEach((btn) => {
      const submenuId = btn.getAttribute('aria-controls');

      if (!submenuId) return;
      const submenuDiv = document.getElementById(submenuId);

      if (!submenuDiv) return;

      const submenuUL = submenuDiv.querySelector<HTMLUListElement>('.submenu__level');

      // Ferme <ul> et div parent
      if (submenuUL) {
        submenuUL.classList.add('d-none');
        submenuUL.setAttribute('aria-hidden', 'true');
      }
      submenuDiv.classList.add('d-none');
      submenuDiv.setAttribute('aria-hidden', 'true');

      btn.setAttribute('aria-expanded', 'false');
      const icon = btn.querySelector<HTMLElement>('.ps-mainmenu_dropdown');

      if (icon) {
        icon.classList.remove('ps-mainmenu_dropdown-up');
        icon.classList.add('ps-mainmenu_dropdown-down');
      }
    });
  };

  document.addEventListener('click', (e) => {
    const isClickInsideMenu = (e.target as HTMLElement).closest('.ps-mainmenu');

    if (!isClickInsideMenu) closeAllSubmenus();
  });

  document.addEventListener('focusin', (e) => {
    const isFocusInsideMenu = (e.target as HTMLElement).closest('.ps-mainmenu');

    if (!isFocusInsideMenu) closeAllSubmenus();
  });

  // Keyboard navigation
  const focusableItems = document.querySelectorAll<HTMLElement>('.ps-mainmenu__tree__link, .submenu__link');
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
        default:
          break;
      }
    });
  });
};

export default initDesktopMenu;
