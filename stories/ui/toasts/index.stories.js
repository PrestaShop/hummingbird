import toastsContent from './toasts.html';
import extendedContent from './toasts-extended.html';

export default {
  title: 'UI/Toasts',
  parameters: {
    docs: {
      description: {
        component: 'Toasts are used to display non-disruptive messages to users.'
      }
    }
  }
};

export const Toasts = () => toastsContent;
Toasts.parameters = {
  docs: {
    source: {
      code: toastsContent
    },
    description: {
      story: 'Basic toasts'
    }
  }
};

export const ExtendedToasts = () => extendedContent;
ExtendedToasts.parameters = {
  docs: {
    source: {
      code: extendedContent
    },
    description: {
      story: 'Extended toasts'
    }
  }
};
ExtendedToasts.storyName = 'Extended toasts';
