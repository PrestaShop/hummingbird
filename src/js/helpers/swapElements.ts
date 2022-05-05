/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

export default function swapElements(obj1: Element, obj2: Element): void {
  const temp = obj1.innerHTML;
  obj1.innerHTML = '';
  obj2.innerHTML = temp;
}
