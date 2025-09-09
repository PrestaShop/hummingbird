/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import { defineConfig } from "vite";
import { resolve } from "path";
import fs from "fs";
import rtlTransformPlugin from "./vite/rtlTransformPlugin";

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

export default defineConfig(({ command, mode }) => {
  const isDev = mode === 'development';

  return {
    root: resolve(__dirname, 'src'),
    base: isDev ? publicPath : './',

    build: {
      outDir: resolve(__dirname, 'assets'),
      assetsDir: '',
      emptyOutDir: true,
      rollupOptions: {
        input: {
          // TS entry
          script: resolve(__dirname, 'src/js/theme.ts'),
          // Scss entry
          error: resolve(__dirname, 'src/scss/error.scss'),
          rtl: resolve(__dirname, 'src/scss/rtl.scss'),
          theme: resolve(__dirname, 'src/scss/theme.scss'),
        },
        output: {
          inlineDynamicImports: false,
          format: 'iife',
          name: 'Theme',
          entryFileNames: (chunkInfo) => {
            if (chunkInfo.name === 'script') {
              return 'js/theme.js'
            }
            return 'js/[name].js'
          },
          assetFileNames: (assetInfo) => {
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

    plugins: [
      rtlTransformPlugin(),
    ],
  }
});
