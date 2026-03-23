/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */
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
