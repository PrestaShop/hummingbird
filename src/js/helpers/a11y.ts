// Accessibility Helpers Class
import themeState from '../state';

class A11yHelpers {
  // Focus Management
  getStoredFocus(): HTMLElement | null {
    return themeState.get('storedFocusElement');
  }

  getStoredFocusId(): string | null {
    return themeState.get('storedFocusElementId');
  }

  setFocus(element: HTMLElement): void {
    element.focus();
    themeState.set('storedFocusElement', element);
    themeState.set('storedFocusElementId', element.id);
  }

  storeFocus(): void {
    const activeElement = document.activeElement as HTMLElement;
    themeState.set('storedFocusElement', activeElement);
    themeState.set('storedFocusElementId', activeElement.id as string);
  }

  clearStoredFocus(): void {
    themeState.set('storedFocusElement', null);
    themeState.set('storedFocusElementId', null);
  }

  restoreFocus(fallbackElement: HTMLElement | null = null): boolean {
    let success = false;

    try {
      const storedFocusElementId = themeState.get('storedFocusElementId');
      const storedFocusElement = themeState.get('storedFocusElement');

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
