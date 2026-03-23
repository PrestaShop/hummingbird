/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */
import {EventEmitter} from 'events';

export default () => {
  Object.assign(window.prestashop, EventEmitter.prototype);
};
