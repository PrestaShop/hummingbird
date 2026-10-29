/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */

import SelectorsMap from '@constants/selectors-map';

type ProductSlideEvent = Event & {to: number};

export default () => {
  const {prestashop, Theme: {events}} = window;

  const initProductSlide = () => {
    document.querySelectorAll(SelectorsMap.product.carousel)?.forEach((carousel) => {
      carousel.addEventListener('slide.bs.carousel', onProductSlide);
    });
  };

  function onProductSlide(event: ProductSlideEvent): void {
    const carousel = event.target as HTMLElement;
    const parent = carousel.closest(SelectorsMap.product.images);

    if (parent) {
      parent.querySelectorAll(SelectorsMap.product.thumbnail).forEach((e) => e.classList.remove('active'));
      parent.querySelector(SelectorsMap.product.activeThumbail(event.to))?.classList.add('active');
    }
  }

  initProductSlide();
  prestashop.on(events.updatedProduct, initProductSlide);
  prestashop.on(events.quickviewOpened, initProductSlide);
};
