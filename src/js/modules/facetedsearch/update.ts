/**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
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
