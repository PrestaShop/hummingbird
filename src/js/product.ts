/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import SelectorsMap from './constants/selectors-map';

type ProductSlideEvent = Event & {to: number};

export default () => {
  const {prestashop, Theme: {events}} = window;

  const initProductSlide = () => {
    document.querySelector(SelectorsMap.product.carousel)?.addEventListener('slide.bs.carousel', onProductSlide);
  };

  function onProductSlide(event: ProductSlideEvent): void {
    document.querySelectorAll(SelectorsMap.product.thumbnail).forEach((e) => e.classList.remove('active'));
    document.querySelector(SelectorsMap.product.activeThumbail(event.to))?.classList.add('active');
  }

  initProductSlide();
  prestashop.on(events.updatedProduct, initProductSlide);
  prestashop.on(events.quickviewOpened, initProductSlide);

  function detectQuantityChange() {
    const quantityInput = document.querySelector(
      SelectorsMap.qtyInput.quantityWanted,
    ) as HTMLInputElement;
    const incrementButton = document.querySelector(
      SelectorsMap.qtyInput.increment,
    ) as HTMLButtonElement;
    const decrementButton = document.querySelector(
      SelectorsMap.qtyInput.decrement,
    ) as HTMLButtonElement;

    if (quantityInput && incrementButton && decrementButton) {
      // Function to trigger emit
      const triggerEmit = () => {
        const inputValue = parseInt(quantityInput.value, 10);
        const minValue = parseInt(quantityInput.min, 10);

        // Check if the input value is a valid and greater or equal than the minimum value
        if (!isNaN(inputValue) && inputValue >= minValue) {
          quantityInput.value = inputValue.toString();
        } else {
          quantityInput.value = minValue.toString();
        }

        prestashop.emit('updateProduct', {
          eventType: 'updatedProductQuantity',
        });
      };

      // Attach event listener for input changes
      quantityInput.addEventListener('change', triggerEmit);

      // Attach event listener for increment / decrement button click
      incrementButton.addEventListener('click', triggerEmit);
      decrementButton.addEventListener('click', triggerEmit);
    }
  }

  // Call the function to start listening for quantity changes
  detectQuantityChange();
};
