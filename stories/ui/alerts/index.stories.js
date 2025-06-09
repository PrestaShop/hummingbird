import basicsContent from './basics.html'
import additionalContent from './additional.html'
import iconsContent from './icons.html'

export default {
  title: 'UI/Alerts',
  parameters: {
    docs: {
      description: {
        component: 'These alerts are used to display messages.'
      }
    }
  }
};

export const Basics = () => basicsContent;
Basics.parameters = {
  docs: {
    source: {
      code: basicsContent
    }
  }
};

export const Additional = () => additionalContent;
Additional.parameters = {
  docs: {
    source: {
      code: additionalContent
    }
  }
};

export const WithIcons = () => iconsContent;
WithIcons.parameters = {
  docs: {
    source: {
      code: iconsContent
    }
  }
};
