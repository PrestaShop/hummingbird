import {addons} from '@storybook/addons';
import {themes} from '@storybook/theming';
import psTheme from './ps-theme';

addons.setConfig({
  theme: psTheme,
});
