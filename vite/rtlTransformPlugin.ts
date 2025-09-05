import cssjanus from 'cssjanus';

export default function rtlTransformPlugin() {
  return {
    name: 'rtl-transform',
    generateBundle(options, bundle) {
      const newFiles = {};

      for (const fileName in bundle) {
        const file = bundle[fileName];
        if (file.type === 'asset' && fileName.endsWith('.css')) {
          const baseName = fileName.replace('.css', '');

          // Create RTL version for error.css and theme.css
          if (baseName === 'css/error' || baseName === 'css/theme') {
            const rtlFileName = `css/${baseName.replace('css/', '')}_rtl.css`;
            newFiles[rtlFileName] = {
              type: 'asset',
              fileName: rtlFileName,
              source: cssjanus.transform(file.source)
            };
          }
        }
      }

      // Add new RTL files to bundle
      Object.assign(bundle, newFiles);
    }
  };
}
