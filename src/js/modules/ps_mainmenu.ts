import {desktopMenu} from '@constants/selectors-map';

// Constants
const MENU_ATTRIBUTES = {
  HAS_CHILD: 'data-ps-has-child',
  OPEN_TAB: 'data-open-tab',
  DEPTH: 'data-depth',
  SELECTED: 'aria-selected="true"',
} as const;

// Types & Interfaces
interface MenuState {
  isSubMenuOpen: boolean;
  currentSubMenu: HTMLElement | null;
  currentDropdownButton: HTMLElement | null;
}

type NavigationDirection = 'next' | 'prev';

// Menu state manager
class MenuStateManager {
  private state: MenuState = {
    isSubMenuOpen: false,
    currentSubMenu: null,
    currentDropdownButton: null,
  };

  get isSubMenuOpen(): boolean {
    return this.state.isSubMenuOpen;
  }

  get currentSubMenu(): HTMLElement | null {
    return this.state.currentSubMenu;
  }

  get currentDropdownButton(): HTMLElement | null {
    return this.state.currentDropdownButton;
  }

  setSubMenuOpen(isOpen: boolean): void {
    this.state.isSubMenuOpen = isOpen;
  }

  setCurrentSubMenu(subMenu: HTMLElement | null): void {
    this.state.currentSubMenu = subMenu;
  }

  setCurrentDropdownButton(button: HTMLElement | null): void {
    this.state.currentDropdownButton = button;
  }

  reset(): void {
    this.state = {
      isSubMenuOpen: false,
      currentSubMenu: null,
      currentDropdownButton: null,
    };
  }
}

// Menu element selectors
class MenuElementQueries {
  static getMainMenuItems(): NodeListOf<HTMLElement> {
    return document.querySelectorAll(`${desktopMenu.container} ${desktopMenu.menuLink}`) as NodeListOf<HTMLElement>;
  }

  static getDropdownButtons(): NodeListOf<HTMLElement> {
    return document.querySelectorAll(`${desktopMenu.container} ${desktopMenu.dropdownToggle}`) as NodeListOf<HTMLElement>;
  }

  static getAllSubMenus(): NodeListOf<HTMLElement> {
    return document.querySelectorAll(`${desktopMenu.subMenu}`) as NodeListOf<HTMLElement>;
  }

  static getSubMenuLeftItems(): NodeListOf<HTMLElement> {
    return document.querySelectorAll<HTMLElement>(`${desktopMenu.subMenuLeft} > ${desktopMenu.subMenuLeftItem}`);
  }

  static getSubMenuRightTabs(): NodeListOf<HTMLElement> {
    return document.querySelectorAll<HTMLElement>(`${desktopMenu.subMenuRight} ${desktopMenu.subMenuRightItems}`);
  }

  static getActiveSubMenuLeftItem(subMenu: HTMLElement): HTMLElement | null {
    return subMenu.querySelector(`${desktopMenu.subMenuLeftItem}[${MENU_ATTRIBUTES.SELECTED}]`) as HTMLElement;
  }

  // Flatten main menu elements array to track all menu items and dropdown buttons for keyboard navigation
  static createMainMenuElementsArray(mainMenuItems: NodeListOf<HTMLElement>): HTMLElement[] {
    const elements: HTMLElement[] = [];

    mainMenuItems.forEach((link) => {
      elements.push(link);
      const liElement = link.closest(desktopMenu.menuItem);
      const dropdownButton = liElement?.querySelector(desktopMenu.dropdownToggle) as HTMLElement;

      if (dropdownButton) {
        elements.push(dropdownButton);
      }
    });

    return elements;
  }
}

// Accessibility utilities
class AccessibilityManager {
  static setSubMenuVisibility(subMenu: HTMLElement, isVisible: boolean): void {
    subMenu.style.display = isVisible ? 'block' : 'none';
  }

  static setDropdownButtonState(button: HTMLElement, isExpanded: boolean): void {
    button.setAttribute('aria-expanded', isExpanded.toString());
  }

