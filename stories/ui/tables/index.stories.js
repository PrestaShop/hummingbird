import basicContent from './basic.html'
import borderedContent from './bordered.html'
import hoverableContent from './hoverable.html'
import withfiltersContent from './withfilters.html'
import withformContent from './withform.html'
import stripedContent from './striped.html'
import sortableContent from './sortable.html'
import bootstrapContent from './bootstrap.html'
import darkContent from './dark.html'
import darkStripedContent from './dark-striped.html'
import darkHoverableContent from './dark-hoverable.html'
import darkBorderedContent from './dark-bordered.html'
import darkWithHeadContent from './dark-with-head.html'

export default {
  title: 'UI/Tables',
  parameters: {
    docs: {
      description: {
        component: 'Tables are used to display data in a structured format.'
      }
    }
  }
};

export const Basic = () => basicContent;
Basic.parameters = {
  docs: {
    source: {
      code: basicContent
    }
  }
};

export const Bordered = () => borderedContent;
Bordered.parameters = {
  docs: {
    source: {
      code: borderedContent
    }
  }
};

export const Hoverable = () => hoverableContent;
Hoverable.parameters = {
  docs: {
    source: {
      code: hoverableContent
    }
  }
};

export const WithFilters = () => withfiltersContent;
WithFilters.parameters = {
  docs: {
    source: {
      code: withfiltersContent
    }
  }
};
WithFilters.storyName = 'With filters';

export const WithForm = () => withformContent;
WithForm.parameters = {
  docs: {
    source: {
      code: withformContent
    }
  }
};
WithForm.storyName = 'With form';

export const Striped = () => stripedContent;
Striped.parameters = {
  docs: {
    source: {
      code: stripedContent
    }
  }
};

export const Sortable = () => sortableContent;
Sortable.parameters = {
  docs: {
    source: {
      code: sortableContent
    }
  }
};

export const Bootstrap = () => bootstrapContent;
Bootstrap.parameters = {
  docs: {
    source: {
      code: bootstrapContent
    }
  }
};

export const Dark = () => darkContent;
Dark.parameters = {
  docs: {
    source: {
      code: darkContent
    }
  }
};

export const DarkStriped = () => darkStripedContent;
DarkStriped.parameters = {
  docs: {
    source: {
      code: darkStripedContent
    }
  }
};
DarkStriped.storyName = 'Dark striped';

export const DarkHoverable = () => darkHoverableContent;
DarkHoverable.parameters = {
  docs: {
    source: {
      code: darkHoverableContent
    }
  }
};
DarkHoverable.storyName = 'Dark hoverable';

export const DarkBordered = () => darkBorderedContent;
DarkBordered.parameters = {
  docs: {
    source: {
      code: darkBorderedContent
    }
  }
};
DarkBordered.storyName = 'Dark bordered';

export const DarkWithHead = () => darkWithHeadContent;
DarkWithHead.parameters = {
  docs: {
    source: {
      code: darkWithHeadContent
    }
  }
};
DarkWithHead.storyName = 'Dark with head';
