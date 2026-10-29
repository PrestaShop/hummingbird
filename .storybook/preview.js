import '../src/scss/theme.scss';
import 'bootstrap';
import useToast from '../src/js/components/useToast';
import useAlert from '../src/js/components/useAlert';
import useProgressRing from '../src/js/components/useProgressRing';
import selectors from '../src/js/constants/selectors-map';
import EVENTS from '../src/js/constants/events-map';
import initEmitter from '../src/js/prestashop';
import initQuantitySelectors from '../src/js/components/quantity-selector';

window.Theme = {
  components: {
    useToast,
    useAlert,
    useProgressRing
  },
  events: EVENTS,
}

window.prestashop = {
  themeSelectors: {
    ...selectors
  }
}

initEmitter();
// Delegated to the document, so stories rendered later work without re-init
initQuantitySelectors();

const preview = {
  parameters: {
    // Add parameters here
  },

  tags: ['autodocs']
};
export default preview;
