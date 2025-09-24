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

  // Screen Reader Announcements based on data-ps-announce attribute
  announce(element: HTMLElement, priority: 'polite' | 'assertive' = 'polite', role: 'alert' | 'status' = 'alert', delay: number = 250): void {
    // Remove any existing announcement container
    const announcementContainer = document.getElementById('announcement_container');

    if (announcementContainer) {
      announcementContainer.remove();
    }

    // Create a temporary element for the announcement
    const announcement = document.createElement('div');
    announcement.id = 'announcement_container';
    announcement.setAttribute('role', role);
    announcement.setAttribute('aria-atomic', 'true');
    announcement.setAttribute('aria-live', priority);
    announcement.className = 'visually-hidden';

    // Get the announcement text from data-ps-announce attribute
    const text = element.getAttribute('data-ps-announce');
    
    if (!text) {
      console.warn('No data-ps-announce attribute found on element');
      return;
    }
    
    // Add to DOM
    document.body.appendChild(announcement);
    
    // Set the text content to trigger the announcement
    setTimeout(() => {
      announcement.textContent = text;
    }, delay);
  }
}

export default A11yHelpers;
