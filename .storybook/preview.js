import '../src/scss/theme.scss';
import 'bootstrap';
import useToast from '../src/js/components/useToast';
import useAlert from '../src/js/components/useAlert';
import useProgressRing from '../src/js/components/useProgressRing';
import selectors from '../src/js/constants/selectors-map';

window.Theme = {
  components: {
    useToast,
    useAlert,
    useProgressRing
  }
}

window.prestashop = {
  themeSelectors: {
    ...selectors
  }
}

export const parameters = {
  actions: { argTypesRegex: "^on[A-Z].*" },
  controls: {
    matchers: {
      color: /(background|color)$/i,
      date: /Date$/,
    },
  },
  options: {
    storySort: {
      order: ['Theme', ['Introduction', 'JavaScript', ['Components', ['Introduction']]], 'UI', ['Introduction']],
    },
  },
}
