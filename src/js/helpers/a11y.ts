// Accessibility Helpers Class
import ThemeState from '@js/state';

class A11yHelpers {
  private state: ThemeState;

  constructor(state: ThemeState) {
    this.state = state;
  }

  // Focus Management
  getStoredFocus(): HTMLElement | null {
    return this.state.get('storedFocusElement');
  }

  getStoredFocusId(): string | null {
    return this.state.get('storedFocusElementId');
  }

  setFocus(element: HTMLElement): void {
    element.focus();
    this.state.set('storedFocusElement', element);
    this.state.set('storedFocusElementId', element.id);
  }

  storeFocus(): void {
    const activeElement = document.activeElement as HTMLElement;
    this.state.set('storedFocusElement', activeElement);
    this.state.set('storedFocusElementId', activeElement.id);
  }

  clearStoredFocus(): void {
    this.state.set('storedFocusElement', null);
    this.state.set('storedFocusElementId', null);
  }

  restoreFocus(fallbackElement: HTMLElement | null = null): boolean {
    let success = false;

    try {
      const storedFocusElementId = this.state.get('storedFocusElementId');
      const storedFocusElement = this.state.get('storedFocusElement');

      if (storedFocusElementId) {
        const elementToFocus = document.getElementById(storedFocusElementId);

        if (elementToFocus) {
          elementToFocus.focus();
          success = true;
        }
      }

      if (!success && storedFocusElement && document.contains(storedFocusElement)) {
        storedFocusElement.focus();
        success = true;
      }

      // If neither stored focus method worked and a fallback element is provided
      if (!success && fallbackElement && document.contains(fallbackElement)) {
        fallbackElement.focus();
        success = false;
      }

      if (!success && !fallbackElement) {
        success = false;
      }
    } catch {
      // Silently handle focus errors
      success = false;
    } finally {
      this.clearStoredFocus();
    }

    return success;
  }
}

export default A11yHelpers;
