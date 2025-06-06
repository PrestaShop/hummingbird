const path = require('path');

module.exports = {
  stories: [
    '../stories/**/*.stories.mdx',
    '../stories/**/*.stories.@(js|jsx|ts|tsx)'
  ],

  addons: [
    '@storybook/addon-links',
    '@storybook/addon-essentials',
    '@storybook/addon-a11y'
  ],

  framework: {
    name: '@storybook/html-webpack5',
    options: {}
  },

  webpackFinal: (config) => {
    // Fix the html-loader rule safely by identifying the rule, not by index
    config.module.rules = config.module.rules.map((rule) => {
      if (rule.test && rule.test.toString().includes('\\.html$')) {
        return {
          ...rule,
          use: {
            loader: 'html-loader',
            options: {
              sources: false // disables processing of <img src>, <script src>, etc.
            }
          }
        };
      }
      return rule;
    });

    // Add support for SCSS
    config.module.rules.push({
      test: /\.scss$/,
      use: [
        'style-loader',
        'css-loader',
        {
          loader: 'sass-loader',
          options: {
            sassOptions: {
              quietDeps: true // ✅ suppresses deprecation warnings from Bootstrap
            }
          }
        }
      ],
      include: path.resolve(__dirname, '../'),
    });

    // Add path aliases
    config.resolve.alias = {
      ...config.resolve.alias,
      '@js': path.resolve(__dirname, '../src/js'),
      '@services': path.resolve(__dirname, '../src/js/services'),
      '@constants': path.resolve(__dirname, '../src/js/constants'),
      '@helpers': path.resolve(__dirname, '../src/js/helpers'),
    };

    // Define external libraries
    config.externals = {
      ...config.externals,
      prestashop: 'prestashop',
    };

    return config;
  },

  docs: {
    autodocs: true
  }
};
