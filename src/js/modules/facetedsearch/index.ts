/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */

import noUiSlider, {target, API} from 'nouislider';
import wNumb from 'wnumb';
import initFacets from './update';
import filterHandler from './filter-handler';

const SLIDER_EVENT_NAMESPACE = '.facetedsearch';

// eslint-disable-next-line import/prefer-default-export
export const initSliders = () => {
  const {Theme} = window;

  // Get all slider configurations found in the DOM
  document.querySelectorAll(Theme.selectors.facetedsearch.filterSlider).forEach((filter: HTMLElement) => {
    const container = <target>filter.querySelector(Theme.selectors.facetedsearch.rangeContainer);

    // Init basic slider data
    const unitCurrency = container.dataset.sliderCurrency;
    let unitPosition = 'suffix';
    let unitSymbol = container.dataset.sliderUnit;
    let decimalCount = 2;
    let decimalSeparator = '.';
    let thousandsSeparator = '';

    // Specify further if there are more options, currently used for price slider,
    // which is the only one providing price specifications.
    const options = JSON.parse(<string>container.dataset.sliderSpecifications);

    if (options !== null) {
      // Sign position
      if (options.positivePattern !== undefined && options.positivePattern.indexOf('¤') === 0) {
        unitPosition = 'prefix';
      }

      // Unit
      if (options.currencySymbol !== undefined) {
        unitSymbol = options.currencySymbol;
      }

      // Separators
      if (options.numberSymbols !== undefined) {
        decimalSeparator = options.numberSymbols[0];
        thousandsSeparator = options.numberSymbols[1];
      }

      // Decimals
      if (options.minFractionDigits !== undefined) {
        decimalCount = options.minFractionDigits;
      }
    }

    // Minimum and maximum values
    const min = parseInt(<string>container.dataset.sliderMin, 10);
    const max = parseInt(<string>container.dataset.sliderMax, 10);

    // const sliderType = container.dataset.sliderSpecifications ? 'price' : 'weight';
    const sliderDirection = container.dataset.sliderDirection === '1' ? 'rtl' : 'ltr';

    // Initialize tooltip format
    const tooltipsFormat = wNumb({
      mark: decimalSeparator,
      thousand: thousandsSeparator,
      decimals: decimalCount,
      [unitPosition]: unitPosition === 'prefix' ? unitSymbol : ` ${unitSymbol}`,
    });

    const sliderValues = JSON.parse(<string>container.dataset.sliderValues);

    let slider: API;

    if (!container.noUiSlider) {
      // if we initiate slider with noUiBase he create another one we have to delete it before.
      const noUiBase = container.querySelector('.noUi-base');

      if (noUiBase) {
        noUiBase.remove();
      }
      slider = noUiSlider.create(container, {
        start: sliderValues ?? [min, max],
        tooltips: [tooltipsFormat, tooltipsFormat],
        direction: sliderDirection,
        connect: [false, true, false],
        range: {
          min,
          max,
        },
      });

      slider.target.querySelectorAll('.noUi-handle').forEach((handle) => {
        handle.setAttribute('tabindex', '0');
        const ariaLabel = unitCurrency
          ? `Adjust filter range in ${unitCurrency}`
          : `Adjust filter range in ${unitSymbol}`;
        handle.setAttribute('aria-label', ariaLabel);
      });
    } else {
      slider = container.noUiSlider;

      // Drop the listeners of the previous init before updating, so the update
      // does not trigger a filter request and listeners are not stacked.
      slider.off(SLIDER_EVENT_NAMESPACE);

      slider.updateOptions({
        start: sliderValues ?? [min, max],
        tooltips: [tooltipsFormat, tooltipsFormat],
        range: {
          min,
          max,
        },
      }, false);
    }

    // Remove tooltips:
    slider.removeTooltips();

    slider.on(`set${SLIDER_EVENT_NAMESPACE}`, (values, handle, unencoded, tap, positions, instance) => {
      filterHandler(values, instance);
    });

    slider.on(`update${SLIDER_EVENT_NAMESPACE}`, (values) => {
      const formattedValues: string[] = values.map((value) => (
        unitPosition === 'suffix' ? `${value}${unitSymbol}` : `${unitSymbol}${value}`),
      );

      const parentFacet = slider.target.closest(Theme.selectors.facetedsearch.filterSlider) as HTMLElement;
      const showValues = parentFacet.querySelector(Theme.selectors.facetedsearch.rangeValues) as HTMLElement;
      showValues.textContent = formattedValues.join(' - ');
    });
  });
};

const toggleLoader = (toggle: boolean) => {
  const {Theme} = window;
  const loader = document.querySelector(Theme.selectors.pageLoader);

  if (loader) {
    loader.classList.toggle('d-none', toggle);
  }
};

document.addEventListener('DOMContentLoaded', () => {
  const {prestashop, Theme: {events}} = window;
  initFacets();
  prestashop.on(events.updateProductList, () => {
    toggleLoader(true);
    initSliders();
  });

  initSliders();

  prestashop.on(events.updateFacets, () => {
    toggleLoader(false);
  });
});
