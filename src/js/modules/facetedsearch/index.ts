/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import noUiSlider, {target, API} from 'nouislider';
import wNumb from 'wnumb';
import initFacets from './update';
import filterHandler from './filter-handler';

const {prestashop} = window;
const {Theme} = window;

const initSliders = () => {
  document.querySelectorAll(Theme.selectors.facetedsearch.filterSlider).forEach((filter: HTMLElement) => {
    const container = <target>filter.querySelector(Theme.selectors.facetedsearch.rangeContainer);
    const options = JSON.parse(<string>container.dataset.sliderSpecifications);
    const signPosition = options.positivePattern.indexOf('¤') === 0 ? 'prefix' : 'suffix';
    // const sliderType = container.dataset.sliderSpecifications ? 'price' : 'weight';
    const sliderDirection = container.dataset.sliderDirection === '1' ? 'rtl' : 'ltr';
    const min = parseInt(<string>container.dataset.sliderMin, 10);
    const max = parseInt(<string>container.dataset.sliderMax, 10);
    // let format;
    let initiatedSlider: API;

    // Not used for the moment
    /* if (sliderType === 'price') {
      format = wNumb({
        mark: ',',
        thousand: ' ',
        decimals: 0,
        [signPosition]:
          signPosition === 'prefix' ? options.currencySymbol : ` ${options.currencySymbol}`,
      });
    } else if (sliderType === 'weight') {
      format = wNumb({
        mark: ',',
        thousand: ' ',
        decimals: 0,
      });
    } */

    const tooltipsFormat = wNumb({
      decimals: 2,
      [signPosition]:
        signPosition === 'prefix' ? options.currencySymbol : ` ${options.currencySymbol}`,
    });

    const sliderValues = JSON.parse(<string>container.dataset.sliderValues);

    if (!container.noUiSlider) {
      initiatedSlider = noUiSlider.create(container, {
        start: sliderValues ?? [min, max],
        tooltips: [tooltipsFormat, tooltipsFormat],
        direction: sliderDirection,
        connect: [false, true, false],
        range: {
          min,
          max,
        },
      });

      initiatedSlider.on('set', (values, handle, unencoded, tap, positions, instance) => {
        filterHandler(values, instance);
      });
    } else {
      container.noUiSlider.updateOptions({
        start: sliderValues ?? [min, max],
        tooltips: [tooltipsFormat, tooltipsFormat],
        range: {
          min,
          max,
        },
      }, true);

      container.noUiSlider.on('set', (values, handle, unencoded, tap, positions, instance) => {
        filterHandler(values, instance);
      });
    }
  });
};

const toggleLoader = (toggle: boolean) => {
  const loader = document.querySelector(Theme.selectors.pageLoader);

  if (loader) {
    loader.classList.toggle('d-none', toggle);
  }
};

document.addEventListener('DOMContentLoaded', () => {
  initFacets();
  prestashop.on('updateProductList', () => {
    toggleLoader(true);
    initSliders();
  });

  initSliders();

  prestashop.on('updateFacets', () => {
    toggleLoader(false);
  });
});
