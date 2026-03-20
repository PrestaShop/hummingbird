/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */

const getQueryParameters = (params: string) => params.split('&').map((str) => {
  const [key, val] = str.split('=');

  return {
    name: key,
    value: decodeURIComponent(val).replace(/\+/g, ' '),
  };
});

export default getQueryParameters;
