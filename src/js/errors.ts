/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import useToast from './components/useToast';

const initErrorHandler = () => {
  const {Theme: {events}} = window;
  const {prestashop} = window;

  prestashop.on(events.handleError, ({resp}: {resp: {errors: string[]}}) => {
    resp.errors.forEach((error) => {
      useToast(error, {type: 'danger'}).show();
    });
  });
};

export default initErrorHandler;
