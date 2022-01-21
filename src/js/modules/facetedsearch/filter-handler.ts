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
import {target, API} from 'nouislider';

export default function (values: Array<any>, slider: API) {
  const label = <string>slider.target.dataset.sliderLabel;
  const unit = slider.target.dataset.sliderUnit;
  const encodedUrl = window.location.href;
  const splittedUrl = encodedUrl.split('?');
  let newUrl: string;

  const searchParams = new URLSearchParams(splittedUrl[1]);
  const params = searchParams.get('q');

  if(params) {
    let groups = params.split('/');
    groups = groups.filter(e => e.replace(label, '') === e);
    groups.push(`${label}-${unit}-${values[0]}-${values[1]}`);
    newUrl = `${splittedUrl[0]}?q=${groups.join('/')}`;
  }else {
    newUrl = `${splittedUrl[0]}?q=${label}-${unit}-${values[0]}-${values[1]}`;
  }

  prestashop.emit('updateFacets', newUrl);
};

export const getCurrentParam =  (slider: HTMLElement, min: number, max: number) => {
  const label = <string>slider.dataset.sliderLabel;
  const unit = slider.dataset.sliderUnit;
  const encodedUrl = window.location.href;
  const splittedUrl = encodedUrl.split('?');
  let newUrl: string;

  const searchParams = new URLSearchParams(splittedUrl[1]);
  const params = searchParams.get('q');

  if(params) {
    let groups = params.split('/');
    groups = groups.filter(e => e.replace(label, '') !== e);
    const groupValues = groups[0].split('-');

    return [parseFloat(groupValues[2]), parseFloat(groupValues[3])];
  }

  return [min, max];
};
