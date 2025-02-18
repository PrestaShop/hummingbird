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

  // Show clear button when input has value
  searchInput?.addEventListener('focus', () => {
    if (searchInput?.value) {
      searchClear?.classList.remove('d-none');
    }
  });

  // Reset search on mobile canvas close
  searchCanvas?.addEventListener('hidden.bs.offcanvas', () => {
    if (searchDropdown && searchResults) {
      searchResults.innerHTML = '';
      searchDropdown.classList.add('d-none');
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

    // Handle search input with debounce
    searchInput.addEventListener('keydown', debounce(async () => {
      if (!searchUrl) return;

      const products = await searchProduct(searchUrl, searchInput.value, 10);

      if (products.length > 0) {
        renderSearchResults(products);
        searchClear?.classList.remove('d-none');
        searchDropdown?.classList.remove('d-none');

        // Close dropdown when clicking outside
        window.addEventListener('click', (e: Event) => {
          if (!searchWidget.contains(<Node>e.target)) {
            searchDropdown.classList.add('d-none');
          }
        });
      } else {
        searchResults.innerHTML = '';
        searchDropdown.classList.add('d-none');
      }
    }, 250));
  }
};

export default initSearchbar;
