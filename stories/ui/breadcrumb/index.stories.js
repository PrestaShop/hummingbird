import breadcrumbContent from './breadcrumb.html';

export default {
  title: 'UI/Breadcrumb',
  parameters: {
    docs: {
      description: {
        component: 'Breadcrumbs are used to show the current page location within a navigational hierarchy.'
      }
    }
  }
};

export const Breadcrumb = () => breadcrumbContent;
Breadcrumb.parameters = {
  docs: {
    source: {
      code: breadcrumbContent
    }
  }
};
