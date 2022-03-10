import {create} from '@storybook/theming';
import logoUrl from './logo-prestashop.svg';

export default create({
  base: 'dark',
  brandTitle: 'PrestaShop',
  brandUrl: 'https://www.prestashop-project.org/',
  brandImage: logoUrl,

  colorPrimary: '#6c868e',
  colorSecondary: '#25b9d7',

  // UI
  appBg: '#363a41',
  appContentBg: 'white',
  appBorderRadius: 4,

  barTextColor: 'white',
  barSelectedColor: '#25b9d7',
  barBg: '#272a2d',

  // Typography
  fontBase: '"Open Sans", sans-serif',
  fontCode: 'monospace',

  // Text colors
  textColor: 'white',
  textInverseColor: 'rgba(255,255,255,0.9)',

  // Form
  inputTextColor: 'black',
  inputBorderRadius: 4,
});
