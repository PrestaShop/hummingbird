import {EventEmitter} from 'events';

export default function initEmitter() {
  /* eslint-disable */
  window.prestashop = {...EventEmitter.prototype, ...window.prestashop};
  /* eslint-enable */
}
