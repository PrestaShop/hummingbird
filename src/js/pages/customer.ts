/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import SelectorsMap from '@constants/selectors-map';

const initCustomer = () => {
  const {returnFormMainCheckbox, returnFormItemCheckbox} = SelectorsMap.order;
  const returnTableMainCheckbox = document.querySelector<HTMLInputElement>(returnFormMainCheckbox);
  returnTableMainCheckbox?.addEventListener('click', () => {
    const checked = !!returnTableMainCheckbox?.checked;
    const itemCheckbox = document.querySelectorAll<HTMLInputElement>(returnFormItemCheckbox);
    itemCheckbox.forEach((checkbox) => { checkbox.checked = checked; });
  });
};

export default initCustomer;
