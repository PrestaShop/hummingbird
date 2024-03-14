/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import useQuantityInput, {populateMinQuantityInput} from '@js/components/useQuantityInput';

// @TODO(NeOMakinG): Refactor this file, it comes from facetedsearch or classic
export const parseSearchUrl = function (event: {target: HTMLElement}) {
  if (event.target.dataset.searchUrl !== undefined) {
    return event.target.dataset.searchUrl;
  }

  if ($(event.target).parent()[0].dataset.searchUrl === undefined) {
    throw new Error('Can not parse search URL');
  }

  return $(event.target).parent()[0].dataset.searchUrl;
};

export function updateProductListDOM(data: Record<string, never>) {
  const {Theme} = window;

  $(Theme.selectors.listing.searchFilters).replaceWith(
    data.rendered_facets,
  );
  $(Theme.selectors.listing.activeSearchFilters).replaceWith(
    data.rendered_active_filters,
  );
  $(Theme.selectors.listing.listTop).replaceWith(
    data.rendered_products_top,
  );

  const renderedProducts = $(data.rendered_products);
  const productSelectors = $(Theme.selectors.listing.product, renderedProducts);
  const firstProductClasses = $(Theme.selectors.listing.product).first().attr('class');

  if (productSelectors.length > 0 && firstProductClasses) {
    productSelectors.removeClass().addClass(firstProductClasses);
  }

  $(Theme.selectors.listing.list).replaceWith(renderedProducts);

  $(Theme.selectors.listing.listBottom).replaceWith(
    data.rendered_products_bottom,
  );
  if (data.rendered_products_header) {
    $(Theme.selectors.listing.listHeader).replaceWith(
      data.rendered_products_header,
    );
  }
}

export default () => {
  const {prestashop} = window;
  const {Theme} = window;
  const {events} = Theme;

  $('body').on(
    'change',
    `${Theme.selectors.listing.searchFilters} input[data-search-url]`,
    (event) => {
      prestashop.emit(events.updateFacets, parseSearchUrl(event));
    },
  );

  $('body').on(
    'click',
    Theme.selectors.listing.searchFiltersClearAll,
    (event) => {
      prestashop.emit(events.updateFacets, parseSearchUrl(event));
    },
  );

  $('body').on('click', Theme.selectors.listing.searchLink, (event) => {
    event.preventDefault();
    prestashop.emit(
      events.updateFacets,
      $(event.target)?.closest('a')?.get(0)?.getAttribute('href'),
    );
  });

  /**
   * Pager links also scroll up
   */
  $('body').on('click', Theme.selectors.listing.pagerLink, (event) => {
    event.preventDefault();
    document.querySelector(Theme.selectors.listing.listTop)?.scrollIntoView({block: 'start', behavior: 'auto'});
    prestashop.emit(
      events.updateFacets,
      $(event.target)?.closest('a')?.get(0)?.getAttribute('href'),
    );
  });

  if ($(Theme.selectors.listing.list).length) {
    window.addEventListener('popstate', (e) => {
      const {state} = e;
      window.location.href = state && state.current_url ? state.current_url : history;
    });
  }

  $('body').on(
    'change',
    `${Theme.selectors.listing.searchFilters} select`,
    (event) => {
      const form = $(event.target).closest('form');
      prestashop.emit(events.updateFacets, `?${form.serialize()}`);
    },
  );

  prestashop.on(events.updateProductList, (data: Record<string, never>) => {
    updateProductListDOM(data);
    useQuantityInput();
    populateMinQuantityInput();
  });
};
