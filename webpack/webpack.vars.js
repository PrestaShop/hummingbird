const fs = require('fs');
const path = require('path');
const themeDev = path.resolve(__dirname, '../src');

const envFilePath = './webpack/.env';

if (fs.existsSync(envFilePath)) {
  require('dotenv').config({path: envFilePath});
}

const {
  PORT: port = null,
  PUBLIC_PATH: publicPath = null,
  SERVER_ADDRESS: serverAddress = null,
  SITE_URL: siteURL = null,
} = process.env;

const entriesArray = {
  theme: ['scss', 'ts'],
  error: ['scss'],
  theme_rtl: ['scss'],
  error_rtl: ['scss'],
  rtl: ['scss'],
};

exports.webpackVars = {
  themeDev,
  publicPath,
  serverAddress,
  siteURL,
  port,
  entriesArray,
  getEntry: (entries) => {
    const resultEntries = {};

    for (const entry in entries) {
      const files = [];

      if (!entries.hasOwnProperty(entry)) {
        continue;
      }

      for (const ext in entries[entry]) {
        const extension = entries[entry][ext];

        files.push(path.resolve(themeDev, `./${extension === 'ts' ? 'js' : extension}/${entry}.${extension}`));
      }

      resultEntries[entry] = files;
    }

    return resultEntries;
  },
  getOutput: ({
    mode, publicPath, siteURL, port, serverAddress,
  }) => ({
    filename: 'js/[name].js',
    chunkFilename: mode === 'production' ? 'js/[chunkhash].js' : 'js/[id].js',
    path: path.resolve(themeDev, '../assets'),
    publicPath: mode === 'production' ? '../' : `${serverAddress === 'localhost' ? siteURL : `${siteURL}:${port}`}${publicPath}`,
    pathinfo: false,
    library: {
      name: 'Theme',
      type: 'window',
    }
  }),
};
