/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

const debounce = (callback: <T>(...args: T[]) => Promise<T | void>, wait: number): <T>(...args: T[]) => void => {
  let timeoutId: number | undefined;

  return (...args) => {
    if (typeof timeoutId !== 'undefined') {
      window.clearTimeout(timeoutId);
    }

    timeoutId = window.setTimeout(() => {
      callback(...args);
    }, wait);
  };
};

export default debounce;
