/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import {searchProduct, Result} from '@services/search';
import debounce from '@helpers/debounce';
import {Offcanvas} from 'bootstrap';

/**
 * Initialize search bar functionality including:
 * - Search input handling
 * - Search results dropdown
 * - Clear button behavior
 * - Mobile search canvas
 */
const initSearchbar = () => {
  const {Theme} = window;
  const {searchBar: SearchBarMap} = Theme.selectors;

  // Get DOM elements
  const searchCanvas = document.querySelector<HTMLElement>(SearchBarMap.searchCanvas);
  const searchWidget = document.querySelector<HTMLElement>(SearchBarMap.searchWidget);
  const searchDropdown = document.querySelector<HTMLElement>(SearchBarMap.searchDropdown);
  const searchResults = document.querySelector<HTMLElement>(SearchBarMap.searchResults);
  const searchTemplate = document.querySelector<HTMLTemplateElement>(SearchBarMap.searchTemplate);
  const searchInput = document.querySelector<HTMLInputElement>(SearchBarMap.searchInput);
  const searchIcon = document.querySelector<HTMLElement>(SearchBarMap.searchIcon);
  const searchClear = document.querySelector<HTMLElement>(SearchBarMap.searchClear);
  const searchUrl = searchWidget?.dataset.searchControllerUrl;

  // For powerusers `/` goes to search :)
  // TODO: this should probably be in a totally new "shortcuts" module that does
  // other shortcuts and even a `?` to show a small cheatsheet on the screen :)
  document.addEventListener('keydown', (e: KeyboardEvent) => {
    // Ignore if user is already typing in an input, textarea, or contenteditable element
    const active = document.activeElement as HTMLElement | null;
    const isTyping = active
      && (active.tagName === 'INPUT'
        || active.tagName === 'TEXTAREA'
        || active.isContentEditable);

    // Focus search with "/" (like GitHub)
    if (!isTyping && e.key === '/') {
      e.preventDefault();
      if (searchCanvas && !searchCanvas.classList.contains('show')) {
        const offcanvas = Offcanvas.getOrCreateInstance(searchCanvas);
        offcanvas.show();
        setTimeout(() => searchInput?.focus(), 400);
      } else {
        searchInput?.focus();
      }
    }
  });

  // Focus input on widget click (better touch UX)
  searchWidget?.addEventListener('click', () => {
    searchInput?.focus();
  });

  // Submit search on icon click if input has value
  searchIcon?.addEventListener('click', () => {
    if (searchInput?.value) {
      searchInput?.form?.submit();
    }
  });

  // Clear search input and trigger update
  const clearSearch = () => {
    if (searchInput?.value) {
      searchInput.value = '';
      searchInput.dispatchEvent(new KeyboardEvent('keydown'));
    }
    searchClear?.classList.add('d-none');
    // Ensure clear button is not tabbable when hidden
    searchClear?.setAttribute('tabindex', '-1');
    // Return focus to search input after clearing
    searchInput?.focus();
  };

  searchClear?.addEventListener('click', clearSearch);

  // Add keyboard support for clear button
  searchClear?.addEventListener('keydown', (e: KeyboardEvent) => {
    if (e.key === 'Enter' || e.key === ' ') {
      e.preventDefault();
      clearSearch();
    }
    // Tab from clear button should go to next element naturally (don't prevent default)
    // Shift+Tab should go back to search input
    if (e.key === 'Tab' && e.shiftKey) {
      e.preventDefault();
      searchInput?.focus();
    }
  });

  // Show clear button when input has value
  searchInput?.addEventListener('focus', () => {
    if (searchInput?.value) {
      searchClear?.classList.remove('d-none');
      // Make clear button tabbable when visible
      searchClear?.setAttribute('tabindex', '0');
    }
  });

  // Monitor input changes to show/hide clear button and hide results if empty
  searchInput?.addEventListener('input', () => {
    if (searchInput.value.trim() === '') {
      // Hide clear button when input is empty
      searchClear?.classList.add('d-none');
      searchClear?.setAttribute('tabindex', '-1');

      // Hide results when input is empty
      if (searchDropdown && searchResults) {
        searchDropdown.classList.add('d-none');
        searchInput.setAttribute('aria-expanded', 'false');
        searchResults.innerHTML = '';
      }
    } else {
      // Show clear button when input has content
      searchClear?.classList.remove('d-none');
      searchClear?.setAttribute('tabindex', '0');
    }
  });

  // Reset search on mobile canvas close
  searchCanvas?.addEventListener('hidden.bs.offcanvas', () => {
    if (searchDropdown && searchResults && searchInput) {
      searchResults.innerHTML = '';
      searchDropdown.classList.add('d-none');
      searchInput.setAttribute('aria-expanded', 'false');
    }
  });

  // Handle search results display
  if (searchWidget && searchInput && searchResults && searchDropdown) {
    const renderSearchResults = (products: Result[]) => {
      searchResults.innerHTML = '';
      products.forEach((product: Result) => {
        const productEl = <HTMLElement>searchTemplate?.content.cloneNode(true);

        if (productEl) {
          const productLink = productEl.querySelector<HTMLAnchorElement>('a');
          const productTitle = productEl.querySelector<HTMLElement>('p');
          const productImage = productEl.querySelector<HTMLImageElement>('img');

          if (productLink && productTitle && productImage) {
            productLink.href = product.canonical_url;
            productLink.id = `result_product_option_${product.id_product.toString()}`;
            productLink.setAttribute('aria-label', product.name);
            productTitle.innerHTML = product.name;

            if (product.cover) {
              productImage.src = product.cover.small.url;
              productImage.alt = product.cover.legend;
            } else {
              productImage.innerHTML = '';
            }

            searchResults.append(productEl);
          }
        }
      });
    };

    let currentResultIndex = -1;

    // Handle keyboard navigation in search results
    const handleKeyboardNavigation = (e: KeyboardEvent) => {
      const resultElements = searchResults.querySelectorAll<HTMLAnchorElement>(SearchBarMap.searchResultLink);

      switch (e.key) {
        case 'ArrowDown':
          e.preventDefault();
          currentResultIndex = Math.min(currentResultIndex + 1, resultElements.length - 1);
          updateResultFocus(resultElements, currentResultIndex);
          break;

        case 'ArrowUp':
          e.preventDefault();
          if (currentResultIndex > 0) {
            currentResultIndex = Math.max(currentResultIndex - 1, 0);
            updateResultFocus(resultElements, currentResultIndex);
          } else {
            currentResultIndex = -1;
            searchInput.focus();
          }
          break;

        case 'Enter':
          if (currentResultIndex >= 0 && resultElements[currentResultIndex]) {
            e.preventDefault();
            resultElements[currentResultIndex].click();
          }
          break;

        case 'Escape':
          e.preventDefault();
          searchDropdown.classList.add('d-none');
          searchInput.setAttribute('aria-expanded', 'false');
          searchInput.focus();
          currentResultIndex = -1;
          break;

        default:
          // No action needed for other keys
          break;
      }
    };

    // Update focus state for search results
    const updateResultFocus = (resultElements: NodeListOf<HTMLAnchorElement>, index: number) => {
      resultElements.forEach((element, i) => {
        if (i === index) {
          element.focus();
          element.setAttribute('aria-selected', 'true');
          searchInput.setAttribute('aria-activedescendant', resultElements[index].id);
        } else {
          element.setAttribute('aria-selected', 'false');
        }
      });
    };

    // Variables to track focus state
    let searchWidgetHasFocus = false;
    let blurTimeout: number | null = null;

    // Handle focus on search input
    searchInput.addEventListener('focus', () => {
      searchInput.removeAttribute('aria-activedescendant');
      currentResultIndex = -1;
      searchWidgetHasFocus = true;

      // Clear any pending blur timeout
      if (blurTimeout) {
        clearTimeout(blurTimeout);
        blurTimeout = null;
      }

      // Show results if they exist and input has value (re-focusing existing search)
      if (searchInput.value && searchResults && searchResults.children.length > 0) {
        searchDropdown?.classList.remove('d-none');
        searchInput.setAttribute('aria-expanded', 'true');
      }
    });

    // Handle blur - hide results when focus leaves search widget completely
    const handleBlur = () => {
      searchWidgetHasFocus = false;

      // Use setTimeout to allow focus to move to other elements in the widget
      blurTimeout = window.setTimeout(() => {
        if (!searchWidgetHasFocus && searchDropdown && searchInput) {
          searchDropdown.classList.add('d-none');
          searchInput.setAttribute('aria-expanded', 'false');
          currentResultIndex = -1;
        }
      }, 100);
    };

    searchInput.addEventListener('blur', handleBlur);

    // Add focus/blur handlers to clear button to maintain search widget focus state
    searchClear?.addEventListener('focus', () => {
      searchWidgetHasFocus = true;

      // Clear any pending blur timeout
      if (blurTimeout) {
        clearTimeout(blurTimeout);
        blurTimeout = null;
      }

      // Show results if they exist and input has value (re-focusing existing search)
      if (searchInput?.value && searchResults && searchResults.children.length > 0) {
        searchDropdown.classList.remove('d-none');
        searchInput.setAttribute('aria-expanded', 'true');
      }
    });

    searchClear?.addEventListener('blur', handleBlur);

    // Handle Tab navigation from search input to clear button
    searchInput.addEventListener('keydown', (e: KeyboardEvent) => {
      // Handle Tab key specifically for navigation to clear button
      if (e.key === 'Tab' && !e.shiftKey) {
        // If clear button is visible and there are search results, focus the clear button
        if (!searchClear?.classList.contains('d-none') && !searchDropdown?.classList.contains('d-none')) {
          e.preventDefault();
          searchClear?.focus();
          return;
        }
      }

      // Handle navigation keys immediately (arrows, enter, escape)
      if (['ArrowDown', 'ArrowUp', 'Enter', 'Escape'].includes(e.key)) {
        handleKeyboardNavigation(e);
        return;
      }

      // Ignore navigation keys that shouldn't trigger search
      if (['Tab', 'Shift', 'Control', 'Alt', 'Meta'].includes(e.key)) {
        return;
      }

      // Also ignore modifier key combinations
      if (e.ctrlKey || e.altKey || e.metaKey) {
        return;
      }

      // Debounce search functionality for typing
      debounce(async () => {
        if (!searchUrl) return;

        const products = await searchProduct(searchUrl, searchInput.value, 10);

        if (products.length > 0) {
          renderSearchResults(products);
          searchClear?.classList.remove('d-none');
          // Make clear button tabbable when search results are shown
          searchClear?.setAttribute('tabindex', '0');
          searchDropdown?.classList.remove('d-none');
          currentResultIndex = -1; // Reset navigation index

          // Update ARIA expanded state
          searchInput.setAttribute('aria-expanded', 'true');

          // Add keyboard navigation to result links and make them non-tabbable
          const resultLinks = searchResults.querySelectorAll<HTMLAnchorElement>(SearchBarMap.searchResultLink);
          resultLinks.forEach((link) => {
            link.setAttribute('role', 'option');
            link.setAttribute('aria-selected', 'false');
            link.setAttribute('tabindex', '-1'); // Remove from tab order - only accessible via arrows
            link.addEventListener('keydown', handleKeyboardNavigation);

            // Add focus/blur handlers to maintain search widget focus state
            link.addEventListener('focus', () => {
              searchWidgetHasFocus = true;
              // Clear any pending blur timeout
              if (blurTimeout) {
                clearTimeout(blurTimeout);
                blurTimeout = null;
              }
            });

            link.addEventListener('blur', handleBlur);
          });

          // Close dropdown when clicking outside
          window.addEventListener('click', (event: Event) => {
            const target = <Node>event.target;

            // Check if click is outside both the search widget and the dropdown
            if (!searchWidget.contains(target) && !searchDropdown.contains(target)) {
              searchDropdown.classList.add('d-none');
              searchInput.setAttribute('aria-expanded', 'false');
              currentResultIndex = -1;
              searchWidgetHasFocus = false;
            }
          });
        } else {
          searchResults.innerHTML = '';
          searchDropdown.classList.add('d-none');
          searchInput.setAttribute('aria-expanded', 'false');
          currentResultIndex = -1;
        }
      }, 250)();
    });
  }
};

export default initSearchbar;
