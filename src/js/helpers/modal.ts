/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */
import selectorsMap from '@constants/selectors-map';

export default function getModalContentContainer(): HTMLElement {
  const container = document.querySelector<HTMLElement>(selectorsMap.modalContainer);

  if (!container) {
    throw new Error(`Missing div with "${selectorsMap.modalContainer}" in the DOM.`);
  }

  return container;
}
