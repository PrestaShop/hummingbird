import initResponsiveToggler from './responsive-toggler';
import initEmitter from './prestashop';
import {
  desktopElement, mobileElement, mobileElementId, contentValue, desktopElementId,
} from './constants/mocks/swapElements-data';

describe('Responsive Toggler', () => {
  beforeAll(() => {
    document.body.innerHTML = `
      ${desktopElement}
      ${mobileElement}
    `;

    window.prestashop = {
      responsive: {},
    };

    initEmitter();

    initResponsiveToggler();
  });

  test('should switch desktop to mobile elements if screen width < 768', () => {
    window.innerWidth = 320;
    window.dispatchEvent(new window.Event('resize'));
    const mobileDomElement = document.querySelector(`#${mobileElementId}`) as HTMLElement;

    expect(mobileDomElement.innerHTML).toEqual(contentValue);
  });

  test('should switch mobile to desktop element if screen width > 768', () => {
    window.innerWidth = 1200;
    window.dispatchEvent(new window.Event('resize'));
    const desktopDomElement = document.querySelector(`#${desktopElementId}`) as HTMLElement;

    expect(desktopDomElement.innerHTML).toEqual(contentValue);
  });
});
