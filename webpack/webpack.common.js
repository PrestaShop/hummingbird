/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */
const { merge } = require('webpack-merge');
const path = require('path');
const {
  extractScss, extractJs, extractImages, extractFonts, externals, preloadFonts
} = require('./webpack.parts');

exports.commonConfig = ({
  mode, port, publicPath, siteURL, getOutput, getEntry, entriesArray, serverAddress,
}) => (
  merge(
    {
      mode,
      entry: getEntry(entriesArray),
      output: getOutput({
        mode, publicPath, siteURL, port, serverAddress,
      }),
      target: 'web',
      resolve: {
        alias: {
          '@js': path.resolve(__dirname, '../src/js'),
          '@services': path.resolve(__dirname, '../src/js/services'),
          '@constants': path.resolve(__dirname, '../src/js/constants'),
          '@helpers': path.resolve(__dirname, '../src/js/helpers'),
        },
      },
      stats: { 
        warnings: false,
      },
    },
    externals(),
    extractScss({ mode }),
    extractJs(),
    extractImages(),
    extractFonts(),
    preloadFonts(),
  )
);
