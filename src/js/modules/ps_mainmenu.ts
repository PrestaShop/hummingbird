const initDesktopMenu = () => {
  /**
   * Handle submenu
   */
  const dropdownToggles = document.querySelectorAll('.js-menu-desktop .dropdown-toggle');
  dropdownToggles.forEach((dropdownToggleElement: HTMLElement) => {
    /* Contrôle de l'affichage du sous-menu pour les événements de la souris à l'intérieur du conteneur du menu */
    const liElement = dropdownToggleElement.closest('li');

    liElement?.addEventListener('mouseenter', () => {
      const liPosition = liElement.offsetHeight + liElement.offsetTop;
      const subMenu = liElement?.querySelector('.js-sub-menu') as HTMLElement;

      if (subMenu) {
        subMenu.style.top = `${liPosition}px`; // Ajoutez 'px' pour convertir en une chaîne valide
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
};

export default initDesktopMenu;
