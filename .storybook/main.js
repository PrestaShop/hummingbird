const path = require('path');

module.exports = {
  "stories": [
    "../stories/**/*.stories.mdx",
    "../stories/**/*.stories.@(js|jsx|ts|tsx)"
  ],
  "addons": [
    "@storybook/addon-links",
    "@storybook/addon-essentials",
    '@storybook/addon-a11y',
  ],
  "framework": "@storybook/html",
  "core": {
    "builder": "webpack5"
  },
  webpackFinal: (config) => {
    config.module.rules[3].use = 'html-loader?minimize=false';
    config.module.rules.push({
      test: /\.scss$/,
      use: ['style-loader', 'css-loader', 'sass-loader'],
      include: path.resolve(__dirname, '../'),
    });

    config.resolve.alias = {
      ...config.resolve.alias,
      '@js': path.resolve(__dirname, '../src/js'),
      '@services': path.resolve(__dirname, '../src/js/services'),
      '@constants': path.resolve(__dirname, '../src/js/constants'),
      '@helpers': path.resolve(__dirname, '../src/js/helpers'),
    }

    config.externals = {
      ...config.externals,
      prestashop: 'prestashop',
    };

    return config;
  },
  addonActionsTheme: {
    BASE_COLOR: 'red',
  },
}
