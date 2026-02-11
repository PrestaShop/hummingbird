/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import SelectorsMap from '@constants/selectors-map';

const initCustomer = () => {
  const {returnFormSelectAll, returnFormProductCheckbox} = SelectorsMap.order;
  const selectAllCheckbox = document.querySelector<HTMLInputElement>(returnFormSelectAll);
  const productCheckboxes = document.querySelectorAll<HTMLInputElement>(returnFormProductCheckbox);

  selectAllCheckbox?.addEventListener('click', () => {
    const {checked} = selectAllCheckbox;
    productCheckboxes.forEach((checkbox) => {
      if (!checkbox.disabled) {
        checkbox.checked = checked;
      }
    });
  });
};

export default initCustomer;
