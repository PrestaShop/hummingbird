/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import { defineConfig } from "vite";
import { resolve } from "path";
import fs from "fs";

const dotenv = (await import('dotenv')).default;

const envFilePath = './.env';
if (fs.existsSync(envFilePath)) {
  dotenv.config({ path: envFilePath });
}

const {
  PORT: port = 3000,
  PUBLIC_PATH: publicPath = '/themes/hummingbird/assets/',
  SERVER_ADDRESS: serverAddress = 'localhost',
  SITE_URL: siteURL = 'http://localhost',
} = process.env;

export default defineConfig(
  {
    build: {
      rollupOptions: {
        outDir: resolve(__dirname, 'assets'),
        assetsDir: '',
        emptyOutDir: true,
        input: {
          // TS entry
          script: resolve(__dirname, 'src/js/theme.ts'),
          // Scss entry
          error: resolve(__dirname, 'src/scss/error.scss'),
          error_rtl: resolve(__dirname, 'src/scss/error_rtl.scss'),
          rtl: resolve(__dirname, 'src/scss/rtl.scss'),
          theme: resolve(__dirname, 'src/scss/theme.scss'),
          theme_rtl: resolve(__dirname, 'src/scss/theme_rtl.scss'),
        },
        output: {
          entryFileNames: (chunkInfo) => {
            if (chunkInfo.name === 'script') {
              return 'js/theme.js'
            }
            return 'js/[name].js'
          },
          assetFileName: (assetInfo) => {
            const info = assetInfo.name.split('.');
            const extension = info[info.length - 1];

            if (/png|jpe?g|svg|gif|tiff|bmp|ico/i.test(extension)) {
              return `img-dist/[name][extname]`;
            }
            if (/woff2?|eot|ttf|otf/i.test(extension)) {
              return `fonts/[name]-[hash][extname]`;
            }
            if (extension === 'css') {
              return 'css/[name].css';
            }
          }
        },
        external: [],
      },
    },

    css: {
      preprocessorOptions: {
        scss: {
          api: 'modern-compiler',
          silenceDeprecations: ['mixed-decls', 'color-functions', 'global-builtin', 'import'],
        }
      }
    },

    resolve: {
      alias: {
        '@js': resolve(__dirname, 'src/js'),
        '@services': resolve(__dirname, 'src/js/services'),
        '@constants': resolve(__dirname, 'src/js/constants'),
        '@helpers': resolve(__dirname, 'src/js/helpers'),
      },
    },
  })
