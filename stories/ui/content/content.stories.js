import contentHtml from './content.html';

export default {
  title: 'UI/Content',
  parameters: {
    docs: {
      description: {
        component: 'Here is the content markup you can use.'
      }
    }
  }
};

export const Content = () => contentHtml;
Content.parameters = {
  docs: {
    source: {
      code: contentHtml
    }
  }
};
