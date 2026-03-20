/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */
import textsContent from './texts.html';

export default {
  title: 'UI/Texts',
  parameters: {
    docs: {
      description: {
        component: 'Here are every texts components you can use.'
      }
    }
  }
};

export const Texts = () => textsContent;
Texts.parameters = {
  docs: {
    source: {
      code: textsContent
    }
  }
};
