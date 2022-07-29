/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

 import SelectorsMap from '@constants/selectors-map';

 const initCustomer = () => {  
  // order details -- return table main checkbox functionality
  const returnTableMainCheckbox = document.querySelector(SelectorsMap.order.returnFormMainCheckbox) as HTMLInputElement;
  const returnTableItemCheckbox = document.querySelectorAll(SelectorsMap.order.returnFormItemCheckbox);
  returnTableMainCheckbox?.addEventListener('click', (event: Event) => {
    let checked: boolean = returnTableMainCheckbox?.checked;
    returnTableItemCheckbox.forEach((checkbox: HTMLInputElement)  => {
      if (checked == true) {
        checkbox.checked = true;
      }else {
        checkbox.checked = false;
      }
    });
  });
 }

 export default initCustomer;
