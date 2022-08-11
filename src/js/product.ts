/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import SelectorsMap from './constants/selectors-map';

type ProductSlideEvent = Event & {to: number};

const initProductBehavior = () => {
  const {prestashop, Theme: {events}} = window;

  const initProductSlide = () => {
    const imagesCarousel = document.querySelector(SelectorsMap.product.carousel);

    if (imagesCarousel) {
      imagesCarousel.addEventListener('slide.bs.carousel', onProductSlide);
    }
  };

  function onProductSlide(event: ProductSlideEvent): void {
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

$(() => {
  initProductBehavior();
});

window.Theme.default = {
  ...window.Theme.default,
  initProductBehavior,
};
