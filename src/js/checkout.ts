/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
import initCheckout from './pages/checkout';

$(() => {
  initCheckout();
});

window.Theme.default = {
  ...window.Theme.default,
  initCheckout,
};
