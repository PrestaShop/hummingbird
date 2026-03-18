/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */
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