  static setTabSelection(tab: HTMLElement, isSelected: boolean): void {
    tab.setAttribute('aria-selected', isSelected.toString());
    tab.setAttribute('tabindex', isSelected ? '0' : '-1');
    tab.classList.toggle('active', isSelected);
  }

  static setTabPanelVisibility(panel: HTMLElement, isVisible: boolean): void {
    panel.classList.toggle('active', isVisible);
    panel.classList.toggle('not-active', !isVisible);
  }

  static resetAllSubMenuStates(): void {
    const allSubMenus = MenuElementQueries.getAllSubMenus();
    const allDropdownButtons = MenuElementQueries.getDropdownButtons();

    allSubMenus.forEach((subMenu) => {
      this.setSubMenuVisibility(subMenu, false);
    });

    allDropdownButtons.forEach((button) => {
      this.setDropdownButtonState(button, false);
    });
  }
}

// Navigation utilities
class NavigationManager {
  static navigateMainMenu(
    currentElement: HTMLElement,
    direction: NavigationDirection,
    rootMenuElements: HTMLElement[],
  ): void {
    const currentIndex = rootMenuElements.indexOf(currentElement);

    if (currentIndex < 0) return;

    const targetIndex = this.calculateTargetIndex(currentIndex, direction, rootMenuElements.length);
    const targetElement = rootMenuElements[targetIndex];

    if (targetElement) {
      targetElement.focus();
    }
  }

  static navigateSubMenuTabs(
    currentItem: HTMLElement,
    direction: NavigationDirection,
    subMenu: HTMLElement,
  ): HTMLElement | null {
    const subMenuLeftLinks = subMenu.querySelectorAll(desktopMenu.subMenuLeftItem) as NodeListOf<HTMLElement>;
    const currentIndex = Array.from(subMenuLeftLinks).indexOf(currentItem);

    if (currentIndex < 0) return null;

    const targetIndex = this.calculateTargetIndex(currentIndex, direction, subMenuLeftLinks.length);

    return subMenuLeftLinks[targetIndex] as HTMLElement;
  }

  private static calculateTargetIndex(currentIndex: number, direction: NavigationDirection, totalLength: number): number {
    if (direction === 'next') {
      return (currentIndex + 1) % totalLength;
    }
    return currentIndex === 0 ? totalLength - 1 : currentIndex - 1;
  }
}

// SubMenu management
class SubMenuManager {
  constructor(
    private stateManager: MenuStateManager,
  ) {
    // Empty constructor with parameters
  }

  showSubMenu(dropdownButton: HTMLElement, subMenu: HTMLElement): void {
    this.closeAllSubMenus();
    this.positionSubMenu(dropdownButton, subMenu);
    this.updateSubMenuState(dropdownButton, subMenu, true);
    this.initializeSubMenuTabs(subMenu);
  }

  hideSubMenu(dropdownButton: HTMLElement, subMenu: HTMLElement): void {
    AccessibilityManager.setSubMenuVisibility(subMenu, false);
    AccessibilityManager.setDropdownButtonState(dropdownButton, false);
    this.stateManager.setSubMenuOpen(false);
    this.stateManager.setCurrentSubMenu(null);
    this.stateManager.setCurrentDropdownButton(null);
  }

  closeAllSubMenus(): void {
    AccessibilityManager.resetAllSubMenuStates();
    this.stateManager.reset();
  }

  switchSubMenuTab(item: HTMLElement, subMenu: HTMLElement): void {
    const subMenuLeftLinks = subMenu.querySelectorAll(desktopMenu.subMenuLeftItem) as NodeListOf<HTMLElement>;
    const subMenuRightTabs = subMenu.querySelectorAll(`${desktopMenu.subMenuRight} ${desktopMenu.subMenuRightItems}`) as NodeListOf<HTMLElement>;

    subMenuLeftLinks.forEach((leftLink) => {
      AccessibilityManager.setTabSelection(leftLink, false);
    });

    if (item.hasAttribute(MENU_ATTRIBUTES.HAS_CHILD)) {
      AccessibilityManager.setTabSelection(item, true);
    }

    subMenuRightTabs.forEach((rightTab) => {
      AccessibilityManager.setTabPanelVisibility(rightTab, false);
    });

    this.showCorrespondingRightTab(item, subMenu);
  }

