// @ts-ignore
import prestashop from 'prestashop';
import {EventEmitter} from 'events';

/* eslint-disable */
for (const i in EventEmitter.prototype) {
  // @ts-ignore
  prestashop[i] = EventEmitter.prototype[i];
}
/* eslint-enable */
