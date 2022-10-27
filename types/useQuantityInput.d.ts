/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

 declare namespace Theme {
  namespace QuantityInput {
    interface InputGroup {
      qtyInput: HTMLInputElement;
      incrementButton: HTMLButtonElement;
      decrementButton: HTMLButtonElement;
    }

    type Function = (selector?: string, delay?: number) => void
  }
}
