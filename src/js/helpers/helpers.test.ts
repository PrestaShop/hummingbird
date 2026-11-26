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

  it('should move the children with their listeners', () => {
    document.body.innerHTML = `
      <div id="${desktopElementId}"><button type="button">${contentValue}</button></div>
      ${mobileElement}
    `;

    const desktopDomElement = document.querySelector(`#${desktopElementId}`) as HTMLElement;
    const mobileDomElement = document.querySelector(`#${mobileElementId}`) as HTMLElement;
    const button = desktopDomElement.querySelector('button') as HTMLButtonElement;
    const onClick = jest.fn();
    button.addEventListener('click', onClick);

    swapElements(desktopDomElement, mobileDomElement);
    mobileDomElement.querySelector('button')?.click();

    expect(mobileDomElement.firstElementChild).toBe(button);
    expect(desktopDomElement.childNodes).toHaveLength(0);
    expect(onClick).toHaveBeenCalledTimes(1);
  });
});
