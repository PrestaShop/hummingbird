/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */
import {API} from 'nouislider';

export default function (values: Array<string | number>, slider: API) {
  const {prestashop, Theme: {events}} = window;

  const url = new URL(<string> slider.target.dataset.sliderEncodedUrl, window.location.origin);
  let qParam = url.searchParams.get('q') || '';

  qParam += [
    qParam.length > 0 ? '/' : '',
    slider.target.dataset.sliderLabel,
    '-',
    slider.target.dataset.sliderUnit,
    '-',
    values[0],
    '-',
    values[1],
  ].join('');

  url.searchParams.set('q', qParam);

  prestashop.emit(events.updateFacets, url.href);
}
