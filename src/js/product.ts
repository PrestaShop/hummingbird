/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import SelectorsMap from './constants/selectors-map';

type ProductSlideEvent = Event & {to: number};

export default () => {
  const {prestashop, Theme: {events}} = window;

  const initProductSlide = () => {
    const imagesCarousel = document.querySelector(SelectorsMap.product.carousel);

    if (imagesCarousel) {
      imagesCarousel.addEventListener('slide.bs.carousel', onProductSlide);
    }
  };

  function onProductSlide(event: ProductSlideEvent): void {
    const thumbnails = document.querySelectorAll(SelectorsMap.product.thumbnail);
    const thumbnailsContainer = document.querySelector(SelectorsMap.product.thumbnailsContainer);

    thumbnails.forEach((e: Element) => {
      e.classList.remove('active');
    });

    const activeThumbnail = document.querySelector(SelectorsMap.product.activeThumbail(event.to));

    if (activeThumbnail) {
      const activeThumbailRect = activeThumbnail.getBoundingClientRect();

      if (thumbnailsContainer) {
        const thumbnailsContainerRect = thumbnailsContainer.getBoundingClientRect();
        const safetyZone = 20;

        if (
          (thumbnailsContainerRect.bottom - safetyZone < activeThumbailRect.top
          || thumbnailsContainerRect.top + safetyZone > activeThumbailRect.bottom)
          && !prestashop.responsive.mobile
        ) {
          thumbnailsContainer.scroll({
            left: thumbnailsContainer.scrollLeft + activeThumbailRect.left - thumbnailsContainerRect.left,
            top: thumbnailsContainer.scrollTop + activeThumbailRect.top - thumbnailsContainerRect.top,
            behavior: 'smooth',
          });
        }

        if (
          (thumbnailsContainerRect.right - safetyZone < activeThumbailRect.right
          || thumbnailsContainerRect.left + safetyZone > activeThumbailRect.left)
          && prestashop.responsive.mobile
        ) {
          thumbnailsContainer.scroll({
            left: thumbnailsContainer.scrollLeft + activeThumbailRect.left - thumbnailsContainerRect.left,
            top: thumbnailsContainer.scrollTop + activeThumbailRect.top - thumbnailsContainerRect.top,
            behavior: 'smooth',
          });
        }
      }
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
