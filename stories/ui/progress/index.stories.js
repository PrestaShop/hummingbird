import progressContent from './progress.html';

export default {
  title: 'UI/Progress Bar',
  parameters: {
    docs: {
      description: {
        component: 'Progress bars are used to show the completion status of a task or process.'
      }
    }
  }
};

export const ProgressBar = () => progressContent;
ProgressBar.parameters = {
  docs: {
    source: {
      code: progressContent
    }
  }
};
