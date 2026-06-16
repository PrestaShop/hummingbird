/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */

import SelectorsMap from '@constants/selectors-map';

const setScrollPaddingTop = () => {
  const header = document.querySelector(SelectorsMap.layout.header) as HTMLElement;

  if (header) {
    const headerHeight = header.offsetHeight;
    const offset = 16;
    document.documentElement.style.setProperty('--scroll-padding-top', `${headerHeight + offset}px`);
    document.documentElement.style.setProperty('scroll-padding-top', 'var(--scroll-padding-top)');
  }
};

// Disable while a header control is focused to stop browser scrolling the page to top.
const suspendScrollPadding = () => {
  document.documentElement.style.setProperty('scroll-padding-top', '0px');
};

// Restore after a suspend.
const restoreScrollPadding = () => {
  document.documentElement.style.setProperty('scroll-padding-top', 'var(--scroll-padding-top)');
};

// Suspend while focus is inside the header, restore once it leaves.
const bindHeaderFocus = () => {
  const header = document.querySelector(SelectorsMap.layout.header) as HTMLElement;

  if (!header) return;

  header.addEventListener('focusin', suspendScrollPadding);
  header.addEventListener('focusout', (e: FocusEvent) => {
    if (!header.contains(e.relatedTarget as Node)) {
      restoreScrollPadding();
    }
  });
};

const initScrollPaddingTop = () => {
  window.addEventListener('load', () => {
    setScrollPaddingTop();
    bindHeaderFocus();
  });
  window.addEventListener('resize', setScrollPaddingTop);
};

export default initScrollPaddingTop;
