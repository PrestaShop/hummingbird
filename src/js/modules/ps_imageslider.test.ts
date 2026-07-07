/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */

import {Carousel} from 'bootstrap';
import initImageslider from '@js/modules/ps_imageslider';

jest.mock('bootstrap');

const pause = jest.fn();
const cycle = jest.fn();

type MediaListener = (event: {matches: boolean}) => void;

const mockMatchMedia = (matches: boolean) => {
  const listeners: MediaListener[] = [];
  const mediaQueryList = {
    matches,
    addEventListener: (_: string, callback: MediaListener) => listeners.push(callback),
    dispatch: (newMatches: boolean) => listeners.forEach((callback) => callback({matches: newMatches})),
  };

  Object.defineProperty(window, 'matchMedia', {
    writable: true,
    configurable: true,
    value: () => mediaQueryList,
  });

  return mediaQueryList;
};

describe('ps_imageslider autoplay policy', () => {
  beforeEach(() => {
    jest.clearAllMocks();
    (Carousel.getOrCreateInstance as jest.Mock).mockReturnValue({pause, cycle});
    document.body.innerHTML = '<div id="ps_imageslider" class="carousel slide" data-bs-ride="carousel"></div>';
  });

  it('pauses the slider on mobile viewports', () => {
    mockMatchMedia(true);

    initImageslider();

    expect(pause).toHaveBeenCalledTimes(1);
    expect(cycle).not.toHaveBeenCalled();
  });

  it('lets the slider auto-rotate on desktop viewports', () => {
    mockMatchMedia(false);

    initImageslider();

    expect(cycle).toHaveBeenCalledTimes(1);
    expect(pause).not.toHaveBeenCalled();
  });

  it('re-applies the policy when the viewport crosses the breakpoint', () => {
    const mediaQueryList = mockMatchMedia(false);

    initImageslider();
    expect(cycle).toHaveBeenCalledTimes(1);

    mediaQueryList.dispatch(true);
    expect(pause).toHaveBeenCalledTimes(1);
  });

  it('does nothing when the slider is not configured to auto-rotate', () => {
    mockMatchMedia(true);
    document.body.innerHTML = '<div id="ps_imageslider" class="carousel slide"></div>';

    initImageslider();

    expect(pause).not.toHaveBeenCalled();
    expect(cycle).not.toHaveBeenCalled();
  });
});
