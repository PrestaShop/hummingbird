import navtabsContent from './navtabs.html';
import navWithoutBackgroundContent from './navtabs-without-background.html';

export default {
  title: 'UI/Navigation',
  parameters: {
    docs: {
      description: {
        component: 'Navigation components are used to create navigation menus and tabs.'
      }
    }
  }
};

export const NavigationTabs = () => navtabsContent;
NavigationTabs.parameters = {
  docs: {
    source: {
      code: navtabsContent
    },
    description: {
      story: 'Navigation tabs (Works with background)'
    }
  }
};
NavigationTabs.storyName = 'Navigation tabs';

export const NavigationPills = () => navWithoutBackgroundContent;
NavigationPills.parameters = {
  docs: {
    source: {
      code: navWithoutBackgroundContent
    },
    description: {
      story: 'Navigation pills (Works without background)'
    }
  }
};
NavigationPills.storyName = 'Navigation pills';
