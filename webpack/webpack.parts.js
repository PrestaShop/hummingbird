const webpack = require('webpack');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const path = require('path');
const ForkTsCheckerWebpackPlugin = require('fork-ts-checker-webpack-plugin');

exports.configureDevServer = (serverAddress, publicPath, port, siteURL) => ({
  allowedHosts: [serverAddress],
  host: serverAddress,
  client: {
    logging: 'error',
    progress: false,
    overlay: {
      errors: true,
      warnings: false,
    },
  },
  devMiddleware: {
    publicPath,
    writeToDisk: (filePath) => !(/hot-update/.test(filePath)),
  },
  headers: {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, PATCH, OPTIONS',
    'Access-Control-Allow-Headers': 'X-Requested-With, content-type, Authorization',
  },
  hot: true,
  liveReload: true,
  watchFiles: [
    '../../**/*.tpl',
    '../../modules/**/*.js',
    '../../modules/**/*.css',
  ],
  port,
  proxy: {
    '**': {
      target: siteURL,
      secure: false,
      changeOrigin: true,
    },
  },
  static: {
    publicPath,
  },
});

exports.extractScss = ({mode = 'production'}) => ({
  module: {
    rules: [{
      test: /\.scss$/,
      use: [
        MiniCssExtractPlugin.loader,
        'css-loader',
        {
          loader: 'postcss-loader',
          options: {
            postcssOptions: {
              config: path.resolve(__dirname, '../postcss.config.js'),
            },
          },
        },
        'sass-loader',
      ],
    }],
  },
  plugins: [
    new MiniCssExtractPlugin({
      filename: 'css/[name].css',
      chunkFilename: mode === 'production' ? 'css/[chunkhash].css' : 'css/[id].css',
    }),
  ],
});

exports.extractJs = () => ({
  module: {
    rules: [
      {
        test: /\.(js|jsx|ts|tsx)?$/,
        exclude: /(node_modules)/,
        resolve: {
          fullySpecified: false,
          extensions: ['.js', '.ts'],
        },
        use: {
          loader: 'esbuild-loader',
          options: {
            loader: 'ts',
            target: 'es2015',
          },
        },
      },
    ],
  },
  plugins: [
    new ForkTsCheckerWebpackPlugin(),
  ],
});

exports.extractImages = () => ({
  module: {
    rules: [
      {
        test: /\.(png|jpg|gif|svg)$/,
        use: [
          {
            loader: 'file-loader',
            options: {
              outputPath: 'img-dist/',
              publicPath: '../img-dist/',
              name: '[contenthash].[ext]',
            },
          },
        ],
        type: 'javascript/auto',
      },
    ],
  },
});

exports.extractFonts = () => ({
  module: {
    rules: [
      {
        test: /\.(woff|woff2|ttf|eot|otf)$/,
        use: [
          {
            loader: 'file-loader',
            options: {
              outputPath: 'fonts/',
              publicPath: '../fonts/',
              name: '[contenthash].[ext]',
            },
          },
        ],
        type: 'javascript/auto',
      },
    ],
  },
});

exports.cleanDistFolders = () => ({
  output: {
    clean: true,
  },
});

exports.externals = () => ({
  externals: {
    prestashop: 'prestashop',
  },
});

exports.expose = () => ({
  module: {
    rules: [
      {
        test: require.resolve('jquery'),
        loader: 'expose-loader',
        options: {
          exposes: {
            override: true,
            globalName: [
              '$',
              'jQuery',
            ],
          },
        },
      },
    ],
  },
});