  private positionSubMenu(dropdownButton: HTMLElement, subMenu: HTMLElement): void {
    const liElement = dropdownButton.closest(desktopMenu.menuItem) as HTMLElement;

    if (!liElement) return;

    const liPosition = liElement.offsetHeight + liElement.offsetTop;
    subMenu.style.top = `${liPosition}px`;
  }

  private updateSubMenuState(dropdownButton: HTMLElement, subMenu: HTMLElement, isOpen: boolean): void {
    AccessibilityManager.setSubMenuVisibility(subMenu, isOpen);
    AccessibilityManager.setDropdownButtonState(dropdownButton, isOpen);

    this.stateManager.setSubMenuOpen(isOpen);
    this.stateManager.setCurrentSubMenu(subMenu);
    this.stateManager.setCurrentDropdownButton(dropdownButton);
  }

  private initializeSubMenuTabs(subMenu: HTMLElement): void {
    const rightTabs = subMenu.querySelectorAll(`${desktopMenu.subMenuRight} ${desktopMenu.subMenuRightItems}`) as NodeListOf<HTMLElement>;
    const leftLinks = subMenu.querySelectorAll(desktopMenu.subMenuLeftItem) as NodeListOf<HTMLElement>;

    rightTabs.forEach((rightTab) => {
      AccessibilityManager.setTabPanelVisibility(rightTab, false);
    });

    leftLinks.forEach((leftLink, index) => {
      AccessibilityManager.setTabSelection(leftLink, index === 0);

      if (index === 0) {
        this.showCorrespondingRightTab(leftLink, subMenu);
      }
    });
  }

  private showCorrespondingRightTab(item: HTMLElement, subMenu: HTMLElement): void {
    const toggleTab = item.getAttribute(MENU_ATTRIBUTES.OPEN_TAB);

    if (!toggleTab) return;

    const targetTab = subMenu.querySelector(`#${toggleTab}`) as HTMLElement;

    if (targetTab) {
      AccessibilityManager.setTabPanelVisibility(targetTab, true);
    }
  }
}

// Event handlers
class EventHandlers {
  constructor(
    private stateManager: MenuStateManager,
    private subMenuManager: SubMenuManager,
    private allMainMenuElements: HTMLElement[],
  ) {
    // Empty constructor with parameters
  }

  // Handle main menu link keyboard events
  handleMainMenuLinkKeydown = (event: KeyboardEvent): void => {
    const link = event.target as HTMLElement;

    switch (event.key) {
      case 'ArrowRight':
      case 'ArrowDown':
        event.preventDefault();
        NavigationManager.navigateMainMenu(link, 'next', this.allMainMenuElements);
        break;

      case 'ArrowLeft':
      case 'ArrowUp':
        event.preventDefault();
        NavigationManager.navigateMainMenu(link, 'prev', this.allMainMenuElements);
        break;

      default:
        // No action needed for other keys
        break;
    }
  };

