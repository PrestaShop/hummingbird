import '../assets/css/theme.css';
import 'bootstrap';
//import '../../core.js';
//import '../assets/js/theme.js';


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
      order: ['UI', ['Introduction']],
    },
  },
}
