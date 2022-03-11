import {EventEmitter} from 'events';

export default () => {
  Object.assign(window.prestashop, EventEmitter.prototype);
};
