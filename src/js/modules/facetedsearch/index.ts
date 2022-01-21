/**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 */

import noUiSlider, {target} from 'nouislider';
import {facetedsearch as SelectorsMap} from '@js/selectors-map';
import wNumb from 'wnumb';

const initSliders = () => {
  document.querySelectorAll(SelectorsMap.filterSlider).forEach((filter: HTMLElement) => {
    const container = <HTMLElement>filter.querySelector(SelectorsMap.rangeContainer);
    const slider = <target>filter.querySelector(SelectorsMap.range);
    const options = JSON.parse(<string>container.dataset.sliderSpecifications);
    const signPosition = options.positivePattern.indexOf('¤') === 0 ? 'prefix' : 'suffix';
    const sliderType = container.dataset.sliderSpecifications ? 'price' : 'weight';
    const min = parseInt(<string>container.dataset.sliderMin);
    const max = parseInt(<string>container.dataset.sliderMax);
    let format;
    const values = !Array.isArray(container.dataset.sliderValues) ? [min, max] : container.dataset.sliderValues;
    
    if (sliderType === 'price') {
      format = wNumb({
        mark: ',',
        thousand: ' ',
        decimals: 0,
        [signPosition]:
          signPosition === 'prefix' ?  options.currencySymbol : ` ${options.currencySymbol}`,
      });
    }else if(sliderType === 'weight') {
      format = wNumb({
        mark: ',',
        thousand: ' ',
        decimals: 0,
      });
    }
    const tooltipsFormat = wNumb({
      decimals: 0,
      [signPosition]:
        signPosition === 'prefix' ?  options.currencySymbol : ` ${options.currencySymbol}`,
    })

    noUiSlider.create(container, {
      start: [0, 100],
      tooltips: [tooltipsFormat, tooltipsFormat],
      connect: [false, true, false],
      range: {
        min,
        max,
      },
    });
  }) 
}

document.addEventListener('DOMContentLoaded', () => {
  prestashop.on('updateProductList', () => {
    // hideLoading();
    initSliders();
  })

  initSliders();

  prestashop.on('updateFacets', () => {
    // showLoading();
  })
});

