import dropdownsContent from './dropdowns.html'
import dropupContent from './dropup.html'
import variationsContent from './variations.html'
import withButtonSplitContent from './with-button-split.html'

export default {
  title: 'UI/Dropdowns',
  parameters: {
    docs: {
      description: {
        component: 'Dropdowns are toggleable, contextual overlays for displaying lists of links and more.'
      }
    }
  }
};

export const Basics = () => dropdownsContent;
Basics.parameters = {
  docs: {
    source: {
      code: dropdownsContent
    }
  }
};

export const Dropup = () => dropupContent;
Dropup.parameters = {
  docs: {
    source: {
      code: dropupContent
    }
  }
};

export const Variations = () => variationsContent;
Variations.parameters = {
  docs: {
    source: {
      code: variationsContent
    }
  }
};

export const WithButtonSplit = () => withButtonSplitContent;
WithButtonSplit.parameters = {
  docs: {
    source: {
      code: withButtonSplitContent
    }
  }
};
WithButtonSplit.storyName = 'With button split';