  // Handle dropdown button keyboard events
  handleDropdownButtonKeydown = (dropdownButton: HTMLElement, subMenu: HTMLElement) => (event: KeyboardEvent): void => {
    switch (event.key) {
      case 'Enter':
      case ' ':
        event.preventDefault();
        this.toggleSubMenu(dropdownButton, subMenu);
        break;

      case 'Escape':
        event.preventDefault();
        this.subMenuManager.hideSubMenu(dropdownButton, subMenu);
        dropdownButton.focus();
        break;

      case 'ArrowRight':
        event.preventDefault();
        NavigationManager.navigateMainMenu(dropdownButton, 'next', this.allMainMenuElements);
        break;

      case 'ArrowDown':
        event.preventDefault();
        // If submenu is open, navigate to first submenu item
        if (this.stateManager.isSubMenuOpen && this.stateManager.currentSubMenu === subMenu) {
          const firstSubMenuItem = subMenu.querySelector(desktopMenu.subMenuLeftItem) as HTMLElement;

          if (firstSubMenuItem) {
            firstSubMenuItem.focus();
          }
        } else {
          NavigationManager.navigateMainMenu(dropdownButton, 'next', this.allMainMenuElements);
        }
        break;

      case 'ArrowLeft':
      case 'ArrowUp':
        event.preventDefault();
        NavigationManager.navigateMainMenu(dropdownButton, 'prev', this.allMainMenuElements);
        break;

      default:
        // No action needed for other keys
        break;
    }
  };

  // Handle subMenu tab keyboard events
  handleSubMenuTabKeydown = (item: HTMLElement) => (event: KeyboardEvent): void => {
    const subMenu = item.closest(desktopMenu.subMenu) as HTMLElement;

    if (!subMenu) return;

    switch (event.key) {
      case 'ArrowDown':
        event.preventDefault();
        this.navigateToSubMenuTab(item, 'next', subMenu);
        break;

      case 'ArrowUp':
        event.preventDefault();
        this.navigateToSubMenuTab(item, 'prev', subMenu);
        break;

      case ' ':
        event.preventDefault();
        this.subMenuManager.switchSubMenuTab(item, subMenu);
        break;

      case 'Escape':
        event.preventDefault();
        this.handleSubMenuEscape(subMenu);
        break;

      default:
        // No action needed for other keys
        break;
    }
  };

  // Handle click outside menu
  handleClickOutside = (event: MouseEvent): void => {
    const target = event.target as HTMLElement;

    if (!target.closest(desktopMenu.container)) {
      this.subMenuManager.closeAllSubMenus();
    }
  };

  // Handle focus leaving menu area
  handleFocusOut = (event: FocusEvent): void => {
    const target = event.target as HTMLElement;
    const relatedTarget = event.relatedTarget as HTMLElement;

    if (target && target.closest(desktopMenu.container)) {
      if (!relatedTarget || !relatedTarget.closest(desktopMenu.container)) {
        this.subMenuManager.closeAllSubMenus();
      }
    }
  };

  // Handle keyboard events in right subMenu sections
  handleRightSubMenuKeydown = (event: KeyboardEvent): void => {
    const target = event.target as HTMLElement;
    const subMenu = target.closest(desktopMenu.subMenu) as HTMLElement;

    if (!subMenu) return;

    switch (event.key) {
      case 'Escape':
        event.preventDefault();
        this.handleSubMenuEscape(subMenu);
        break;

      case 'ArrowLeft': {
        event.preventDefault();
        const activeLeftTab = MenuElementQueries.getActiveSubMenuLeftItem(subMenu);

        if (activeLeftTab) {
          activeLeftTab.focus();
        }
        break;
      }

      default:
        // No action needed for other keys
        break;
    }
  };

  // Toggle subMenu
  toggleSubMenu(dropdownButton: HTMLElement, subMenu: HTMLElement): void {
    if (this.stateManager.isSubMenuOpen && this.stateManager.currentSubMenu === subMenu) {
      this.subMenuManager.hideSubMenu(dropdownButton, subMenu);
    } else {
      this.subMenuManager.showSubMenu(dropdownButton, subMenu);
    }
  }

  private navigateToSubMenuTab(
    item: HTMLElement,
    direction: NavigationDirection,
    subMenu: HTMLElement,
  ): void {
    const targetItem = NavigationManager.navigateSubMenuTabs(item, direction, subMenu);

    if (targetItem) {
      targetItem.focus();
      this.subMenuManager.switchSubMenuTab(targetItem, subMenu);
    }
  }

