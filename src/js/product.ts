/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import SelectorsMap from '@constants/selectors-map';
import debounce from '@helpers/debounce';

type ProductSlideEvent = Event & {to: number};

export default () => {
  const {prestashop, Theme: {events}} = window;

  const initProductSlide = () => {
    document.querySelectorAll(SelectorsMap.product.carousel)?.forEach((carousel) => {
      carousel.addEventListener('slide.bs.carousel', onProductSlide);
    });
  };

  function onProductSlide(event: ProductSlideEvent): void {
    const carousel = event.target as HTMLElement;
    const parent = carousel.closest(SelectorsMap.product.images);

    if (parent) {
      parent.querySelectorAll(SelectorsMap.product.thumbnail).forEach((e) => e.classList.remove('active'));
      parent.querySelector(SelectorsMap.product.activeThumbail(event.to))?.classList.add('active');
    }
  }

  initProductSlide();
  prestashop.on(events.updatedProduct, initProductSlide);
  prestashop.on(events.quickviewOpened, initProductSlide);

  prestashop.on(events.updateCart, (event: UpdateCartEvent) => {
    const quantityInput = document.querySelector(
      SelectorsMap.qtyInput.quantityWanted,
    ) as HTMLInputElement;

    if (quantityInput) {
      const minQuantity = getMinValue(quantityInput);
      const quantityInCart = Number(event.resp.quantity) || 0;

      if (quantityInCart >= minQuantity) {
        quantityInput.setAttribute('min', '1');
        quantityInput.setAttribute('value', '1');
      }
    }
  });

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
      const triggerEmit = async () => {
        const inputValue = parseInt(quantityInput.value, 10);
        const minQuantity = getMinValue(quantityInput);

        // Check if the input value is a valid and greater or equal than the minimum value
        if (inputValue >= minQuantity) {
          quantityInput.value = inputValue.toString();
        } else {
          quantityInput.value = minQuantity.toString();
        }

        prestashop.emit('updateProduct', {
          eventType: 'updatedProductQuantity',
        });
      };

      const debouncedTriggerEmit = debounce(triggerEmit, 500);

      quantityInput.addEventListener('input', (event: Event) => {
        const input = event.target as HTMLInputElement;
        const minQuantity = getMinValue(input);
        const sanitizedValue = sanitizeInputToNumber(input.value);
        const clampedValue = clampToMin(sanitizedValue, minQuantity);

        if (input.value !== clampedValue.toString()) {
          input.value = clampedValue.toString();
        }

        debouncedTriggerEmit();
      });

      quantityInput.addEventListener('blur', () => {
        const minQuantity = getMinValue(quantityInput);
        const sanitizedValue = sanitizeInputToNumber(quantityInput.value);
        const clampedValue = clampToMin(sanitizedValue, minQuantity);

        if (quantityInput.value !== clampedValue.toString()) {
          quantityInput.value = clampedValue.toString();
        }

        triggerEmit();
      });

      quantityInput.addEventListener('change', triggerEmit);
      incrementButton.addEventListener('click', triggerEmit);
      decrementButton.addEventListener('click', triggerEmit);
    }
  }

  const getMinValue = (input: HTMLInputElement): number => Number(input.getAttribute('min')) || 1;

  const sanitizeInputToNumber = (value: string): number => Number(value.replace(/[^\d]/g, '')) || 0;

  const clampToMin = (value: number, min: number): number => Math.max(value, min);

  // Call the function to start listening for quantity changes
  detectQuantityChange();
};
