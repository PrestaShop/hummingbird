/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
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