  private handleSubMenuEscape(subMenu: HTMLElement): void {
    const parentDropdownButton = subMenu.closest(desktopMenu.menuItem)?.querySelector(desktopMenu.dropdownToggle) as HTMLElement;

    if (parentDropdownButton) {
      parentDropdownButton.focus();
      this.subMenuManager.closeAllSubMenus();
    }
  }
}

// Component setup
class MenuComponentSetup {
  constructor(
    private subMenuManager: SubMenuManager,
    private eventHandlers: EventHandlers,
  ) {
    // Empty constructor with parameters
  }

  // Setup dropdown button functionality
  setupDropdownButton(dropdownButton: HTMLElement): void {
    const liElement = dropdownButton.closest(desktopMenu.menuItem);
    const subMenu = liElement?.querySelector(desktopMenu.subMenu) as HTMLElement;

    if (!subMenu) return;

    // Mouse events
    liElement?.addEventListener('mouseenter', () => this.subMenuManager.showSubMenu(dropdownButton, subMenu));
    liElement?.addEventListener('mouseleave', () => this.subMenuManager.hideSubMenu(dropdownButton, subMenu));

    // Keyboard navigation
    dropdownButton.addEventListener('keydown',
      this.eventHandlers.handleDropdownButtonKeydown(dropdownButton, subMenu),
    );
  }

  // Setup main menu link functionality
  setupMainMenuLink(link: HTMLElement): void {
    link.addEventListener('keydown', this.eventHandlers.handleMainMenuLinkKeydown);
  }

  // Setup subMenu navigation
  setupSubMenuNavigation(): void {
    const leftLinks = MenuElementQueries.getSubMenuLeftItems();
    const rightTabs = MenuElementQueries.getSubMenuRightTabs();

    leftLinks.forEach((item) => {
      item.addEventListener('mouseenter', () => {
        const subMenu = item.closest(desktopMenu.subMenu) as HTMLElement;

        if (subMenu) {
          this.subMenuManager.switchSubMenuTab(item, subMenu);
        }
      });

      // Keyboard navigation
      item.addEventListener('keydown', this.eventHandlers.handleSubMenuTabKeydown(item));

      // Focus management
      item.addEventListener('focus', () => {
        const subMenu = item.closest(desktopMenu.subMenu) as HTMLElement;

        if (subMenu) {
          this.subMenuManager.switchSubMenuTab(item, subMenu);
        }
      });
    });

    // Setup keyboard navigation for right subMenu sections
    rightTabs.forEach((rightTab) => {
      rightTab.addEventListener('keydown', this.eventHandlers.handleRightSubMenuKeydown);
    });
  }

  // Setup global event listeners
  setupGlobalEventListeners(): void {
    // Close subMenus when clicking outside
    document.addEventListener('click', this.eventHandlers.handleClickOutside);

    // Close subMenus when focus leaves menu area
    document.addEventListener('focusout', this.eventHandlers.handleFocusOut);
  }
}

// Main initialization
const initDesktopMenu = (): void => {
  // Initialize managers
  const stateManager = new MenuStateManager();
  const elements = {
    mainMenuItems: MenuElementQueries.getMainMenuItems(),
    dropdownButtons: MenuElementQueries.getDropdownButtons(),
    allMainMenuElements: MenuElementQueries.createMainMenuElementsArray(
      MenuElementQueries.getMainMenuItems(),
    ),
  };

  const subMenuManager = new SubMenuManager(stateManager);
  const eventHandlers = new EventHandlers(stateManager, subMenuManager, elements.allMainMenuElements);
  const componentSetup = new MenuComponentSetup(subMenuManager, eventHandlers);

  // Setup menu features
  elements.dropdownButtons.forEach((button) => componentSetup.setupDropdownButton(button));
  elements.mainMenuItems.forEach((link) => componentSetup.setupMainMenuLink(link));
  componentSetup.setupSubMenuNavigation();
  componentSetup.setupGlobalEventListeners();
};

export default initDesktopMenu;
