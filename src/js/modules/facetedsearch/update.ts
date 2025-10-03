/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import useQuantityInput, {populateMinQuantityInput} from '@js/components/useQuantityInput';

export const parseSearchUrl = (event: Event): string => {
  const target = (event.target as HTMLElement).closest<HTMLElement>('[data-search-url]');
  const url = target?.dataset.searchUrl;

  if (!url) {
    console.error('No data-search-url found for event:', event);
    throw new Error('Cannot parse search URL');
  }
  return url;
};

export function updateProductListDOM(data: Record<string, unknown>): void {
  const {Theme} = window;
  const {listing} = Theme.selectors;

  const replace = (selector: string, html: string): void => {
    const element = document.querySelector<HTMLElement>(selector);

    if (!element || !html) return;

    const template = document.createElement('template');
    template.innerHTML = html.trim();

    const newElement = template.content.firstElementChild as HTMLElement | null;

    if (newElement) {
      element.replaceWith(newElement);
    }
  };

  replace(listing.searchFilters, data.rendered_facets as string);
  replace(listing.activeSearchFilters, data.rendered_active_filters as string);
  replace(listing.listTop, data.rendered_products_top as string);
  replace(listing.list, data.rendered_products as string);
  replace(listing.listBottom, data.rendered_products_bottom as string);
  replace(listing.listHeader, data.rendered_products_header as string);
  replace(listing.listFooter, data.rendered_products_footer as string);
}

function getHrefFromTarget(target: HTMLElement, selector: string): string | null {
  const link = target.closest(selector)?.getAttribute('href');

  return link || null;
}

export default function initFacetedSearch(): void {
  const {prestashop} = window;
  const {Theme} = window;
  const {events, selectors} = Theme;
  const {listing} = selectors;

  const emitUpdate = (url: string) => prestashop.emit(events.updateFacets, url);

  // Delegate change events
  document.body.addEventListener('change', (event) => {
    const target = event.target as HTMLElement;

    if (target.closest(`${listing.searchFilters} input[data-search-url]`)) {
      emitUpdate(parseSearchUrl(event));
    }
  });

  // Delegate click events
  document.body.addEventListener('click', (event) => {
    const target = event.target as HTMLElement;

    if (target.closest(listing.searchFiltersClearAll)) {
      // Clear all filters
      emitUpdate(parseSearchUrl(event));
    } else if (target.closest(listing.searchLink)) {
      // Click on a facet filter link to trigger filtering
      event.preventDefault();

      const href = getHrefFromTarget(target, 'a');

      if (!href) {
        console.error(`Cannot find href attribute for the element ${listing.searchLink}`);

        return;
      }

      emitUpdate(href);
    } else if (target.closest(listing.paginationLink)) {
      // Pagination link
      event.preventDefault();

      const listHeader = document.querySelector(listing.listHeader);

      if (listHeader) {
        listHeader.scrollIntoView({block: 'start', behavior: 'auto'});
      }

      const href = (event.target as HTMLElement).closest('button')?.getAttribute('data-ps-data');

      if (!href) {
        console.error(`Cannot find href attribute for the element ${listing.paginationLink}`);
        return;
      }

      emitUpdate(href);
    }
  });

  // Popstate handling to sync faceted URL
  if (document.querySelector(listing.list)) {
    window.addEventListener('popstate', (event: PopStateEvent) => {
      const state = event.state as { current_url: string } | null;

      if (state?.current_url && state.current_url.trim() !== '' && state.current_url !== '#') {
        window.location.href = state.current_url;
      }
    });
  }

  // Listen for Prestashop’s AJAX product-list update
  prestashop.on(events.updateProductList, (data: Record<string, unknown>) => {
    updateProductListDOM(data);
    useQuantityInput();
    populateMinQuantityInput();
  });

  // Listen for color label space key press
  document.body.addEventListener('keydown', (event: KeyboardEvent) => {
    const target = event.target as HTMLElement;

    if (target.closest(selectors.facetedsearch.colorLabel)) {
      if (event.key === ' ') {
        event.preventDefault();

        const label = target.closest(selectors.facetedsearch.colorLabel);
        const input = document.getElementById(label.getAttribute('for'));

        if (input) {
          input.click();
        }
      }
    }
  });
}
