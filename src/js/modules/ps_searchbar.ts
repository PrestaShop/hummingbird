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

import search from '@services/search';
import debounce from '@helpers/debounce';

const initSearchbar = () => {
  const searchCanvas = <HTMLElement>document.querySelector('.js-search-offcanvas');
  const searchWidget = <HTMLElement>document.querySelector('.js-search-widget');
  const searchDropdown = <HTMLElement>document.querySelector('.js-search-dropdown');
  const searchResults = <HTMLElement>document.querySelector('.js-search-results');
  const searchTemplate = <HTMLTemplateElement>document.querySelector('.js-search-template');
  const searchInput: HTMLInputElement | null = document.querySelector('.js-search-input');
  const searchUrl = <string>searchWidget.dataset.searchControllerUrl;

  searchCanvas.addEventListener('hidden.bs.offcanvas', function () {
    searchDropdown.innerHTML = '';
    searchDropdown.classList.add('d-none')
  })

  if(searchInput) {
    searchInput.addEventListener('keydown', debounce(async () => {
      const products = await search(searchUrl, searchInput.value, 10);
      if(products.length > 0) {
        products.forEach((e: Record<string, any>) => {
          const product = <HTMLElement>searchTemplate.content.cloneNode(true);
          const productLink = <HTMLAnchorElement>product.querySelector('a');
          const productTitle = <HTMLElement>product.querySelector('p');
          const productImage = <HTMLImageElement>product.querySelector('img');
          productLink.href = e.canonical_url;
          productTitle.innerHTML = e.name;
          productImage.src = e.cover.small.url;

          searchResults.append(product);
        })

        searchDropdown.classList.remove('d-none')
      }else {
        searchResults.innerHTML = '';
        searchDropdown.classList.add('d-none')
      }
    }, 250))
  }
};

document.addEventListener('DOMContentLoaded', () => {
  initSearchbar();

  prestashop.on('responsive update', () => {
    initSearchbar();
  });
});

export default initSearchbar;
