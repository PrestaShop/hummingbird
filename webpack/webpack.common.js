const { extractScss, extractJs, extractImages, extractFonts, externals, expose } = require('./webpack.parts');
const { merge } = require('webpack-merge');

exports.commonConfig = ({ mode, port, publicPath, siteURL, getOutput, getEntry, entriesArray, serverAddress }) => (
  merge(
    {
      mode,
      entry: getEntry(entriesArray),
      output: getOutput({ mode, publicPath, siteURL, port , serverAddress}),
      target: 'web',
    },
    externals(),
    expose(),
    extractScss({ mode }),
    extractJs(),
    extractImages(),
    extractFonts(),
  )
);
