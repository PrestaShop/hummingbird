/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
import initCart from './pages/cart';

$(() => {
  initCart();
});

window.Theme.default = {
  ...window.Theme.default,
  initCart,
};
