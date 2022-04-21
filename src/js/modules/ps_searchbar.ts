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

import {searchProduct, Result} from '@services/search';
import debounce from '@helpers/debounce';

const initSearchbar = () => {
  const {prestashop} = window;
  const {searchBar: SearchBarMap} = prestashop.themeSelectors;

  const searchCanvas = document.querySelector<HTMLElement>(SearchBarMap.searchCanvas);
  const searchWidget = document.querySelector<HTMLElement>(SearchBarMap.searchWidget);
  const searchDropdown = document.querySelector<HTMLElement>(SearchBarMap.searchDropdown);
  const searchResults = document.querySelector<HTMLElement>(SearchBarMap.searchResults);
  const searchTemplate = document.querySelector<HTMLTemplateElement>(SearchBarMap.searchTemplate);
  const searchInput = document.querySelector<HTMLInputElement>(SearchBarMap.searchInput);
  const searchUrl = searchWidget?.dataset.searchControllerUrl;

  searchCanvas?.addEventListener('hidden.bs.offcanvas', () => {
    if (searchDropdown) {
      searchDropdown.innerHTML = '';
      searchDropdown.classList.add('d-none');
    }
  });

  if (searchWidget && searchInput && searchResults && searchDropdown) {
    searchInput.addEventListener('keydown', debounce(async () => {
      if (searchUrl) {
        const products = await searchProduct(searchUrl, searchInput.value, 10);

        if (products.length > 0) {
          products.forEach((e: Result) => {
            const product = <HTMLElement>searchTemplate?.content.cloneNode(true);

            if (product) {
              const productLink = product.querySelector<HTMLAnchorElement>('a');
              const productTitle = product.querySelector<HTMLElement>('p');
              const productImage = product.querySelector<HTMLImageElement>('img');

              if (productLink && productTitle && productImage) {
                productLink.href = e.canonical_url;
                productTitle.innerHTML = e.name;

                if (!e.cover) {
                  productImage.innerHTML = '';
                } else {
                  productImage.src = e.cover.small.url;
                }

                searchResults.append(product);
              }
            }
          });

          searchDropdown.classList.remove('d-none');

          window.addEventListener('click', (e: Event) => {
            if (!searchWidget.contains(<Node>e.target)) {
              searchDropdown.classList.add('d-none');
            }
          });
        } else {
          searchResults.innerHTML = '';
          searchDropdown.classList.add('d-none');
        }
      }
    }, 250));
  }
};

export default initSearchbar;
