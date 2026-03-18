/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */
import swapElements from './swapElements';
import {
  desktopElement, mobileElement, desktopElementId, mobileElementId, contentValue,
} from '../constants/mocks/swapElements-data';

describe('Helpers', () => {
  it('should swap children 1 with children 2', () => {
    document.body.innerHTML = `
      ${desktopElement}
      ${mobileElement}
    `;

    const desktopDomElement = document.querySelector(`#${desktopElementId}`) as HTMLElement;
    const mobileDomElement = document.querySelector(`#${mobileElementId}`) as HTMLElement;

    swapElements(desktopDomElement, mobileDomElement);

    expect(mobileDomElement.innerHTML).toEqual(contentValue);
  });
});
