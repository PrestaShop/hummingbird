import {state} from '@js/state';

class A11yHelpers {
  // Focus Management
  getStoredFocus(): HTMLElement | null {
    return state.get('storedFocusElement');
  }

  getStoredFocusId(): string | null {
    return state.get('storedFocusElementId');
  }

  setFocus(element: HTMLElement): void {
    element.focus();
    state.set('storedFocusElement', element);
    state.set('storedFocusElementId', element.id);
  }

  storeFocus(): void {
    const activeElement = document.activeElement as HTMLElement;
    state.set('storedFocusElement', activeElement);
    state.set('storedFocusElementId', activeElement.id);
  }

  clearStoredFocus(): void {
    state.set('storedFocusElement', null);
    state.set('storedFocusElementId', null);
  }

  restoreFocus(fallbackElement: HTMLElement | null = null): boolean {
    let success = false;

    try {
      const storedFocusElementId = state.get('storedFocusElementId');
      const storedFocusElement = state.get('storedFocusElement');

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
