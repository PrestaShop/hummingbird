/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */

import initScrollPaddingTop from '@helpers/scrollPadding';

describe('scrollPadding', () => {
  beforeEach(() => {
    jest.useFakeTimers();
    document.body.innerHTML = '<header data-ps-ref="header"></header>';
  });

  afterEach(() => {
    jest.useRealTimers();
    jest.restoreAllMocks();
    document.body.innerHTML = '';
  });

  it('debounces the resize handler so it runs once per settle instead of once per event', () => {
    const setPropertySpy = jest.spyOn(document.documentElement.style, 'setProperty');

    initScrollPaddingTop();

    window.dispatchEvent(new Event('resize'));
    window.dispatchEvent(new Event('resize'));
    window.dispatchEvent(new Event('resize'));

    // Debounced: no forced reflow / style write has happened yet.
    expect(setPropertySpy).not.toHaveBeenCalled();

    jest.advanceTimersByTime(100);

    // setScrollPaddingTop() ran exactly once (it sets two custom properties), not once per event.
    expect(setPropertySpy).toHaveBeenCalledTimes(2);
  });
});
