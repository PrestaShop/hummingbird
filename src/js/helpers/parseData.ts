/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

/**
 * Parse and validate data from data-ps-data attribute.
 * Accepts JSON objects, arrays, strings, numbers, and booleans.
 *
 * @see {@link Validator} type is defined globally in types/validator.d.ts
 *
 * @example
 * // Define a validator
 * interface ProductData {
 *   id: string;
 *   name: string;
 * }
 *
 * const productValidator: Validator<ProductData> = (data): data is ProductData => {
 *   return (
 *     typeof data === 'object' &&
 *     data !== null &&
 *     typeof (data as ProductData).id === 'string' &&
 *     typeof (data as ProductData).name === 'string'
 *   );
 * };
 *
 * // HTML: <button data-ps-data='{"id": "123", "name": "Product"}'>
 * const data = parseData<ProductData>(button, productValidator);
 *
 * if (data) {
 *   console.log(data.id, data.name);
 * }
 *
 * @param element - The HTML element containing data-ps-data attribute
 * @param validator - Type guard function to validate the parsed data
 * @returns Parsed and validated data, or null if parsing/validation fails
 */

const parseData = <T>(
  element: HTMLElement,
  validator: Validator<T>,
): T | null => {
  if (!('psData' in element.dataset)) {
    return null;
  }

  const rawData = element.dataset.psData;

  if (rawData === undefined) {
    console.warn('Attribute data-ps-data is not defined.');
    return null;
  }

  try {
    const parsedData = JSON.parse(rawData);

    if (validator(parsedData)) {
      return parsedData;
    }

    console.warn('Attribute data-ps-data has validation error.');
    return null;
  } catch (error) {
    console.error('Attribute data-ps-data is not a valid JSON format.', error);
    return null;
  }
};

export default parseData;
