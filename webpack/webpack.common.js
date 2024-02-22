const { merge } = require('webpack-merge');
const path = require('path');
const {
  extractScss, extractJs, extractImages, extractFonts, externals, expose, preloadFonts
} = require('./webpack.parts');

exports.commonConfig = ({
  mode, port, publicPath, siteURL, getOutput, getEntry, entriesArray, serverAddress,
}) => (
  merge(
    expose(),
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
    },
    externals(),
    expose(),
    extractScss({ mode }),
    extractJs(),
    extractImages(),
    extractFonts(),
    preloadFonts(),
  )
);
