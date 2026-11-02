/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */

export default function swapElements(obj1: Element, obj2: Element): void {
  // Moves the nodes, so they keep their listeners and component instances.
  obj2.textContent = '';
  obj2.append(...Array.from(obj1.childNodes));
}
