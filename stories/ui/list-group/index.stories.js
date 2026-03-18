/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */
import listGroupContent from './list-group.html';

export default {
  title: 'UI/List group',
  parameters: {
    docs: {
      description: {
        component: 'List groups are used to display a series of content.'
      }
    }
  }
};

export const ListGroup = () => listGroupContent;
ListGroup.parameters = {
  docs: {
    source: {
      code: listGroupContent
    }
  }
};
