import '../src/scss/theme.scss';
import 'bootstrap';
import useToast from '../src/js/components/useToast';

window.Theme = {
  components: {
    useToast
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
