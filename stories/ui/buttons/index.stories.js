import basicsContent from './basics.html'
import outlineContent from './outline.html'
import disabledContent from './disabled.html'
import sizesContent from './sizes.html'
import transparentContent from './transparent.html'
import anchorContent from './anchor.html'
import withIconsContent from './with-icons.html'
import groupContent from './group.html'
import groupRadioContent from './group-radio.html'

export default {
  title: 'UI/Buttons',
  parameters: {
    docs: {
      description: {
        component: 'Buttons are used to trigger actions in forms, dialogs, and more.'
      }
    }
  }
};

export const Basics = () => basicsContent;
Basics.parameters = {
  docs: {
    source: {
      code: basicsContent
    },
    description: {
      story: 'Some basic buttons'
    }
  }
};

export const Outline = () => outlineContent;
Outline.parameters = {
  docs: {
    source: {
      code: outlineContent
    }
  }
};

export const Disabled = () => disabledContent;
Disabled.parameters = {
  docs: {
    source: {
      code: disabledContent
    },
    description: {
      story: 'Every buttons have this style when they\'re disabled.'
    }
  }
};

export const Sizes = () => sizesContent;
Sizes.parameters = {
  docs: {
    source: {
      code: sizesContent
    },
    description: {
      story: 'You are able to use different sizes of buttons'
    }
  }
};

export const Transparent = () => transparentContent;
Transparent.parameters = {
  docs: {
    source: {
      code: transparentContent
    }
  }
};

export const Anchor = () => anchorContent;
Anchor.parameters = {
  docs: {
    source: {
      code: anchorContent
    }
  }
};

export const WithIcons = () => withIconsContent;
WithIcons.parameters = {
  docs: {
    source: {
      code: withIconsContent
    }
  }
};
WithIcons.storyName = 'Buttons with icons';

export const Group = () => groupContent;
Group.parameters = {
  docs: {
    source: {
      code: groupContent
    }
  }
};
Group.storyName = 'Button group';

export const GroupRadio = () => groupRadioContent;
GroupRadio.parameters = {
  docs: {
    source: {
      code: groupRadioContent
    }
  }
};
GroupRadio.storyName = 'Button group with radio buttons';
