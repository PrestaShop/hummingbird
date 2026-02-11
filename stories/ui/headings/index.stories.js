import headingsContent from './headings.html';

export default {
  title: 'UI/Headings',
  parameters: {
    docs: {
      description: {
        component: 'Headings are used to display titles and section headers.'
      }
    }
  }
};

export const Headings = () => headingsContent;
Headings.parameters = {
  docs: {
    source: {
      code: headingsContent
    }
  }
};
