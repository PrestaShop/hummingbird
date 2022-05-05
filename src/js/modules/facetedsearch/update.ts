/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

const {prestashop} = window;

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
  $(prestashop.themeSelectors.listing.searchFilters).replaceWith(
    data.rendered_facets,
  );
  $(prestashop.themeSelectors.listing.activeSearchFilters).replaceWith(
    data.rendered_active_filters,
  );
  $(prestashop.themeSelectors.listing.listTop).replaceWith(
    data.rendered_products_top,
  );

  const renderedProducts = $(data.rendered_products);
  const productSelectors = $(prestashop.themeSelectors.listing.product, renderedProducts);
  const firstProductClasses = $(prestashop.themeSelectors.listing.product).first().attr('class');

  if (productSelectors.length > 0 && firstProductClasses) {
    productSelectors.removeClass().addClass(firstProductClasses);
  }

  $(prestashop.themeSelectors.listing.list).replaceWith(renderedProducts);

  $(prestashop.themeSelectors.listing.listBottom).replaceWith(
    data.rendered_products_bottom,
  );
  if (data.rendered_products_header) {
    $(prestashop.themeSelectors.listing.listHeader).replaceWith(
      data.rendered_products_header,
    );
  }
}

export default () => {
  $('body').on(
    'change',
    `${prestashop.themeSelectors.listing.searchFilters} input[data-search-url]`,
    (event) => {
      prestashop.emit('updateFacets', parseSearchUrl(event));
    },
  );

  $('body').on(
    'click',
    prestashop.themeSelectors.listing.searchFiltersClearAll,
    (event) => {
      prestashop.emit('updateFacets', parseSearchUrl(event));
    },
  );

  $('body').on('click', prestashop.themeSelectors.listing.searchLink, (event) => {
    event.preventDefault();
    prestashop.emit(
      'updateFacets',
      $(event.target)?.closest('a')?.get(0)?.getAttribute('href'),
    );
  });

  if ($(prestashop.themeSelectors.listing.list).length) {
    window.addEventListener('popstate', (e) => {
      const {state} = e;
      window.location.href = state && state.current_url ? state.current_url : history;
    });
  }

  $('body').on(
    'change',
    `${prestashop.themeSelectors.listing.searchFilters} select`,
    (event) => {
      const form = $(event.target).closest('form');
      prestashop.emit('updateFacets', `?${form.serialize()}`);
    },
  );

  prestashop.on('updateProductList', (data: Record<string, never>) => {
    updateProductListDOM(data);
    window.scrollTo(0, 0);
  });
};
