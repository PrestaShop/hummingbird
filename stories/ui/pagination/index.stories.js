import basicContent from './basic.html';

export default {
  title: 'UI/Pagination',
  parameters: {
    docs: {
      description: {
        component: 'Pagination is used to navigate between pages of content.'
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
