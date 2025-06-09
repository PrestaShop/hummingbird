const { configureDevServer } = require('./webpack.parts');
const { HotAcceptPlugin } = require('hot-accept-webpack-plugin');
const webpack = require('webpack');

exports.developmentConfig = ({ port, publicPath, serverAddress, siteURL, entriesArray }) => ({
  devtool: "cheap-source-map",
  devServer: configureDevServer(serverAddress, publicPath, port, siteURL),
  watchOptions: {
    ignored: /node_modules/,
  },
  plugins: [
    new webpack.HotModuleReplacementPlugin(),
    new HotAcceptPlugin({
      test: Object.keys(entriesArray).map(el => `${el}.js`)
    })
  ]
});
