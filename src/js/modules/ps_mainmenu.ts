const initDesktopMenu = () => {
  /**
   * Handle submenu
   */
  const dropdownToggles = document.querySelectorAll('.js-menu-desktop .dropdown-toggle');
  dropdownToggles.forEach((dropdownToggleElement: HTMLElement) => {
    // Controls the display of the submenu for mouse events inside the menu container
    const liElement = dropdownToggleElement.closest('li');

    liElement?.addEventListener('mouseenter', () => {
      const liPosition = liElement.offsetHeight + liElement.offsetTop;
      const subMenu = liElement?.querySelector('.js-sub-menu') as HTMLElement;

      if (subMenu) {
        // Add 'px' to convert to a valid string
        subMenu.style.top = `${liPosition}px`;
        rightTabs.forEach((rightTab) => {
          rightTab.classList.remove('active');
          rightTab.classList.remove('not-active');
        });

        const leftLinks = subMenu.querySelectorAll('.submenu__left-item');
        leftLinks.forEach((leftLink, index) => {
          if (index === 0) {
            leftLink.classList.add('active');
          } else {
            leftLink.classList.remove('active');
          }
        });
      }
    });
  });

  /**
   * Handle tab menu
   */
  const leftLinks = document.querySelectorAll<HTMLElement>('.submenu__left > .submenu__left-item');
  const rightTabs = document.querySelectorAll<HTMLElement>('.submenu__right .submenu__right-items');
  leftLinks.forEach((item) => {
    item.addEventListener('mouseenter', () => {
      if (item && !item.classList.contains('active') && item.classList.contains('has-child')) {
        leftLinks.forEach((leftLink) => {
          leftLink.classList.remove('active');
        });
        item.classList.add('active');
      } else if (item && !item.classList.contains('has-child')) {
        leftLinks.forEach((leftLink) => {
          leftLink.classList.remove('active');
        });
      }

      // Get the value of the "data-open-tab" attribute
      const toggleTab = item.getAttribute('data-open-tab');

      // Find the element with the matching "data-id" attribute value
      const targetTab = item.closest('.submenu__row')?.querySelector(`[data-id="${toggleTab}"]`);

      rightTabs.forEach((rightTab) => {
        rightTab.classList.remove('active');
        rightTab.classList.add('not-active');
      });

      // Add the "active" class to the selected element
      if (targetTab && !targetTab.classList.contains('active')) {
        targetTab.classList.remove('not-active');
        targetTab.classList.add('active');
      }
    });
  });

  // Keyboard navigation for top-level menu
  const menuLinks = document.querySelectorAll('.ps-mainmenu__tree__link');
  menuLinks.forEach((link, idx) => {
    link.addEventListener('keydown', (e: KeyboardEvent) => {
      if (e.key === 'ArrowRight') {
        e.preventDefault();
        const next = menuLinks[idx + 1] || menuLinks[0];
        (next as HTMLElement).focus();
      }
      if (e.key === 'ArrowLeft') {
        e.preventDefault();
        const prev = menuLinks[idx - 1] || menuLinks[menuLinks.length - 1];
        (prev as HTMLElement).focus();
      }
      if (e.key === 'ArrowDown') {
        // Focus first submenu item if exists
        const submenu = link.parentElement?.querySelector('.submenu__left-item');
        if (submenu) {
          // Open submenu
          link.setAttribute('aria-expanded', 'true');
          const submenuContainer = link.parentElement?.querySelector('.js-sub-menu') as HTMLElement;
          if (submenuContainer) submenuContainer.setAttribute('aria-hidden', 'false');
          (submenu as HTMLElement).focus();
        }
      }
      if (e.key === 'Escape') {
        // Close submenu if open
        link.setAttribute('aria-expanded', 'false');
        const submenuContainer = link.parentElement?.querySelector('.js-sub-menu') as HTMLElement;
        if (submenuContainer) submenuContainer.setAttribute('aria-hidden', 'true');
        (link as HTMLElement).focus();
      }
    });
  });

  // Keyboard navigation for submenu items
  const submenuItems = document.querySelectorAll('.submenu__left-item');
  submenuItems.forEach((item, idx) => {
    item.addEventListener('keydown', (e: KeyboardEvent) => {
      if (e.key === 'ArrowDown') {
        e.preventDefault();
        const next = submenuItems[idx + 1] || submenuItems[0];
        (next as HTMLElement).focus();
      }
      if (e.key === 'ArrowUp') {
        e.preventDefault();
        const prev = submenuItems[idx - 1] || submenuItems[submenuItems.length - 1];
        (prev as HTMLElement).focus();
      }
      if (e.key === 'Escape') {
        // Close submenu and return focus to parent menu link
        const parentLink = item.closest('li')?.querySelector('.ps-mainmenu__tree__link') as HTMLElement;
        if (parentLink) {
          parentLink.setAttribute('aria-expanded', 'false');
          const submenuContainer = parentLink.parentElement?.querySelector('.js-sub-menu') as HTMLElement;
          if (submenuContainer) submenuContainer.setAttribute('aria-hidden', 'true');
          parentLink.focus();
        }
      }
    });
  });
};

export default initDesktopMenu;
