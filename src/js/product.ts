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

    const activeThumb = document.querySelector(SelectorsMap.product.activeThumbail(event.to));

    if (activeThumb) {
      const activeThumbRect = activeThumb.getBoundingClientRect();

      if (thumbnailsContainer) {
        const thumbContainerRect = thumbnailsContainer.getBoundingClientRect();
        const safetyZone = 20;

        if (
          (thumbContainerRect.bottom - safetyZone < activeThumbRect.top
          || thumbContainerRect.top + safetyZone > activeThumbRect.bottom)
          && !prestashop.responsive.mobile
        ) {
          thumbnailsContainer.scroll({
            left: thumbnailsContainer.scrollLeft + activeThumbRect.left - thumbContainerRect.left,
            top: thumbnailsContainer.scrollTop + activeThumbRect.top - thumbContainerRect.top,
            behavior: 'smooth',
          });
        }

        if (
          (thumbContainerRect.right - safetyZone < activeThumbRect.right
          || thumbContainerRect.left + safetyZone > activeThumbRect.left)
          && prestashop.responsive.mobile
        ) {
          thumbnailsContainer.scroll({
            left: thumbnailsContainer.scrollLeft + activeThumbRect.left - thumbContainerRect.left,
            top: thumbnailsContainer.scrollTop + activeThumbRect.top - thumbContainerRect.top,
            behavior: 'smooth',
          });
        }
      }
      activeThumb.classList.add('active');
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
