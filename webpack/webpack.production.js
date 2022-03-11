const { ESBuildMinifyPlugin } = require('esbuild-loader');
const CssMinimizerPlugin = require('css-minimizer-webpack-plugin');
const BundleAnalyzerPlugin = require('webpack-bundle-analyzer').BundleAnalyzerPlugin;
const { cleanDistFolders } = require('./webpack.parts');
const { merge } = require('webpack-merge');

exports.productionConfig = () => (
  merge(
    {
      devtool: 'hidden-source-map',
      optimization: {
        minimize: true,
        minimizer: [
          new ESBuildMinifyPlugin({
            target: 'es2015',
            format: 'iife'
          }),
          new CssMinimizerPlugin()
        ],
      },
    },
    cleanDistFolders()
  )
);
