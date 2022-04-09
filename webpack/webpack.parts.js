const path = require('path');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const RemoveEmptyScriptsPlugin = require('webpack-remove-empty-scripts');
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
    '../../modules/**/*.ts',
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
      exclude: /_rtl\.scss$/,
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
    },
    {
      test: /_rtl\.scss$/,
      use: [
        MiniCssExtractPlugin.loader,
        'css-loader',
        {
          loader: path.resolve('./webpack/webpack.rtl.js'),
        },
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
    new RemoveEmptyScriptsPlugin(),
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
        test: /theme\.ts?$/,
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
