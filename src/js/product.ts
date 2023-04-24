/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import SelectorsMap from './constants/selectors-map';

type ProductSlideEvent = Event & {to: number};

export default () => {
  const {prestashop, Theme: {events}} = window;

  const initProductSlide = () => {
    document.querySelector(SelectorsMap.product.carousel)?.addEventListener('slide.bs.carousel', onProductSlide);
  };

  function onProductSlide(event: ProductSlideEvent): void {
    document.querySelectorAll(SelectorsMap.product.thumbnail).forEach((e) => e.classList.remove('active'));
    document.querySelector(SelectorsMap.product.activeThumbail(event.to))?.classList.add('active');
  }

  initProductSlide();
  prestashop.on(events.updatedProduct, initProductSlide);
  prestashop.on(events.quickviewOpened, initProductSlide);
};
