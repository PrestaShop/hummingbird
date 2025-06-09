import badgesContent from './badges.html'
import pillsContent from './pills.html'
import notificationsContent from './notifications.html'

export default {
  title: 'UI/Badges',
  parameters: {
    docs: {
      description: {
        component: 'Badges are used to display status, counts, or labels.'
      }
    }
  }
};

export const Badges = () => badgesContent;
Badges.parameters = {
  docs: {
    source: {
      code: badgesContent
    }
  }
};
Badges.storyName = 'Badges';

export const Pills = () => pillsContent;
Pills.parameters = {
  docs: {
    source: {
      code: pillsContent
    }
  }
};
Pills.storyName = 'Pills';

export const Notifications = () => notificationsContent;
Notifications.parameters = {
  docs: {
    source: {
      code: notificationsContent
    }
  }
};
Notifications.storyName = 'Notifications pills';
