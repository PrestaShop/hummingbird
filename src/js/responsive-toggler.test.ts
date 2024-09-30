import EVENTS from '@js/constants/events-map';
import selectorsMap from '@constants/selectors-map';
import initResponsiveToggler from './responsive-toggler';
import initEmitter from './prestashop';
import {
  desktopElement, mobileElement, mobileElementId, contentValue, desktopElementId,
} from './constants/mocks/swapElements-data';

beforeAll(() => {
  document.body.innerHTML = `
    ${desktopElement}
    ${mobileElement}
  `;

  window.prestashop = {
    responsive: {},
  };

  window.Theme = {
    ...window.Theme,
    events: EVENTS,
    selectors: selectorsMap,
  };

  initEmitter();

  initResponsiveToggler();
});

describe('Responsive Toggler', () => {
  it('should switch desktop to mobile elements if screen width < 768', () => {
    Object.defineProperty(window, 'innerWidth', {writable: true, configurable: true, value: 320});
    window.dispatchEvent(new window.Event('resize'));
    const mobileDomElement = document.querySelector(`#${mobileElementId}`) as HTMLElement;

    expect(mobileDomElement.innerHTML).toEqual(contentValue);
  });

  it('should switch mobile to desktop element if screen width > 768', () => {
    Object.defineProperty(window, 'innerWidth', {writable: true, configurable: true, value: 1920});
    window.dispatchEvent(new window.Event('resize'));
    const desktopDomElement = document.querySelector(`#${desktopElementId}`) as HTMLElement;

    expect(desktopDomElement.innerHTML).toEqual(contentValue);
  });
});
