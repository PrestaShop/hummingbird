/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import { defineConfig } from 'vite';
import { resolve } from 'path';
import fs from 'fs';
import cssjanus from 'cssjanus';
import { viteStaticCopy } from 'vite-plugin-static-copy';

// Load dotenv and postcss plugins
const dotenv = (await import('dotenv')).default;
const autoprefixer = (await import('autoprefixer')).default;

// Load environment variables
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

// RTL transformation plugin
function rtlTransformPlugin() {
  return {
    name: 'rtl-transform',
    generateBundle(options, bundle) {
      for (const fileName in bundle) {
        const file = bundle[fileName];
        if (file.type === 'asset' && fileName.includes('_rtl.css')) {
          // Transform CSS content for RTL
          file.source = cssjanus.transform(file.source);
        }
      }
    }
  };
}

// Font preload plugin (simplified version of webpack-font-preload-plugin)
function fontPreloadPlugin() {
  return {
    name: 'font-preload',
    generateBundle(options, bundle) {
      const fontFiles = [];
      for (const fileName in bundle) {
        const file = bundle[fileName];
        if (file.type === 'asset' && /\.(woff2?)$/i.test(fileName)) {
          if (/materialicons/i.test(fileName)) {
            fontFiles.push(fileName);
          }
        }
      }

      // Generate preload HTML
      const preloadLinks = fontFiles.map(file =>
        `<link rel="preload" href="../fonts/${file}" as="font" type="font/woff2" crossorigin>`
      ).join('\n');

      this.emitFile({
        type: 'asset',
        fileName: 'preload.html',
        source: preloadLinks
      });
    }
  };
}

// Plugin to wrap theme.js in IIFE with global Theme variable
function themeGlobalPlugin() {
  return {
    name: 'theme-global',
    generateBundle(options, bundle) {
      const themeFile = bundle['js/theme.js'];
      if (themeFile && themeFile.type === 'chunk') {
        // Wrap in IIFE with global Theme variable
        const wrappedCode = `var Theme = (function() {
${themeFile.code}
return {
  components: typeof components !== 'undefined' ? components : {},
  selectors: typeof selectors !== 'undefined' ? selectors : {},
  events: typeof events !== 'undefined' ? events : {}
};
})();`;
        themeFile.code = wrappedCode;
      }
    }
  };
}

export default defineConfig(({ command, mode }) => {
  const isDev = mode === 'development';

  return {
    root: resolve(__dirname, 'src'),
    base: isDev ? publicPath : './',

    build: {
      outDir: resolve(__dirname, 'assets'),
      emptyOutDir: true,
      assetsDir: '',
      rollupOptions: {
        input: {
          theme: resolve(__dirname, 'src/js/theme.ts'),
          error: resolve(__dirname, 'src/js/error.ts'),
          theme_rtl: resolve(__dirname, 'src/js/theme_rtl.ts'),
          error_rtl: resolve(__dirname, 'src/js/error_rtl.ts'),
          rtl: resolve(__dirname, 'src/js/rtl.ts'),
        },
        output: {
          entryFileNames: 'js/[name].js',
          chunkFileNames: isDev ? 'js/[id].js' : 'js/[hash].js',
          assetFileNames: (assetInfo) => {
            const info = assetInfo.name.split('.');
            const ext = info[info.length - 1];
            if (/png|jpe?g|svg|gif|tiff|bmp|ico/i.test(ext)) {
              return `img-dist/[hash][extname]`;
            }
            if (/woff2?|eot|ttf|otf/i.test(ext)) {
              return `fonts/[name]-[hash][extname]`;
            }
            if (ext === 'css') {
              return 'css/[name].css';
            }
            return '[name]-[hash][extname]';
          },
        },
        external: [],
      },
      manifest: false,
      sourcemap: isDev,
    },

    css: {
      preprocessorOptions: {
        scss: {
          api: 'modern',
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

    define: {
      global: 'globalThis',
    },

    server: {
      host: serverAddress,
      port: parseInt(port),
      cors: true,
      proxy: {
        [`^(?!${publicPath})`]: {
          target: siteURL,
          changeOrigin: true,
          secure: false,
        },
      },
      watch: {
        ignored: ['**/node_modules/**', '**/assets/**']
      }
    },

    plugins: [
      rtlTransformPlugin(),
      fontPreloadPlugin(),
      themeGlobalPlugin(),
      viteStaticCopy({
        targets: [
          {
            src: resolve(__dirname, 'src/img/**/*'),
            dest: 'img-dist',
            flatten: false,
          },
        ],
      }),
    ],

    // Expose jQuery globally (similar to expose-loader)
    optimizeDeps: {
      include: ['jquery'],
    },
  };
});
