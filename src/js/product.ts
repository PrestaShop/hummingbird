/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import SelectorsMap from './constants/selectors-map';

export default () => {
  const {prestashop, Theme: {events}} = window;

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

  prestashop.on(events.updatedProduct, () => {
    initProductSlide();
  });

  prestashop.on(events.quickviewOpened, () => {
    initProductSlide();
  });
};
