/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

export interface Result {
  // eslint-disable-next-line camelcase
  canonical_url: string;
  name: string;
  cover: {
    small: {
      url: string;
    };
  };
}

export const searchProduct = async (url: string, value: string, resultsPerPage = 10): Promise<Array<Result>> => {
  const formData = new FormData();
  formData.append('s', value);
  formData.append('resultsPerPage', resultsPerPage.toString());

  const datas = await fetch(url, {
    method: 'POST',
    body: formData,
    headers: {
      Accept: 'application/json, text/javascript, */*; q=0.01',
    },
  });

  const jsonDatas = await datas.json();

  return jsonDatas.products;
};
