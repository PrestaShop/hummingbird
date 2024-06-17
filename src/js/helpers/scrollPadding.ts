/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import SelectorsMap from '@constants/selectors-map';

const setScrollPaddingTop = () => {
  const header = document.querySelector(SelectorsMap.layout.stickyHeader) as HTMLElement;

  if (header) {
    const headerHeight = header.offsetHeight;
    document.documentElement.style.setProperty('scroll-padding-top', `${headerHeight}px`);
  }
};

const initScrollPaddingTop = () => {
  window.addEventListener('load', setScrollPaddingTop);
  window.addEventListener('resize', setScrollPaddingTop);
};

export default initScrollPaddingTop;
