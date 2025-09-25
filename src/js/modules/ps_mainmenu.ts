const initDesktopMenu = (): void => {
  const dropdownToggles = document.querySelectorAll<HTMLElement>('.navbar .dropdown-toggle');

  dropdownToggles.forEach((toggle) => {
    toggle.addEventListener('show.bs.dropdown', () => {
      console.debug(`Opening menu: ${toggle.textContent?.trim()}`);
    });

    toggle.addEventListener('hide.bs.dropdown', () => {
      console.debug(`Closing menu : ${toggle.textContent?.trim()}`);
    });
  });
};

const initMobileMenu = (): void => {
  const mobileMenu = document.getElementById('mobileMenu');
  if (!mobileMenu) return;

  mobileMenu.addEventListener('show.bs.offcanvas', () => {
    console.debug('Opening mobile menu');
  });

  mobileMenu.addEventListener('hide.bs.offcanvas', () => {
    console.debug('Closing mobile menu');
  });

  mobileMenu.addEventListener('shown.bs.offcanvas', () => {
    const firstLink = mobileMenu.querySelector<HTMLElement>('.menu__link');
    firstLink?.focus();
  });
};

const initMainMenu = (): void => {
  initDesktopMenu();
  initMobileMenu();
};

export default initMainMenu;
