/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import useQuantityInput, {populateMinQuantityInput} from '@js/components/useQuantityInput';

export const parseSearchUrl = (event: Event): string => {
  const target = (event.target as HTMLElement).closest<HTMLElement>('[data-search-url]');
  const url = target?.dataset.searchUrl;

  if (!url) {
    throw new Error('Cannot parse search URL');
  }
  return url;
};

export function updateProductListDOM(data: Record<string, unknown>): void {
  const {Theme} = window;
  const {listing} = Theme.selectors;

  const replace = (selector: string, html: string | undefined) => {
    const element = document.querySelector(selector);

    if (!element) {
      throw new Error(`Cannot find element with selector "${selector}".`);
    }
    if (!html) {
      throw new Error(`No HTML content provided to be replaced in element "${selector}".`);
    }

    const tmpWrapper = document.createElement('div');
    tmpWrapper.innerHTML = html;
    const newElement = tmpWrapper.firstElementChild as HTMLElement;
    element.replaceWith(newElement);
  };

  replace(listing.searchFilters, data.rendered_facets as string);
  replace(listing.activeSearchFilters, data.rendered_active_filters as string);
  replace(listing.listTop, data.rendered_products_top as string);
  replace(listing.list, data.rendered_products as string);
  replace(listing.listBottom, data.rendered_products_bottom as string);
  replace(listing.listHeader, data.rendered_products_header as string);
  replace(listing.listFooter, data.rendered_products_footer as string);
}

export default function initFacetedSearch(): void {
  const {prestashop} = window;
  const {Theme} = window;
  const {events, selectors} = Theme;
  const {listing} = selectors;

  const emitUpdate = (url: string) => prestashop.emit(events.updateFacets, url);

  // Delegate change events
  document.body.addEventListener('change', (e) => {
    const target = e.target as HTMLElement;

    if (target.matches(`${listing.searchFilters} input[data-search-url]`)) {
      emitUpdate(parseSearchUrl(e));
    }
  });

  // Delegate click events
  document.body.addEventListener('click', (e) => {
    const target = e.target as HTMLElement;

    if (target.matches(listing.searchFiltersClearAll)) {
      // Clear all filters
      emitUpdate(parseSearchUrl(e));
    } else if (target.matches(listing.searchLink) || target.closest(listing.searchLink)) {
      // Search links
      e.preventDefault();
      const a = target.closest('a');
      const href = a?.getAttribute('href');

      if (href) {
        emitUpdate(href);
      }
    } else if (target.matches(listing.pagerLink) || target.closest(listing.pagerLink)) {
      // Pager links
      e.preventDefault();
      document
        .querySelector(listing.listHeader)
        ?.scrollIntoView({block: 'start', behavior: 'auto'});
      const a = target.closest('a');
      const href = a?.getAttribute('href');

      if (href) {
        emitUpdate(href);
      }
    }
  });

  // popstate handling to sync faceted URL
  if (document.querySelector(listing.list)) {
    window.addEventListener('popstate', (e: PopStateEvent) => {
      const state = e.state as { current_url?: string } | null;

      if (state?.current_url) {
        window.location.href = state.current_url;
      } else {
        window.location.reload();
      }
    });
  }

  // Listen for Prestashop’s AJAX product-list update
  prestashop.on(events.updateProductList, (data: Record<string, unknown>) => {
    updateProductListDOM(data);
    useQuantityInput();
    populateMinQuantityInput();
  });
}
