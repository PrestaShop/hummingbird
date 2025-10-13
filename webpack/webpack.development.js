const { configureDevServer } = require('./webpack.parts');
const { HotAcceptPlugin } = require('hot-accept-webpack-plugin');
const webpack = require('webpack');

exports.developmentConfig = ({ port, publicPath, serverAddress, siteURL, entriesArray, isDevServer = false }) => {
  const plugins = [];
  
  // Only enable HMR when using webpack serve (dev server)
  if (isDevServer) {
    plugins.push(
      new webpack.HotModuleReplacementPlugin(),
      new HotAcceptPlugin({
        test: Object.keys(entriesArray).map(el => `${el}.js`)
      })
    );
  }

  return {
    devtool: "cheap-source-map",
    devServer: isDevServer ? configureDevServer(serverAddress, publicPath, port, siteURL) : undefined,
    watchOptions: {
      ignored: /node_modules/,
    },
    plugins
  };
};
