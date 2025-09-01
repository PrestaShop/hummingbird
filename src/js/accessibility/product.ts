/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import {Carousel} from 'bootstrap';
import SelectorsMap from '../constants/selectors-map';

export default () => {
  const {prestashop, Theme: {events}} = window;

  // Product images sync on open/close modal
  document.addEventListener('show.bs.modal', (event) => {
    const modal = event.target as HTMLElement;

    if (!modal.matches(SelectorsMap.product.productImagesModal)) return;

    const modalCarouselElement = modal.querySelector(SelectorsMap.product.productImagesModalCarousel);
    const mainCarouselElement = document.querySelector(SelectorsMap.product.carousel);

    if (!modalCarouselElement || !mainCarouselElement) return;

    const modalCarousel = Carousel.getOrCreateInstance(modalCarouselElement as HTMLElement);
    const activeIndex = getActiveSlideIndex(mainCarouselElement as HTMLElement);

    if (activeIndex !== -1) {
      modalCarousel.to(activeIndex);
    }
  });

  document.addEventListener('hide.bs.modal', (event) => {
    const modal = event.target as HTMLElement;

    if (!modal.matches(SelectorsMap.product.productImagesModal)) return;

    const modalCarouselElement = modal.querySelector(SelectorsMap.product.productImagesModalCarousel);
    const mainCarouselElement = document.querySelector(SelectorsMap.product.carousel);

    if (!modalCarouselElement || !mainCarouselElement) return;

    const mainCarousel = Carousel.getOrCreateInstance(mainCarouselElement as HTMLElement);
    const activeIndex = getActiveSlideIndex(modalCarouselElement as HTMLElement);

    if (activeIndex !== -1) {
      mainCarousel.to(activeIndex);
    }
  });

  const getActiveSlideIndex = (carouselEl: HTMLElement): number => {
    const items = carouselEl.querySelectorAll('.carousel-item');

    return Array.from(items).findIndex((item) => item.classList.contains('active'));
  };

  // Stores the element to refocus, per context ("main" or "quickview")
  const focusMap = new Map<'quickview' | 'main', { id: string }>();

  // Save the element before the update
  prestashop.on(events.updateProduct, ({ event }: { event: Event }) => {
    const target = event?.target as HTMLElement;
    if (!target || !target.id) return;

    const isInQuickView = !!target.closest(SelectorsMap.quickviewModal);
    const context: 'quickview' | 'main' = isInQuickView ? 'quickview' : 'main';

    focusMap.set(context, { id: target.id });
  });

  // Restore focus after update
  prestashop.on(events.updatedProduct, () => {
    focusMap.forEach((focusData, context) => {
      let container: HTMLElement | null = null;

      if (context === 'quickview') {
        container = document.querySelector(SelectorsMap.quickviewModal);
      } else {
        container = document.querySelector(SelectorsMap.product.container);
      }
    
      if (!container) return;
    
      const elementToFocus = container.querySelector<HTMLElement>(`#${focusData.id}`);

      if (elementToFocus) {
        elementToFocus.focus();

        // Emit event to when the focus is restored
        prestashop.emit(events.combinationFocusRestored, {
          context,
          elementId: focusData.id
        });
      }

      focusMap.delete(context);
    });
  });

  // Product availability messages announcement
  prestashop.on(events.combinationFocusRestored, ({ context }: { context: 'quickview' | 'main' }) => {
    let container: HTMLElement | null = null;

    // Get the container of the context
    if (context === 'quickview') {
      container = document.querySelector(SelectorsMap.quickviewModal);
    } else {
      container = document.querySelector(SelectorsMap.product.container);
    }

    if (!container) return;

    const productAvailabilityElement = container.querySelector(SelectorsMap.product.productAvailability);

    if (!productAvailabilityElement) return;

    // Delay to ensure focus announcement finishes first
    setTimeout(() => {
      productAvailabilityElement.setAttribute('aria-live', 'polite');
    }, 250);
  });
};
