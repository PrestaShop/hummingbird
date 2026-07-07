/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */

import {Carousel} from 'bootstrap';
import SelectorsMap from '@constants/selectors-map';

// Below the `lg` breakpoint (Bootstrap: < 992px) touch users cannot hover to pause the
// carousel, so the homepage slider should not auto-rotate on mobile even when a speed is
// configured. `data-bs-ride="carousel"` is honoured by Bootstrap on every viewport, so the
// autoplay is paused/resumed here as the viewport crosses the breakpoint.
const MOBILE_BREAKPOINT = '(max-width: 991.98px)';

const applyAutoplayPolicy = (carousel: Carousel, isMobile: boolean): void => {
  if (isMobile) {
    carousel.pause();
  } else {
    carousel.cycle();
  }
};

const initImageslider = (): void => {
  const slider = document.querySelector<HTMLElement>(SelectorsMap.imageslider.autoRotating);

  if (!slider) {
    return;
  }

  const carousel = Carousel.getOrCreateInstance(slider);
  const mediaQuery = window.matchMedia(MOBILE_BREAKPOINT);

  applyAutoplayPolicy(carousel, mediaQuery.matches);
  mediaQuery.addEventListener('change', (event) => applyAutoplayPolicy(carousel, event.matches));
};

export default initImageslider;
