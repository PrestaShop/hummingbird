/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
import {API} from 'nouislider';
import getQueryParameters from './urlparser';

export default function (values: Array<string | number>, slider: API) {
  const {prestashop, Theme: {events}} = window;

  // Prepare query parameters
  // eslint-disable-next-line
  let queryParams = <any> [];

  // Get next encoded URL
  const nextEncodedFacetsURL = <string> slider.target.dataset.sliderEncodedUrl;

  // Split it to URL and parameters part
  const urlsSplitted = nextEncodedFacetsURL.split('?');

  // Retrieve parameters if exists
  if (urlsSplitted !== undefined && urlsSplitted.length > 1) {
    queryParams = getQueryParameters(urlsSplitted[1]);
  }

  // Check if q param is present, add it if missing
  let found = false;
  // eslint-disable-next-line
  queryParams.forEach((query: any) => {
    if (query.name === 'q') {
      found = true;
    }
  });

  if (!found) {
    queryParams.push({name: 'q', value: ''});
  }

  // Update query parameter
  // eslint-disable-next-line
  queryParams.forEach((query: any) => {
    if (query.name === 'q') {
      // eslint-disable-next-line
      query.value += [
        query.value.length > 0 ? '/' : '',
        slider.target.dataset.sliderLabel,
        '-',
        slider.target.dataset.sliderUnit,
        '-',
        values[0],
        '-',
        values[1],
      ].join('');
    }
  });

  const newUrl = [
    urlsSplitted[0],
    '?',
    $.param(queryParams),
  ].join('');

  prestashop.emit(events.updateFacets, newUrl);
}
