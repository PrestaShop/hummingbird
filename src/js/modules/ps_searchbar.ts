/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import {searchProduct, Result} from '@services/search';
import debounce from '@helpers/debounce';

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
  };

  searchClear?.addEventListener('click', clearSearch);

  // Add keyboard support for clear button
  searchClear?.addEventListener('keydown', (e: KeyboardEvent) => {
    if (e.key === 'Enter' || e.key === ' ') {
      e.preventDefault();
      clearSearch();
    }
  });

  // Show clear button when input has value
  searchInput?.addEventListener('focus', () => {
    if (searchInput?.value) {
      searchClear?.classList.remove('d-none');
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
            productTitle.innerHTML = product.name;

            if (product.cover) {
              productImage.src = product.cover.small.url;
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
      const resultElements = searchResults.querySelectorAll<HTMLAnchorElement>('.ps-searchbar__result-link');

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
        } else {
          element.setAttribute('aria-selected', 'false');
        }
      });
    };

    // Handle search input with debounce and keyboard navigation
    searchInput.addEventListener('keydown', (e: KeyboardEvent) => {
      // Handle navigation keys immediately
      if (['ArrowDown', 'ArrowUp', 'Enter', 'Escape'].includes(e.key)) {
        handleKeyboardNavigation(e);
        return;
      }

      // Debounce search functionality for typing
      debounce(async () => {
        if (!searchUrl) return;

        const products = await searchProduct(searchUrl, searchInput.value, 10);

        if (products.length > 0) {
          renderSearchResults(products);
          searchClear?.classList.remove('d-none');
          searchDropdown?.classList.remove('d-none');
          currentResultIndex = -1; // Reset navigation index

          // Update ARIA expanded state
          searchInput.setAttribute('aria-expanded', 'true');

          // Add keyboard navigation to result links
          const resultLinks = searchResults.querySelectorAll<HTMLAnchorElement>('.ps-searchbar__result-link');
          resultLinks.forEach((link) => {
            link.setAttribute('role', 'option');
            link.setAttribute('aria-selected', 'false');
            link.addEventListener('keydown', handleKeyboardNavigation);
          });

          // Close dropdown when clicking outside
          window.addEventListener('click', (event: Event) => {
            if (!searchWidget.contains(<Node>event.target)) {
              searchDropdown.classList.add('d-none');
              searchInput.setAttribute('aria-expanded', 'false');
              currentResultIndex = -1;
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
