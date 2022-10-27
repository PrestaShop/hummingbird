/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
import {API} from 'nouislider';

export default function (values: Array<string | number>, slider: API) {
  const {prestashop, Theme: {events}} = window;

  const label = slider.target.dataset.sliderLabel;
  const unit = slider.target.dataset.sliderUnit;
  const encodedUrl = window.location.href;
  const splittedUrl = encodedUrl.split('?');
  let newUrl: string;

  const searchParams = new URLSearchParams(splittedUrl[1]);
  const params = searchParams.get('q');

  if (params) {
    let groups = params.split('/');

    if (label) {
      groups = groups.filter((e) => e.replace(label, '') === e);
      groups.push(`${label}-${unit}-${values[0]}-${values[1]}`);
    }

    newUrl = `${splittedUrl[0]}?q=${groups.join('/')}`;
  } else {
    newUrl = `${splittedUrl[0]}?q=${label}-${unit}-${values[0]}-${values[1]}`;
  }

  prestashop.emit(events.updateFacets, newUrl);
}
