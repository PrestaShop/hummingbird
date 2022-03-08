import '../assets/css/theme.css';
import '../vendor/prestashop/ps_searchbar/ps_searchbar.css';
import bootstrap from 'bootstrap'
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
      order: ['Theme', ['Introduction', '*'], 'UI', ['Introduction']],
    },
  },
}
