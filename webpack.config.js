/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

const { webpackVars } = require('./webpack/webpack.vars.js');
const { commonConfig } = require('./webpack/webpack.common.js');
const { productionConfig } = require('./webpack/webpack.production.js');
const { developmentConfig } = require('./webpack/webpack.development.js');
const { merge } = require('webpack-merge');

const getConfig = ({mode, ...vars}) => {
  // Detect if we're using webpack serve (dev server) vs webpack watch
  const isDevServer = process.argv.includes('serve');
  
  switch (mode) {
    case 'production':
      return merge(commonConfig({mode, ...vars}), productionConfig({mode, ...vars}));
    case 'development':
      return merge(commonConfig({mode, ...vars}), developmentConfig({mode, ...vars, isDevServer}));
    default:
      throw new Error(`Trying to use an unknown mode, ${mode}`);
  }
};

module.exports = (env, options) => getConfig({
  mode: options.mode ?? 'production',
  ...webpackVars
});
