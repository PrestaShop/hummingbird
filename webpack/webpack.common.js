const {merge} = require('webpack-merge');
const {
  extractScss, extractJs, extractImages, extractFonts, externals, expose,
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
    },
    externals(),
    extractScss({mode}),
    extractJs(),
    extractImages(),
    extractFonts(),
  )
);
