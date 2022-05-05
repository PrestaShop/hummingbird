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

import SelectorsMap from './constants/selectors-map';

export default () => {
  const {prestashop} = window;

  const initProductSlide = () => {
    const imagesCarousel = document.querySelector(SelectorsMap.product.carousel);

    if (imagesCarousel) {
      imagesCarousel.addEventListener('slide.bs.carousel', onProductSlide);
    }
  };

  function onProductSlide(event: Event & {to: number}): void {
    const thumbnails = document.querySelectorAll(SelectorsMap.product.thumbnail);

    thumbnails.forEach((e: Element) => {
      e.classList.remove('active');
    });

    const activeThumbnail = document.querySelector(SelectorsMap.product.activeThumbail(event.to));

    if (activeThumbnail) {
      activeThumbnail.classList.add('active');
    }
  }

  initProductSlide();

  prestashop.on('updatedProduct', () => {
    initProductSlide();
  });

  prestashop.on('quickviewOpened', () => {
    initProductSlide();
  });
};
