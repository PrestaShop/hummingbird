const initDesktopMenu = () => {
  /**
   * Handle submenu display on hover (mouse)
   */
  const menuItems = document.querySelectorAll<HTMLLIElement>('.ps-mainmenu__tree__item');
  menuItems.forEach((li) => {
    li.addEventListener('mouseenter', () => {
      const submenu = li.querySelector<HTMLElement>('.js-sub-menu');
      if (submenu) {
        submenu.setAttribute('aria-hidden', 'false');
        submenu.classList.remove('hidden');
      }
    });
    li.addEventListener('mouseleave', () => {
      const submenu = li.querySelector<HTMLElement>('.js-sub-menu');
      if (submenu) {
        submenu.setAttribute('aria-hidden', 'true');
        submenu.classList.add('hidden');
      }
    });
  });

  /**
   * Toggle button click (desktop)
   */
  const toggles = document.querySelectorAll<HTMLButtonElement>('.ps-mainmenu__toggle-dropdown');
  toggles.forEach((btn) => {
    btn.addEventListener('click', () => {
      const submenuId = btn.getAttribute('aria-controls');
      if (!submenuId) return;
      const submenu = document.getElementById(submenuId);
      if (!submenu) return;

      const expanded = btn.getAttribute('aria-expanded') === 'true';
      btn.setAttribute('aria-expanded', String(!expanded));
      submenu.setAttribute('aria-hidden', String(expanded));
      submenu.classList.toggle('hidden', expanded);
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
   * Keyboard navigation for top-level menu
   */
  const menuLinks = document.querySelectorAll<HTMLElement>('.ps-mainmenu__tree__link');
  menuLinks.forEach((link, idx) => {
    link.addEventListener('keydown', (e: KeyboardEvent) => {
      const total = menuLinks.length;
      switch (e.key) {
        case 'ArrowRight':
          e.preventDefault();
          menuLinks[(idx + 1) % total].focus();
          break;
        case 'ArrowLeft':
          e.preventDefault();
          menuLinks[(idx - 1 + total) % total].focus();
          break;
        case 'ArrowDown':
          e.preventDefault();
          const submenu = link.parentElement?.querySelector<HTMLElement>('.js-sub-menu .submenu__left-item');
          if (submenu) submenu.focus();
          break;
        case 'Escape':
          const submenuContainer = link.parentElement?.querySelector<HTMLElement>('.js-sub-menu');
          if (submenuContainer) submenuContainer.setAttribute('aria-hidden', 'true');
          link.focus();
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
        case 'ArrowDown':
          e.preventDefault();
          submenuItems[(idx + 1) % total].focus();
          break;
        case 'ArrowUp':
          e.preventDefault();
          submenuItems[(idx - 1 + total) % total].focus();
          break;
        case 'Escape':
          const parentLink = item.closest('li')?.querySelector<HTMLElement>('.ps-mainmenu__tree__link');
          const submenuContainer = item.closest<HTMLElement>('.js-sub-menu');
          if (parentLink && submenuContainer) {
            submenuContainer.setAttribute('aria-hidden', 'true');
            parentLink.focus();
          }
          break;
      }
    });
  });
};

export default initDesktopMenu;
