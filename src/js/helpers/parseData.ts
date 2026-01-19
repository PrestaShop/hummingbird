/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

/**
 * Parse JSON data from data-ps-data attribute
 *
 * @example
 * // HTML: <button data-ps-data='{"id": "123", "name": "Product"}'>
 * const data = parseData<{id: string, name: string}>(button);
 * // Returns: { id: "123", name: "Product" }
 *
 * @param element - The HTML element containing data-ps-data attribute
 * @returns Parsed data object or null if parsing fails
 */
const parseData = <T>(element: HTMLElement): T | null => {
  const {psData} = element.dataset;

  if (!psData) return null;

  try {
    return JSON.parse(psData) as T;
  } catch {
    console.error('[parseData] Failed to parse data-ps-data:', psData);
    return null;
  }
};

export default parseData;
