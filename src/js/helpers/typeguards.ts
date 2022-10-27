/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

/* eslint-disable max-len */

export const isHTMLElement = (element: EventTarget | null): element is HTMLElement => (element as HTMLElement).innerText !== undefined;

export default {
  isHTMLElement,
};
